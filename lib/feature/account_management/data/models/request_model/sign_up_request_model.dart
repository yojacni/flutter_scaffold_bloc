import 'package:equatable/equatable.dart';
import 'package:flutter_scaffold_bloc/core/global/entities/phone_number.dart';

class SignUpRequestModel extends Equatable {
  const SignUpRequestModel({
    required this.fullName,
    required this.password,
    required this.confirmationPassword,
    required this.email,
    required this.phoneNumber,
  });

  final String fullName;
  final String password;
  final String confirmationPassword;
  final String email;
  final PhoneNumber phoneNumber;

  @override
  List<Object?> get props => [
        fullName,
        password,
        confirmationPassword,
        email,
        phoneNumber,
      ];

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'password': password,
        'confirmationPassword': confirmationPassword,
        'email': email,
        'phone': phoneNumber.toJson()
      };
}
