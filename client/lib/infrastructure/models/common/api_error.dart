import 'package:chat_app/infrastructure/commons/enums/error_type_enum.dart';

class ApiError {
  int? code;
  String key;
  String? message;
  String field;

  ApiError({this.code = 0, this.key = '', this.message = '', this.field = ''});

  String get title {
    String title = 'No internet connection';
    switch (code) {
      case NetworkErrorType.connRefused:
      case NetworkErrorType.connTimedOut:
      case NetworkErrorType.netUnreachable:
        title = 'No internet connection';
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
        title = 'Service temporarily unavailable.';
        break;
      case UserErrorType.invalidCreditCard:
        title = 'Invalid Card';
        break;
      case UserErrorType.unknown:
        title = 'Unknown Error';
        break;
      case UserErrorType.emptyKeywordSearch:
      case UserErrorType.productSignedUpNotified:
      case UserErrorType.addProductToCartFailed:
        title = '';
        break;
      default:
        title = 'Oops! Something went wrong.';
        break;
    }
    return title;
  }

  String get body {
    String title = '';
    switch (code) {
      case NetworkErrorType.connRefused:
      case NetworkErrorType.connTimedOut:
      case NetworkErrorType.netUnreachable:
        title = 'Please check your internet connection.';
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
        title = 'Service temporarily unavailable. Please check back soon.';
        break;
      case UserErrorType.invalidCreditCard:
        title = 'Incorrect credit card info.\nPlease check and try again';
        break;
      case UserErrorType.emptyKeywordSearch:
        title = 'Sorry! There are no products matching your search.';
        break;
      case UserErrorType.addProductToCartFailed:
        title = 'Sorry, we are unable to add the item into your cart.';
        break;
      default:
        title = 'Please try again.';
        break;
    }
    return title;
  }

  String get bodyShort {
    String title = '';
    switch (code) {
      case NetworkErrorType.connRefused:
      case NetworkErrorType.connTimedOut:
      case NetworkErrorType.netUnreachable:
        title = 'No internet connection';
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
        title = 'Service temporarily unavailable.';
        break;
      case UserErrorType.invalidCreditCard:
        title = 'Invalid credit card.';
        break;
      case UserErrorType.emptyKeywordSearch:
        title = 'There are no products matching your search.';
        break;
      case UserErrorType.productSignedUpNotified:
        title = message ?? '';
        break;
      case UserErrorType.addProductToCartFailed:
        title = 'Oops, that didn\'t work. Please try again.';
        break;
      default:
        title = 'Oops! Something went wrong.';
        break;
    }
    return title;
  }
}
