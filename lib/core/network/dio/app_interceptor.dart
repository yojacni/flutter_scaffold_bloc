import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptor implements Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.message.contains('ERROR_001')) {
      // this will push a new route and remove
      //all the routes that were present
    }
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers.containsKey('requiresToken')) {
      //remove the auxiliary header
      options.headers.remove('requiresToken');

      final prefs = await SharedPreferences.getInstance();
      final header = prefs.get('Header');

      options.headers.addAll({'Header': '$header${DateTime.now()}'});
    }
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.headers.value('verifyToken') != null) {
      //if the header is present, then compare it with the Shared Prefs key
      final prefs = await SharedPreferences.getInstance();
      final verifyToken = prefs.get('VerifyToken');

      // if the value is the same as the header, continue with the request
      if (response.headers.value('verifyToken') == verifyToken) {}
    }
  }
}
