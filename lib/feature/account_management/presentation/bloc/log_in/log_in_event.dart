part of 'log_in_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChangedEvent extends LoginEvent {
  const LoginEmailChangedEvent({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [
        email,
      ];
}

class LoginPasswordChangedEvent extends LoginEvent {
  const LoginPasswordChangedEvent({
    required this.password,
  });

  final String password;

  @override
  List<Object> get props => [
        password,
      ];
}

class LoginButtonPressedEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}
