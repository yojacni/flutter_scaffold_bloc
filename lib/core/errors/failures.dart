import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];

  String get message => '';
}

// General failures
class NotFoundLoginFailure extends Failure {
  @override
  List<Object> get props => [message];

  @override
  String get message => 'The user is not registered';
}

class EntityNotFoundFailure extends Failure {
  EntityNotFoundFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  final String message;
}

class UnauthorizedLoginFailure extends Failure {
  @override
  List<Object> get props => [message];

  @override
  String get message => 'Your password is not valid';
}

class ServerFailure extends Failure {
  ServerFailure({required this.message});

  @override
  final String message;

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {}

class DioCancelRequestFailure extends Failure {}

class NetworkFailure extends Failure {
  @override
  List<Object> get props => [message];

  @override
  String get message => 'No connection to Internet';
}

class OtherFailure extends Failure {
  @override
  List<Object> get props => [message];

  @override
  String get message => 'Something went wrong';
}
