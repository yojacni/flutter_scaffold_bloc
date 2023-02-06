import 'package:dio/dio.dart';

import '../../../di/injector.dart';
import '../../utils/logger.dart';

class DioClient {
  DioClient(this._dio, this._logger) {
    _dio
      ..options.baseUrl = Injector.apiBaseUrl
      //  ..options.connectTimeout = Endpoint.connectionTimeout
      // ..options.receiveTimeout = Endpoint.receiveTimeout
      ..options.responseType = ResponseType.json;
  }
// dio instance
  final Dio _dio;
  final Logger _logger;

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    _logger.information('''
      REQUEST: GET,
      URL: $url,
      QueryParameters: $queryParameters,
      Content-Type: ${options?.contentType},
      Headers: ${options?.headers}
      ''');
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      _logger.debug(response);
      return response;
    } catch (e) {
      _logger.error(e);
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response<dynamic>> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _logger.information('''
      REQUEST: POST,
      DATA: $data,
      URL: $url,
      QueryParameters: $queryParameters,
      Content-Type: ${options?.contentType},
      Headers: ${options?.headers},
      ''');
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _logger.debug(response);
      return response;
    } catch (e) {
      _logger.error((e as DioError).response!.data["message"].toString());
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _logger.information('''
      REQUEST: PUT,
      DATA: $data,
      URL: $url,
      QueryParameters: $queryParameters,
      Content-Type: ${options?.contentType},
      Headers: ${options?.headers},
      ''');
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _logger.debug(response);
      return response;
    } catch (e) {
      _logger.error(e);
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _logger.information('''
      REQUEST: DELETE,
      DATA: $data,
      URL: $url,
      QueryParameters: $queryParameters,
      Content-Type: ${options?.contentType},
      Headers: ${options?.headers},
      ''');
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      _logger.debug(response);
      return response.data;
    } catch (e) {
      _logger.error(e);
      rethrow;
    }
  }
}
