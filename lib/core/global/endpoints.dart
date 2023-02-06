class Endpoint {
  //DEV
  static const apiBaseUrlDev = '';
  static const hubConnectionDev = '';
  static const azureStorageDev = '';

  //STG
  static const apiBaseUrlStg = '';
  static const hubConnectionStg = '';
  static const azureStorageStg = '';

  //PROD
  static const apiBaseUrlProd = '';
  static const hubConnectionProd = '';
  static const azureStorageProd = '';

  /* ACCOUNT Endpoints */
  static const login = '/api/account/login';
  static const signUp = '/api/account/signup';
  static const refreshToken = '/api/account/refresh-token';

  static const sendEmailContact = '/api/account/send-email-contact';

//Codes

  static const String unableHostMessage = 'Failed host lookup:';
  static const int codeSuccess = 200;
  static const int codeSuccessCreated = 201;
  static const int codeSuccess_204 = 204;
  static const int codeNotFound = 400;
  static const int codeUnauthorized = 401;
  static const int codeForbidden = 403;
  static const int codeBadRequest = 404;
  static const int codeServerError = 500;
  static const int codeServerErrorMax = 599;
  static const int codeServerError_502 = 502;

  //Custom status codes
  static const int customCodeServerBadRequestOldAndNewPasswordAreSame = 400021;

  static const String token = 'token';
}
