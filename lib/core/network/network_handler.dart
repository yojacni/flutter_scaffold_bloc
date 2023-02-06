import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../di/injector.dart';
import '../global/endpoints.dart';
import '../platform/shared_prefs.dart';
import '../utils/logger.dart';
import 'dio/dio_client.dart';

class NetworkHandler {
  NetworkHandler(this._sharedP, this._logger, this._dioClient);

  final Logger _logger;
  final UserPreferencesManager _sharedP;
  final DioClient _dioClient;

  ///Returns the common headers with authentication values
  Future<Map<String, String>> _commonHeaders() async {
    final v = {
      'Authorization': await _sharedP.getAccessToken(),
      'Content-Type': 'application/json'
    };

    return v;
  }

  ///Returns the common headers with authentication values
  Future<Map<String, String>> _multipartHeaders() async {
    final v = {
      'Authorization': await _sharedP.getAccessToken(),
      'Content-Type': 'multipart/form-data'
    };

    return v;
  }

  ///Get operations.
  ///-The base URL by default is the one provided by the Injector.
  ///-The [path] is mandatory
  ///-The request already handles authentication
  ///-The request already handles refresh token implementation
  Future<http.Response> get({
    required String path,
    String params = '',
    bool baseUrl = true,
    Map<String, String> header = const {},
  }) async {
    var _url = '';
    if (baseUrl) {
      _url = Injector.apiBaseUrl + path + params;
    } else {
      _url = path;
    }
    final _headers = await _commonHeaders();

    try {
      _logger
        ..information('-> GET: $_url')
        ..information('')
        ..information('-> HEADERS: $_headers');

      final res = await http.get(Uri.parse(_url), headers: _headers);

      _logger
        ..information('<- RESPONSE CODE: ${res.statusCode}')
        ..information('<- RESPONSE BODY: ${res.body}');
      if (res.statusCode == Endpoint.codeUnauthorized) {
        final refreshResult = await _refreshToken();
        if (refreshResult.statusCode == Endpoint.codeSuccess) {
          final _newHeaders = await _commonHeaders();
          final resAfterRefresh =
              await http.get(Uri(path: _url), headers: _newHeaders);
          return resAfterRefresh;
        } else {
          return refreshResult;
        }
      }
      return res;
    } catch (ex) {
      _logger.error('<- EXCEPTION: $ex');
      rethrow;
    }
  }

  ///Post operations.
  ///-The base URL by default is the one provided by the Injector.
  ///-The [path] is mandatory
  ///-The request's content type is application/json
  ///-The request already handles authentication
  ///-The request already handles refresh token implementation
  Future<Response<dynamic>> post({
    required String path,
    String params = '',
    Map<String, dynamic> data = const {},
  }) async {
    final url = Injector.apiBaseUrl + path + params;
    final headers = await _commonHeaders();

    try {
      _logger
        ..information('-> POST: $url')
        ..information('-> HEADERS: $headers')
        ..information('-> DATA: $data');

      final res = await _dioClient.post(
        url,
        data: data,
        options: Options(
          headers: headers,
        ),
      );

      _logger
        ..information('<- RESPONSE CODE: ${res.statusCode}')
        ..information('<- RESPONSE BODY: ${res.data}');

      if (res.statusCode == Endpoint.codeUnauthorized) {
        final refreshResult = await _refreshToken();
        if (refreshResult.statusCode == Endpoint.codeSuccess) {
          final newHeaders = await _commonHeaders();
          final resAfterRefresh = await _dioClient.post(
            url,
            data: data,
            options: Options(
              headers: newHeaders,
            ),
          );
          return resAfterRefresh;
        } else {
          return refreshResult as Response;
        }
      }

      return res;
    } catch (ex) {
      _logger.error('<- EXCEPTION: $ex');
      rethrow;
    }
  }

  Future<http.Response> postMailGmail({
    required String path,
    required Map<String, String> header,
    String params = '',
    String body = '',
  }) async {
    final _url = path;
    final _headers = header;

    try {
      _logger
        ..information('-> POST: $_url')
        ..information('-> HEADERS: $_headers')
        ..information('-> BODY: $body');
      final res =
          await http.post(Uri.parse(_url), headers: _headers, body: body);
      _logger
        ..information('<- RESPONSE CODE: ${res.statusCode}')
        ..information('<- RESPONSE BODY: ${res.body}');

      return res;
    } catch (ex) {
      _logger.error('<- EXCEPTION: $ex');
      rethrow;
    }
  }

  ///Put operations.
  ///-The base URL by default is the one provided by the Injector.
  ///-The [path] is mandatory
  ///-The request's content type is application/json
  ///-The request already handles authentication
  ///-The request already handles refresh token implementation
  Future<http.Response> put({
    required String path,
    String params = '',
    required String body,
    Map<String, String> headers = const {},
  }) async {
    final _url = Injector.apiBaseUrl + path + params;
    final _headers = await _commonHeaders();
    try {
      _logger
        ..information('-> PUT: $_url')
        ..information('-> HEADERS: $_headers')
        ..information('-> BODY: $body');
      final res =
          await http.put(Uri.parse(_url), headers: _headers, body: body);
      _logger
        ..information('<- RESPONSE CODE: ${res.statusCode}')
        ..information('<- RESPONSE BODY: ${res.body}');
      if (res.statusCode == Endpoint.codeUnauthorized) {
        final refreshResult = await _refreshToken();
        if (refreshResult.statusCode == Endpoint.codeSuccess) {
          final _newHeaders = await _commonHeaders();
          final resAfterRefresh =
              await http.put(Uri(path: _url), headers: _newHeaders, body: body);
          return resAfterRefresh;
        } else {
          return refreshResult;
        }
      }
      return res;
    } catch (ex) {
      _logger.error('<- EXCEPTION: $ex');
      rethrow;
    }
  }

  ///Patch operations.
  ///-The base URL by default is the one provided by the Injector.
  ///-The [path] is mandatory
  ///-The request's content type is application/json
  ///-The request already handles authentication
  ///-The request already handles refresh token implementation
  Future<http.Response> patch({
    required String path,
    String params = '',
    required String body,
    Map<String, String> headers = const {},
  }) async {
    final _url = Injector.apiBaseUrl + path + params;
    final _headers = await _commonHeaders();
    try {
      _logger
        ..information('-> PATCH: $_url')
        ..information('-> HEADERS: $_headers')
        ..information('-> BODY: $body');
      final res =
          await http.patch(Uri.parse(_url), headers: _headers, body: body);
      _logger
        ..information('<- RESPONSE CODE: ${res.statusCode}')
        ..information('<- RESPONSE BODY: ${res.body}');
      if (res.statusCode == Endpoint.codeUnauthorized) {
        final refreshResult = await _refreshToken();
        if (refreshResult.statusCode == Endpoint.codeSuccess) {
          final _newHeaders = await _commonHeaders();
          final resAfterRefresh = await http.patch(
            Uri(path: _url),
            headers: _newHeaders,
            body: body,
          );
          return resAfterRefresh;
        } else {
          return refreshResult;
        }
      }
      return res;
    } catch (ex) {
      _logger.error('<- EXCEPTION: $ex');
      rethrow;
    }
  }

  ///Delete operations.
  ///-The base URL by default is the one provided by the Injector.
  ///-The [path] is mandatory
  ///-The request already handles authentication
  ///-The request already handles refresh token implementation
  Future<http.Response> delete({
    required String path,
    String params = '',
    Map<String, String> headers = const {},
  }) async {
    final _url = Injector.apiBaseUrl + path + params;
    final _headers = await _commonHeaders();
    try {
      _logger
        ..information('-> DELETE: $_url')
        ..information('-> HEADERS: $_headers');
      final res = await http.delete(Uri.parse(_url), headers: _headers);
      _logger
        ..information('<- RESPONSE CODE: ${res.statusCode}')
        ..information('<- RESPONSE BODY: ${res.body}');
      if (res.statusCode == Endpoint.codeUnauthorized) {
        final refreshResult = await _refreshToken();
        if (refreshResult.statusCode == Endpoint.codeSuccess) {
          final _newHeaders = await _commonHeaders();
          final resAfterRefresh =
              await http.delete(Uri(path: _url), headers: _newHeaders);
          return resAfterRefresh;
        } else {
          return refreshResult;
        }
      }
      return res;
    } catch (ex) {
      _logger.error('<- EXCEPTION: $ex');
      rethrow;
    }
  }

  Future<http.Response> login({
    required String url,
    required Map<String, dynamic> body,
    required bool persistAuth,
  }) async {
    try {
      final _url = Injector.apiBaseUrl + url;
      final headers = {'Content-Type': 'application/json'};
      _logger
        ..information('-> POST: $_url')
        ..information('-> BODY: $body');
      final res = await http.post(
        Uri.parse(_url),
        headers: headers,
        body: json.encode(body),
      );
      _logger
        ..information('<- RESPONSE CODE: ${res.statusCode}')
        ..information('<- RESPONSE BODY: ${res.body}');

      if (res.statusCode == 200 || res.statusCode == 204) {
        await _sharedP.setAccessToken(res.headers['authorization'] ?? '');
        await _sharedP.setRefreshToken(res.headers['refreshtoken'] ?? '');
        await _sharedP.setPersistAuth(newValue: persistAuth);
      }

      return res;
    } catch (ex) {
      _logger.error('<- EXCEPTION: $ex');
      rethrow;
    }
  }

  Future<http.Response> logOut({
    required String url,
  }) async {
    try {
      final _url = Injector.apiBaseUrl + url;
      final headers = {'Content-Type': 'application/json'};
      _logger.information('-> POST: $_url');
      final res = await http.post(
        Uri.parse(_url),
        headers: headers,
      );
      _logger
        ..information('<- RESPONSE CODE: ${res.statusCode}')
        ..information('<- RESPONSE BODY: ${res.body}');

      await _sharedP.cleanAll();
      return res;
    } catch (ex) {
      _logger.error('<- EXCEPTION: $ex');
      await _sharedP.cleanAll();
      rethrow;
    }
  }

  Future<http.Response> validateToken() async {
    _logger.information('-> Sending Refresh Token');

    final url = Injector.apiBaseUrl + Endpoint.refreshToken;

    final accessToken = await _sharedP.getAccessToken();
    final refreshToken = await _sharedP.getRefreshToken();
    final userId = await _sharedP.getUserId();

    final body = userId.toString();

    try {
      _logger
        ..information('-> POST: $url')
        ..information('-> BODY: $body');
      final headers = {
        'accept': 'text/plain',
        'Content-Type': 'application/json-patch+json',
        'accessToken': accessToken.startsWith('Bearer ')
            ? accessToken.split('Bearer ')[1]
            : accessToken,
        'refreshToken': refreshToken,
      };

      final res = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      _logger
        ..information('<- RESPONSE CODE: ${res.statusCode}')
        ..information('<- RESPONSE BODY: ${res.body}')
        ..information('<- RESPONSE HEADERS: ${res.headers}');
      await _sharedP.setAccessToken(res.headers['authorization'] ?? '');
      await _sharedP.setRefreshToken(res.headers['refreshtoken'] ?? '');

      return res;
    } catch (ex) {
      await _sharedP.cleanAll();
      _logger.error('<- EXCEPTION: $ex');
      rethrow;
    }
  }

  Future<http.Response> _refreshToken() async {
    _logger.information('-> Sending Refresh Token');

    final url = Injector.apiBaseUrl + Endpoint.refreshToken;

    final accessToken = await _sharedP.getAccessToken();
    final refreshToken = await _sharedP.getRefreshToken();
    final userId = await _sharedP.getUserId();

    final body = userId.toString();

    try {
      _logger
        ..information('-> POST: $url')
        ..information('-> BODY: $body');
      final _headers = {
        'accept': 'text/plain',
        'Content-Type': 'application/json-patch+json',
        'accessToken': accessToken.startsWith('Bearer ')
            ? accessToken.split('Bearer ')[1]
            : accessToken,
        'refreshToken': refreshToken,
      };

      _logger.information('-> HEADERS: $_headers');

      final res =
          await http.post(Uri.parse(url), headers: _headers, body: body);
      _logger
        ..information('<- RESPONSE CODE: ${res.statusCode}')
        ..information('<- RESPONSE BODY: ${res.body}');

      await _sharedP.setAccessToken(res.headers['authorization'] ?? '');
      await _sharedP.setRefreshToken(res.headers['refreshtoken'] ?? '');

      return res;
    } catch (ex) {
      await _sharedP.cleanAll();
      rethrow;
    }
  }
}
