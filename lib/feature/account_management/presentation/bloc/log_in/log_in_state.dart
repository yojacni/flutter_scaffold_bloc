part of 'log_in_bloc.dart';

@immutable
class LoginState extends Equatable {
  const LoginState({
    this.status = SubmissionStatusEnum.initial,
    this.email = '',
    this.password = '',
    this.passwordErrorText = 'Required field',
    this.emailErrorText = 'Required field',
  });

  final SubmissionStatusEnum status;
  final String email;
  final String password;

  final String passwordErrorText;
  final String emailErrorText;

  LoginState copyWith({
    SubmissionStatusEnum? status,
    String? email,
    String? password,
    String? passwordErrorText,
    String? emailErrorText,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordErrorText: passwordErrorText ?? this.passwordErrorText,
      emailErrorText: emailErrorText ?? this.emailErrorText,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        passwordErrorText,
        emailErrorText,
      ];
}
