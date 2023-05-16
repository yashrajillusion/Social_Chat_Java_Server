import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_app/infrastructure/commons/constants/api_constants.dart';
import 'package:chat_app/infrastructure/commons/enums/error_type_enum.dart';
import 'package:chat_app/infrastructure/commons/extensions/error_type_extension.dart';
import 'package:chat_app/infrastructure/data_access_layer/networks/api_response.dart';
import 'package:chat_app/infrastructure/data_access_layer/networks/application_error.dart';
import 'package:chat_app/infrastructure/models/common/api_error.dart';
import 'package:http/http.dart' as http;

class ApiResponseProvider {
  final bool _debug = false;

  Future<APIResponse> post(url,
      {Map<String, String?> headers = const {}, body, int timeout = ApiConstants.defaultTimeout}) async {
    var responseJson;
    try {
      final response = await http.post(url, headers: headers.cast<String, String>(), body: body);
      responseJson = await _processResponse(response);
    } on SocketException catch (e) {
      // Error tracking
      ApplicationError applicationError = NetworkError.getAppError(e.osError?.errorCode ?? 0);
      _trackError(applicationError.apiError(), url.path);
      return APIResponse.error({
        "success": false,
        "message": applicationError.apiError().message,
      });
    } catch (e) {
      // Error tracking
      ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
      _trackError(applicationError.apiError(), url.path);
    }
    return responseJson;
  }

  Future<APIResponse> put(url, {Map<String, String?> headers = const {}, body, int timeout = ApiConstants.defaultTimeout}) async {
    var responseJson;
    try {
      final response = await http.put(url, headers: headers.cast<String, String>(), body: body);
      responseJson = await _processResponse(response);
    } on SocketException catch (e) {
      // Error tracking
      ApplicationError applicationError = NetworkError.getAppError(e.osError?.errorCode ?? 0);
      _trackError(applicationError.apiError(), url.path);
      return APIResponse.error({
        "success": false,
        "message": applicationError.apiError().message,
      });
    } catch (e) {
      // Error tracking
      ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
      _trackError(applicationError.apiError(), url.path);
    }
    return responseJson;
  }

  Future<APIResponse> get(url, {Map<String, String?> headers = const {}, body, int timeout = ApiConstants.defaultTimeout}) async {
    var responseJson;
    try {
      final response = await http.get(url, headers: headers.cast<String, String>());
      responseJson = await _processResponse(response);
    } on SocketException catch (e) {
      // Error tracking
      ApplicationError applicationError = NetworkError.getAppError(e.osError?.errorCode ?? 0);
      _trackError(applicationError.apiError(), url.path);
      return APIResponse.error({
        "success": false,
        "message": applicationError.apiError().message,
      });
    } catch (e) {
      // Error tracking
      ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
      _trackError(applicationError.apiError(), url.path);
      return APIResponse.error({
        "success": false,
        "message": applicationError.apiError().message,
      });
    }
    return responseJson;
  }

  Future<APIResponse> patch(url,
      {Map<String, String?> headers = const {}, body, int timeout = ApiConstants.defaultTimeout}) async {
    var responseJson;
    try {
      final response = await http.patch(url, headers: headers.cast<String, String>(), body: body);
      responseJson = await _processResponse(response);
    } on SocketException catch (e) {
      // Error tracking
      ApplicationError applicationError = NetworkError.getAppError(e.osError?.errorCode ?? 0);
      _trackError(applicationError.apiError(), url.path);
      return APIResponse.error({
        "success": false,
        "message": applicationError.apiError().message,
      });
    } catch (e) {
      // Error tracking
      ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
      _trackError(applicationError.apiError(), url.path);
      return APIResponse.error({
        "success": false,
        "message": applicationError.apiError().message,
      });
    }
    return responseJson;
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var responseJson = json.decode(response.body.toString());
      var responseBody = responseJson;

      return APIResponse.success(responseBody);
    } else if (response.statusCode == 401) {
      var responseJson = json.decode(response.body.toString());
      // Error tracking
      ApplicationError applicationError = ErrorResponse.getAppError(response.statusCode);
      _trackError(applicationError.apiError(), response.request?.url.path);
      return APIResponse.error(responseJson);
    } else {
      var responseJson = json.decode(response.body.toString());
      // Error tracking
      ApplicationError applicationError = ErrorResponse.getAppError(response.statusCode);
      _trackError(applicationError.apiError(), response.request?.url.path);
      return APIResponse.error(responseJson);
    }
  }

  _trackError(ApiError error, String? path) {
    if (_debug) {}
  }
}
