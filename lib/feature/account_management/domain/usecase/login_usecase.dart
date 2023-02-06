import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/request_model/login_request_model.dart';
import '../../data/models/response_model/login_response_model.dart';
import '../repository/account_management_repository.dart';

class LoginUsecase
    implements UseCase<LoginResponseModel, Params<LoginRequestModel>> {
  LoginUsecase(this.repository);
  final AccountManagementRepository repository;

  @override
  Future<Either<Failure, LoginResponseModel>> call(
    Params<LoginRequestModel> params,
  ) async {
    return repository.login(params.request);
  }
}
