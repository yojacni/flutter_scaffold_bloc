part of 'sign_up_bloc.dart';

@immutable
class SignUpState extends Equatable {
  const SignUpState({
    this.status = SubmissionStatusEnum.initial,
    this.name = '',
    this.nameErrorText = 'Required field',
    this.email = '',
    this.emailErrorText = 'Required field',
    this.phoneNumber = '',
    this.codePhoneNumber = '+1',
    this.phoneErrorText = 'Required field',
    this.password = '',
    this.passwordErrorText = 'Required field',
    this.confirmationPassword = '',
    this.confirmationPasswordErrorText = 'Required field',
  });

  final SubmissionStatusEnum status;
  final String name;
  final String nameErrorText;
  final String email;
  final String emailErrorText;
  final String codePhoneNumber;
  final String phoneNumber;
  final String phoneErrorText;
  final String password;
  final String passwordErrorText;
  final String confirmationPassword;
  final String confirmationPasswordErrorText;

  SignUpState copyWith({
    SubmissionStatusEnum? status,
    String? name,
    String? nameErrorText,
    String? email,
    String? emailErrorText,
    String? phoneNumber,
    String? codePhoneNumber,
    String? phoneErrorText,
    String? password,
    String? passwordErrorText,
    String? confirmationPassword,
    String? confirmationPasswordErrorText,
  }) {
    return SignUpState(
      status: status ?? this.status,
      name: name ?? this.name,
      nameErrorText: nameErrorText ?? this.nameErrorText,
      email: email ?? this.email,
      emailErrorText: emailErrorText ?? this.emailErrorText,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      codePhoneNumber: codePhoneNumber ?? this.codePhoneNumber,
      phoneErrorText: phoneErrorText ?? this.phoneErrorText,
      password: password ?? this.password,
      passwordErrorText: passwordErrorText ?? this.passwordErrorText,
      confirmationPassword: confirmationPassword ?? this.confirmationPassword,
      confirmationPasswordErrorText:
          confirmationPasswordErrorText ?? this.confirmationPasswordErrorText,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        nameErrorText,
        email,
        emailErrorText,
        phoneNumber,
        codePhoneNumber,
        phoneErrorText,
        password,
        passwordErrorText,
        confirmationPassword,
        confirmationPasswordErrorText,
      ];
}
