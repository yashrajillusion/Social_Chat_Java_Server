import 'package:chat_app/infrastructure/commons/constants/api_constants.dart';
import 'package:chat_app/infrastructure/commons/enums/error_type_enum.dart';
import 'package:chat_app/infrastructure/commons/extensions/error_type_extension.dart';
import 'package:chat_app/infrastructure/data_access_layer/networks/api_response.dart';
import 'package:chat_app/infrastructure/data_access_layer/networks/api_response_provider.dart';
import 'package:chat_app/infrastructure/data_access_layer/networks/application_error.dart';
import 'package:chat_app/infrastructure/models/response/create_account_response_modal.dart';
import 'package:chat_app/infrastructure/models/response/get_all_messages_by_id_response.dart';
import 'package:chat_app/infrastructure/models/response/get_all_users.dart';
import 'package:chat_app/infrastructure/models/response/get_all_users_by_id_response_modal.dart';
import 'package:chat_app/infrastructure/models/response/login_account_response_modal.dart';
import 'package:chat_app/infrastructure/models/response/send_message_response_modal.dart';
import 'package:flutter/foundation.dart';

class AccountRepository {
  final ApiResponseProvider _apiResponseProvider = ApiResponseProvider();

  Future<ApiHttpResult> createAccount(
    Object requestParams,
  ) async {
    const createAccountUrl = '${ApiConstants.baseUrl}/user';
    final uri = Uri.parse(createAccountUrl);

    APIResponse result = await _apiResponseProvider.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: requestParams,
    );
    switch (result.status) {
      case APIStatus.SUCCESS:
        var createAccountResponse = await compute(
          CreateAccountResponsemodal.parseInfo,
          result.response,
        );
        return ApiHttpResult.success(createAccountResponse);
      case APIStatus.ERROR:
        return ApiHttpResult.error(result.response);
      default:
        ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
        return ApiHttpResult.error(applicationError);
    }
  }

  Future<ApiHttpResult> loginAccount(
    Object requestParams,
  ) async {
    const loginAccountUrl = '${ApiConstants.baseUrl}/user/login';
    final uri = Uri.parse(loginAccountUrl);

    APIResponse result = await _apiResponseProvider.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: requestParams,
    );
    switch (result.status) {
      case APIStatus.SUCCESS:
        var loginAccountResponse = await compute(
          LoginAccountResponseModal.parseInfo,
          result.response,
        );
        return ApiHttpResult.success(loginAccountResponse);
      case APIStatus.ERROR:
        return ApiHttpResult.error(result.response);
      default:
        ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
        return ApiHttpResult.error(applicationError);
    }
  }

  Future<ApiHttpResult> getAllUsers() async {
    const getAllUsers = '${ApiConstants.baseUrl}/user';
    final uri = Uri.parse(getAllUsers);

    APIResponse result = await _apiResponseProvider.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    switch (result.status) {
      case APIStatus.SUCCESS:
        var getAllUser = await compute(
          GetAllUsers.parseInfo,
          result.response,
        );
        return ApiHttpResult.success(getAllUser);
      case APIStatus.ERROR:
        return ApiHttpResult.error(result.response);
      default:
        ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
        return ApiHttpResult.error(applicationError);
    }
  }

  Future<ApiHttpResult> getAllUsersById({required String chatId}) async {
    final getAllUsersById = '${ApiConstants.baseUrl}/chats/user/$chatId';
    final uri = Uri.parse(getAllUsersById);

    APIResponse result = await _apiResponseProvider.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    switch (result.status) {
      case APIStatus.SUCCESS:
        var getAllUserById = await compute(
          GetUsersByIdResponseModal.parseInfo,
          result.response,
        );

        return ApiHttpResult.success(getAllUserById);
      case APIStatus.ERROR:
        return ApiHttpResult.error(result.response);
      default:
        ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
        return ApiHttpResult.error(applicationError);
    }
  }

  Future<ApiHttpResult> getAllMessagesById({required String chatId}) async {
    final getAllUserChat = '${ApiConstants.baseUrl}/message/$chatId';
    final uri = Uri.parse(getAllUserChat);

    APIResponse result = await _apiResponseProvider.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    switch (result.status) {
      case APIStatus.SUCCESS:
        var getAllUser = await compute(
          GetAllMessagesByIdResponse.parseInfo,
          result.response,
        );
        return ApiHttpResult.success(getAllUser);
      case APIStatus.ERROR:
        return ApiHttpResult.error(result.response);
      default:
        ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
        return ApiHttpResult.error(applicationError);
    }
  }

  Future<ApiHttpResult> sendMessageRequest(
    Object requestParams,
  ) async {
    const sentMessageUrl = '${ApiConstants.baseUrl}/message';
    final uri = Uri.parse(sentMessageUrl);

    APIResponse result = await _apiResponseProvider.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: requestParams,
    );
    switch (result.status) {
      case APIStatus.SUCCESS:
        var createAccountResponse = await compute(
          SendMessageResponseModal.parseInfo,
          result.response,
        );
        return ApiHttpResult.success(createAccountResponse);
      case APIStatus.ERROR:
        return ApiHttpResult.error(result.response);
      default:
        ApplicationError applicationError = ApplicationError(errorType: ErrorType.genericError.messageString);
        return ApiHttpResult.error(applicationError);
    }
  }
}
