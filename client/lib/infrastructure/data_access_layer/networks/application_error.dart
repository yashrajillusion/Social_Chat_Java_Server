import 'package:chat_app/infrastructure/commons/enums/error_type_enum.dart';
import 'package:chat_app/infrastructure/commons/extensions/error_type_extension.dart';
import 'package:chat_app/infrastructure/models/common/api_error.dart';
import 'package:flutter/material.dart';

class ApplicationError {
  List<ApiError> errors;
  String? errorType;

  ApplicationError({this.errorType, this.errors = const []});

  ApiError apiError() {
    return (errors.isEmpty)
        ? ApplicationError(errorType: ErrorType.genericError.messageString, errors: [ApiError(code: 0, message: '')]).errors.first
        : errors.first;
  }

  String get firstBodyText => errors.isNotEmpty ? errors.first.body : '';
  String get firstShortBodyText => errors.isNotEmpty ? errors.first.bodyShort : '';
  String get firstTitleText => errors.isNotEmpty ? errors.first.title : '';
  String get firstFieldText => errors.isNotEmpty ? errors.first.field : '';
}

Locale? locale;

abstract class ErrorResponse {
  static ApplicationError getAppError(int statusCode) {
    String? errorType;
    String? message;
    int code;
    // getLanguageCode();

    if (statusCode == 403) {
      errorType = ErrorType.networkForbiddenError.messageString;
      code = NetworkErrorType.netUnreachable;
      message = "Please check your internet connection.";
    } else if (statusCode == 401) {
      errorType = ErrorType.networkUnAuthorizedError.messageString;
      code = NetworkErrorType.netUnreachable;
      message = "Please check your internet connection.";
    } else if (statusCode >= 400 && statusCode <= 499) {
      errorType = ErrorType.networkError.messageString;
      code = NetworkErrorType.netUnreachable;
      message = "Please check your internet connection.";
    } else if (statusCode >= 500 && statusCode <= 599) {
      errorType = ErrorType.serverError.messageString;
      code = NetworkErrorType.hostUnreachable;
      message = "Service temporarily unavailable. Please check back soon.";
    } else if (statusCode == -1) {
      errorType = ErrorType.noResponse.messageString;
      code = NetworkErrorType.netUnreachable;
      message = "Please check your internet connection.";
    } else {
      errorType = ErrorType.appError.messageString;
      code = statusCode;
    }

    return ApplicationError(errorType: errorType, errors: [ApiError(code: code, message: message, key: '$code')]);
  }
}

abstract class NetworkError {
  static ApplicationError getAppError(int statusCode) {
    String? errorType;
    String message;
    int code;
    // getLanguageCode();

    switch (statusCode) {
      case NetworkErrorType.connRefused:
      case NetworkErrorType.connTimedOut:
      case NetworkErrorType.netUnreachable:
        errorType = ErrorType.networkError.messageString;
        code = statusCode;
        message = "Please check your internet connection.";
        break;
      case NetworkErrorType.hostDown:
      case NetworkErrorType.netDown:
      case NetworkErrorType.netReset:
      case NetworkErrorType.hostUnreachable:
      case NetworkErrorType.invalidArgument:
      case NetworkErrorType.badAddress:
      case NetworkErrorType.operationNotPermitted:
      case NetworkErrorType.permissionDenied:
      case NetworkErrorType.outOfMem:
        errorType = ErrorType.networkError.messageString;
        code = statusCode;
        message = 'Service temporarily unavailable. Please check back soon.';
        break;
      default:
        errorType = '';
        code = 0;
        message = '';
        break;
    }

    return ApplicationError(errorType: errorType, errors: [ApiError(code: code, message: message, key: '$code')]);
  }
}

abstract class UserError {
  static ApplicationError getAppError(Reason reason) {
    String? message;
    int? code;

    switch (reason) {
      case Reason.unknown:
        code = 0;
        message = 'Oops! Something went wrong.\nPlease try again.';
        break;
      case Reason.invalidCreditCard:
        code = UserErrorType.invalidCreditCard;
        message = 'Incorrect credit card info.\nPlease check and try again.';
        break;
      case Reason.invalidPaypal:
        code = 0;
        message = 'Sorry we cannot place your paypal order for now. Please try again later';
        break;
      case Reason.emptyKeywordSearch:
        code = 0;
        message = 'Sorry! There are no products matching your search.';
        break;
      case Reason.invalidData:
        code = UserErrorType.invalidData;
        message = 'Invalid data.';
        break;
      case Reason.productSignedUpNotified:
        code = UserErrorType.productSignedUpNotified;
        message = 'You\'re already signed up to be notified as soon as this item is back in stock.';
        break;
      case Reason.addProductToCartFailed:
        code = UserErrorType.addProductToCartFailed;
        message = 'Sorry, we are unable to add the item into your cart.';
        break;
      case Reason.emptyCmsPage:
        code = UserErrorType.emptyCmsPage;
        message = 'Please try again.';
        break;
      case Reason.applicationSchemaError:
        code = UserErrorType.applicationSchemaError;
        message = 'Oops! Something went wrong.';
        break;
      case Reason.captchaChallenge:
        code = UserErrorType.captchaChallenge;
        message = 'Our systems have detected unusual traffic from your network. Please try again later.';
        break;
      case Reason.noLoginCredentials:
        code = 0;
        message = 'User has no sign-in credentials';
        break;
    }

    return ApplicationError(
        errorType: ErrorType.userError.messageString, errors: [ApiError(code: code, message: message, key: '$code')]);
  }
}
