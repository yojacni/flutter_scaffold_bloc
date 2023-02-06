import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/request_model/sign_up_request_model.dart';
import '../../data/models/response_model/sign_up_response_model.dart';
import '../repository/account_management_repository.dart';

class SignUpUseCase
    implements UseCase<SignUpResponseModel, Params<SignUpRequestModel>> {
  SignUpUseCase(this.repository);
  final AccountManagementRepository repository;

  @override
  Future<Either<Failure, SignUpResponseModel>> call(
    Params<SignUpRequestModel> params,
  ) async {
    return repository.signUp(params.request);
  }
}
