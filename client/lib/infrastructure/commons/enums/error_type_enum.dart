enum ErrorType {
  networkError,
  serverError,
  appError,
  serializationError,
  genericError,
  networkForbiddenError,
  networkUnAuthorizedError,
  decodingError,
  encodingError,
  noResponse,
  dataError,
  databaseError,
  userError
}

/// define enum for error reason
enum Reason {
  unknown,
  invalidCreditCard,
  invalidPaypal,
  emptyKeywordSearch,
  invalidData,
  productSignedUpNotified,
  addProductToCartFailed,
  emptyCmsPage,
  applicationSchemaError,
  captchaChallenge,
  noLoginCredentials
}

///define user error type code
abstract class UserErrorType {
  static const unknown = 125000;
  static const invalidCreditCard = 125100;
  static const emptyKeywordSearch = 125200;
  static const invalidData = 125300;
  static const productSignedUpNotified = 125400;
  static const addProductToCartFailed = 125500;
  static const emptyCmsPage = 125600;
  static const applicationSchemaError = 125700;
  static const captchaChallenge = 125800;
}

///define network error type dode
abstract class NetworkErrorType {
  static const operationNotPermitted = 1; //EPERM
  static const outOfMem = 12; //ENOMEM
  static const permissionDenied = 13; //EACCES
  static const badAddress = 14; //EFAULT
  static const invalidArgument = 22; //EINVAL
  static const netDown = 100; //ENETDOWN
  static const netUnreachable = 101; //ENETUNREACH
  static const netReset = 102; //ENETRESET
  static const connTimedOut = 110; //ETIMEDOUT
  static const connRefused = 111; //ECONNREFUSED
  static const hostDown = 112; //EHOSTDOWN
  static const hostUnreachable = 113; //EHOSTUNREACH
}
