import 'package:dio/dio.dart';

import '../../utils/logger.dart';

class LoggingInterceptors extends Interceptor {
  LoggingInterceptors(this._logger);

  final Logger _logger;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _logger
      ..error(
        "<-- ${err.message} ${err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL'}",
      )
      ..error(
        "${err.response != null ? err.response?.data : 'Unknown Error'}",
      )
      ..error('<-- End error');
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger
      ..information(
        "--> ${options.method.toUpperCase()} ${"${options.baseUrl}${options.path}"}",
      )
      ..information('Headers:');
    options.headers.forEach((k, v) => _logger.information('$k: $v'));

    _logger.information('queryParameters:');
    options.queryParameters.forEach((k, v) => _logger.information('$k: $v'));

    if (options.data != null) {
      _logger.information('Body: ${options.data}');
    }
    _logger.information(
      '--> END ${options.method.toUpperCase()}',
    );
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger
      ..debug(
        '<-- ${response.statusCode} ${response.requestOptions.baseUrl + response.requestOptions.path}',
      )
      ..debug('Headers:');
    response.headers.forEach((k, v) => _logger.debug('$k: $v'));
    _logger
      ..debug('Response: ${response.data}')
      ..debug('<-- END HTTP');
  }
}
