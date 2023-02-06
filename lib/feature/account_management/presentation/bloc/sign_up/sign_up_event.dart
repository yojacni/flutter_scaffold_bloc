part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpNameChangedEvent extends SignUpEvent {
  const SignUpNameChangedEvent({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [
        name,
      ];
}

class SignUpEmailChangedEvent extends SignUpEvent {
  const SignUpEmailChangedEvent({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [
        email,
      ];
}

class SignUpPhoneNumberChangedEvent extends SignUpEvent {
  const SignUpPhoneNumberChangedEvent({
    required this.phoneNumber,
  });

  final String phoneNumber;

  @override
  List<Object> get props => [
        phoneNumber,
      ];
}

class SignUpPasswordChangedEvent extends SignUpEvent {
  const SignUpPasswordChangedEvent({
    required this.password,
  });

  final String password;

  @override
  List<Object> get props => [
        password,
      ];
}

class SignUpConfirmationPasswordChangedEvent extends SignUpEvent {
  const SignUpConfirmationPasswordChangedEvent({
    required this.confirmationPassword,
  });

  final String confirmationPassword;

  @override
  List<Object> get props => [
        confirmationPassword,
      ];
}

class SignUpSubmittedEvent extends SignUpEvent {
  @override
  List<Object> get props => [];
}
