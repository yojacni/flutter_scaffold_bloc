import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/global/app_globals.dart';
import '../../../../../core/global/entities/enums/submission_status_enum.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/logger.dart';
import '../../../../../core/utils/validations/validations.dart';
import '../../../data/models/request_model/login_request_model.dart';
import '../../../domain/usecase/login_usecase.dart';

part 'log_in_event.dart';

part 'log_in_state.dart';

class LogInBloc extends Bloc<LoginEvent, LoginState> {
  LogInBloc(this._logInUseCase, this._logger) : super(const LoginState()) {
    on<LoginEmailChangedEvent>(_onEmailChanged);
    on<LoginPasswordChangedEvent>(_onPasswordChanged);

    on<LoginButtonPressedEvent>(_onLoginButtonPressed);
  }

  final LoginUsecase _logInUseCase;
  final Logger _logger;

  Future<void> _onEmailChanged(
    LoginEmailChangedEvent event,
    Emitter<LoginState> emit,
  ) async {
    final validationErrorText = Validations.validateEmail(event.email);
    emit(
      state.copyWith(
        email: event.email,
        emailErrorText: validationErrorText,
      ),
    );
  }

  Future<void> _onPasswordChanged(
    LoginPasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) async {
    final validationErrorText = Validations.validatePassword(event.password);
    emit(
      state.copyWith(
        password: event.password,
        passwordErrorText: validationErrorText,
      ),
    );
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: SubmissionStatusEnum.sent));

    if (state.emailErrorText.isNotEmpty || state.passwordErrorText.isNotEmpty) {
      emit(state.copyWith(status: SubmissionStatusEnum.fail));
      return;
    }
    final resp = await _logInUseCase(
      Params(
        LoginRequestModel(
          email: state.email,
          password: state.password,
        ),
      ),
    );
    emit(
      resp.fold((l) {
        _logger.error(l);
        AppGlobals.showErrorMessage(l.message);
        return state.copyWith(status: SubmissionStatusEnum.fail);
      }, (r) {
        return state.copyWith(status: SubmissionStatusEnum.success);
      }),
    );
  }
}
