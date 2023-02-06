import 'package:dio/dio.dart';

class CacheInterceptor extends Interceptor {
  var _cache = new Map<Uri, Response>();

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.receiveTimeout) {
      final cachedResponse = _cache[err.requestOptions.uri];
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {}

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _cache[response.requestOptions.uri] = response;
  }
}
