import 'package:equatable/equatable.dart';

class SignUpResponseModel extends Equatable {
  const SignUpResponseModel({required this.response});

  final bool response;

  @override
  List<Object?> get props => [
    response,
  ];
}
