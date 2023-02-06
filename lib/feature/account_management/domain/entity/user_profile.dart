import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_scaffold_bloc/core/global/entities/phone_number.dart';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str) as Map<String, dynamic>);

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.birthDate,
    required this.fullName,
    required this.userName,
    required this.identity,
    required this.genderId,
    required this.gender,
    required this.email,
    required this.phone,
    required this.statusId,
    required this.status,
    required this.avatar,
    required this.avatarMimeType,
  });

  final int id;
  final String birthDate;
  final String fullName;
  final String? userName;
  final String identity;
  final int genderId;
  final String gender;
  final String email;
  final PhoneNumber phone;
  final int statusId;
  final String status;
  final String avatar;
  final String? avatarMimeType;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'] as int,
        birthDate: json['birthDate'] as String,
        fullName: json['fullName'] as String,
        userName: json['userName'] as String?,
        identity: json['identity'] as String,
        genderId: json['genderId'] as int,
        gender: json['gender'] as String,
        email: json['email'] as String,
        phone: PhoneNumber.fromJson(json['phone'] as Map<String, dynamic>),
        statusId: json['statusId'] as int,
        status: json['status'] as String,
        avatar: json['avatar'] as String,
        avatarMimeType: json['avatarMimeType'] as String?,
      );

  @override
  List<Object?> get props => [
        id,
        birthDate,
        fullName,
        userName,
        identity,
        genderId,
        gender,
        email,
        phone,
        statusId,
        status,
        avatar,
        avatarMimeType,
      ];

  static const empty = UserProfile(
    avatar: '',
    avatarMimeType: '',
    birthDate: '',
    email: '',
    fullName: '',
    gender: '',
    genderId: 0,
    id: -1,
    identity: '',
    phone: PhoneNumber(code: '', number: ''),
    status: '',
    statusId: 0,
    userName: '',
  );

  UserProfile copyWith({
    int? id,
    String? birthDate,
    String? fullName,
    String? userName,
    String? identity,
    int? genderId,
    String? gender,
    String? email,
    PhoneNumber? phone,
    int? statusId,
    String? status,
    String? avatar,
    String? avatarMimeType,
  }) {
    return UserProfile(
      id: id ?? this.id,
      birthDate: birthDate ?? this.birthDate,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      identity: identity ?? this.identity,
      genderId: genderId ?? this.genderId,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      statusId: statusId ?? this.statusId,
      status: status ?? this.status,
      avatar: avatar ?? this.avatar,
      avatarMimeType: avatarMimeType ?? this.avatarMimeType,
    );
  }
}
