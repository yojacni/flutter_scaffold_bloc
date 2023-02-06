import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_scaffold_bloc/core/global/entities/phone_number.dart';

import '../../../../../core/global/app_globals.dart';
import '../../../../../core/global/entities/enums/submission_status_enum.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/logger.dart';
import '../../../../../core/utils/validations/validations.dart';
import '../../../data/models/request_model/sign_up_request_model.dart';
import '../../../domain/usecase/sign_up_usecase.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._signUpUseCase, this._logger) : super(const SignUpState()) {
    on<SignUpNameChangedEvent>(_onNameChanged);
    on<SignUpEmailChangedEvent>(_onEmailChanged);

    on<SignUpPhoneNumberChangedEvent>(_onPhoneNumberChanged);
    on<SignUpPasswordChangedEvent>(_onPasswordChanged);
    on<SignUpConfirmationPasswordChangedEvent>(_onConfirmPasswordChanged);
    on<SignUpSubmittedEvent>(_onSignUpSubmitted);
  }

  final SignUpUseCase _signUpUseCase;
  final Logger _logger;

  Future<void> _onNameChanged(
    SignUpNameChangedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final validationErrorText = Validations.validateText(event.name);
    emit(
      state.copyWith(
        name: event.name,
        nameErrorText: validationErrorText,
      ),
    );
  }

  Future<void> _onEmailChanged(
    SignUpEmailChangedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final validationErrorText = Validations.validateEmail(event.email);
    emit(
      state.copyWith(
        email: event.email,
        emailErrorText: validationErrorText,
      ),
    );
  }

  Future<void> _onPhoneNumberChanged(
    SignUpPhoneNumberChangedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final validationErrorText =
        Validations.validatePhoneNumber(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: event.phoneNumber,
        phoneErrorText: validationErrorText,
      ),
    );
  }

  Future<void> _onPasswordChanged(
    SignUpPasswordChangedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final validationErrorText = Validations.validatePassword(event.password);
    final validationConfirmErrorText = Validations.validateConfirmPassword(
      event.password,
      state.confirmationPassword,
    );
    emit(
      state.copyWith(
        password: event.password,
        passwordErrorText: validationErrorText,
        confirmationPasswordErrorText: validationConfirmErrorText,
      ),
    );
  }

  Future<void> _onConfirmPasswordChanged(
    SignUpConfirmationPasswordChangedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final validationErrorText = Validations.validateConfirmPassword(
      state.password,
      event.confirmationPassword,
    );
    emit(
      state.copyWith(
        confirmationPassword: event.confirmationPassword,
        confirmationPasswordErrorText: validationErrorText,
      ),
    );
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmittedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(status: SubmissionStatusEnum.sent));

    if (state.nameErrorText.isNotEmpty ||
        state.emailErrorText.isNotEmpty ||
        state.phoneErrorText.isNotEmpty ||
        state.passwordErrorText.isNotEmpty ||
        state.confirmationPasswordErrorText.isNotEmpty) {
      emit(state.copyWith(status: SubmissionStatusEnum.fail));
      return;
    }

    final resp = await _signUpUseCase(
      Params(
        SignUpRequestModel(
          fullName: state.name,
          email: state.email,
          password: state.password,
          confirmationPassword: state.confirmationPassword,
          phoneNumber: PhoneNumber(
            code: state.codePhoneNumber,
            number: state.phoneNumber,
          ),
        ),
      ),
    );
    emit(
      resp.fold((l) {
        _logger.error(l);
        AppGlobals.showErrorMessage(l.message);
        return state.copyWith(status: SubmissionStatusEnum.fail);
      }, (r) {
        AppGlobals.showSuccessMessage('Account created successfully');
        return state.copyWith(status: SubmissionStatusEnum.success);
      }),
    );
  }
}
