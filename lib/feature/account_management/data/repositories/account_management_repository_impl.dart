import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_scaffold_bloc/feature/account_management/domain/entity/user_profile.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/connectivity.dart';
import '../../../../core/platform/shared_prefs.dart';
import '../../domain/repository/account_management_repository.dart';
import '../datasources/remote/account_management_remote_datasource.dart';
import '../models/request_model/login_request_model.dart';
import '../models/request_model/sign_up_request_model.dart';
import '../models/response_model/login_response_model.dart';
import '../models/response_model/sign_up_response_model.dart';

class AccountManagementRepositoryImpl extends AccountManagementRepository {
  AccountManagementRepositoryImpl(
    this._api,
    this.sharedPreferencesManager,
    this.connectivityService,
  );

  final AccountManagementRemoteApi _api;
  final UserPreferencesManager sharedPreferencesManager;
  final ConnectivityService connectivityService;

  @override
  Future<Either<Failure, LoginResponseModel>> login(
    LoginRequestModel request,
  ) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }

      final res = await _api.login(request);

      await sharedPreferencesManager.setUserId(res.user.id);

      return Right(res);
    } catch (ex) {
      if (ex is ServerException) {
        return Left(ServerFailure(message: ex.message));
      } else if (ex is NotFoundException) {
        return Left(NotFoundLoginFailure());
      } else if (ex is UnauthorizedException) {
        return Left(UnauthorizedLoginFailure());
      } else {
        return Left(OtherFailure());
      }
    }
  }

  @override
  Future<Either<Failure, SignUpResponseModel>> signUp(
    SignUpRequestModel request,
  ) async {
    try {
      if (connectivityService.connectionStatus == ConnectionStatus.offline) {
        return Left(NetworkFailure());
      }

      await _api.signUp(request);

      return const Right(
        SignUpResponseModel(
          response: true,
        ),
      );
    } catch (ex) {
      if (ex is DioError) {
        return Left(
          ServerFailure(message: ex.response!.data['message'].toString()),
        );
      } else {
        return Left(OtherFailure());
      }
    }
  }
}
