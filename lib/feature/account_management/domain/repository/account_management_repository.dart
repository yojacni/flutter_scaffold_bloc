import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/request_model/login_request_model.dart';
import '../../data/models/request_model/sign_up_request_model.dart';
import '../../data/models/response_model/login_response_model.dart';
import '../../data/models/response_model/sign_up_response_model.dart';
import '../entity/user_profile.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AccountManagementStatus extends Equatable {
  const AccountManagementStatus();

  @override
  List<Object?> get props => [];
}

abstract class AccountManagementRepository {
  Future<Either<Failure, LoginResponseModel>> login(LoginRequestModel request);

  Future<Either<Failure, SignUpResponseModel>> signUp(
    SignUpRequestModel request,
  );
}
