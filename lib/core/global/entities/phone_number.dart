import 'package:equatable/equatable.dart';

class PhoneNumber extends Equatable {
  const PhoneNumber({
    required this.code,
    required this.number,
  });

  final String code;
  final String number;

  @override
  List<Object?> get props => [
        code,
        number,
      ];

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
        code: json['code'] as String,
        number: json['number'] as String,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'number': number,
      };
}
