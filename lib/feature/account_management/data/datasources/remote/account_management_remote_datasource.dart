// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import '../../../../../core/errors/exception.dart';
import '../../../../../core/global/endpoints.dart';
import '../../../../../core/network/network_handler.dart';
import '../../models/request_model/login_request_model.dart';
import '../../models/request_model/sign_up_request_model.dart';
import '../../models/response_model/login_response_model.dart';
import '../../models/response_model/sign_up_response_model.dart';

abstract class AccountManagementRemoteApi {
  Future<LoginResponseModel> login(LoginRequestModel request);

  Future<SignUpResponseModel> signUp(SignUpRequestModel request);
}

class AccountManagementRemoteApiImpl extends AccountManagementRemoteApi {
  AccountManagementRemoteApiImpl(this.networkHandler);

  final NetworkHandler networkHandler;

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final resp = await networkHandler.login(
        body: request.toJson(),
        url: Endpoint.login,
        persistAuth: false,
      );
      if (resp.statusCode == 200 || resp.statusCode == 204) {
        return LoginResponseModel.fromJson(
          json.decode(resp.body)['result'] as Map<String, dynamic>,
        );
      } else {
        throw ServerException(
          message: jsonDecode(resp.body)['message'].toString(),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SignUpResponseModel> signUp(SignUpRequestModel request) async {
    try {
      final resp = await networkHandler.post(
        path: Endpoint.signUp,
        data: request.toJson(),
      );
      if (resp.statusCode == 200 ||
          resp.statusCode == 204 ||
          resp.statusCode == 201) {
        return const SignUpResponseModel(response: true);
      } else if (resp.statusCode == 404) {
        throw NotFoundException();
      } else if (resp.statusCode == 401) {
        throw UnauthorizedException();
      } else if (resp.statusCode == 400) {
        throw ServerException(message: resp.statusMessage ?? '');
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
