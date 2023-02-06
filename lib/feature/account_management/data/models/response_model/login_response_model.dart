import 'package:equatable/equatable.dart';

import '../../../domain/entity/user_profile.dart';

class LoginResponseModel extends Equatable {
  const LoginResponseModel({
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        user: UserProfile.fromJson(json),
      );

  final UserProfile user;

  @override
  List<Object?> get props => [
        user,
      ];
}
