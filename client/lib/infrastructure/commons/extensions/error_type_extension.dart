import 'package:chat_app/infrastructure/commons/enums/error_type_enum.dart';

extension ErrorTypeExtension on ErrorType {
  String get messageString {
    switch (this) {
      case ErrorType.networkError:
        return 'Network Error';
      case ErrorType.serverError:
        return 'Server Error';
      case ErrorType.appError:
        return 'Application Error';
      case ErrorType.serializationError:
        return 'Serialization Error';
      case ErrorType.genericError:
        return 'Generic Error';
      case ErrorType.networkForbiddenError:
        return 'Network Forbidden Error';
      case ErrorType.networkUnAuthorizedError:
        return 'Network UnAuthorized Error';
      case ErrorType.decodingError:
        return 'Decoding Error';
      case ErrorType.encodingError:
        return 'Encoding Error';
      case ErrorType.noResponse:
        return 'No Response';
      case ErrorType.dataError:
        return 'Data Error';
      case ErrorType.databaseError:
        return 'Database Error';
      case ErrorType.userError:
        return 'User Error';
      default:
        return '';
    }
  }
}
