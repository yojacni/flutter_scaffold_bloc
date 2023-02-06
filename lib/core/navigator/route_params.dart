import '../global/entities/enums/navigate_from_enum.dart';

abstract class RouteParams {}

class PhoneNumberVerificationPageParams extends RouteParams {
  PhoneNumberVerificationPageParams({
    required this.navigateFrom,
    required this.codeCountry,
    required this.phoneNumber,
    required this.phoneIsoCode,
  });

  final NavigateFrom navigateFrom;
  final String codeCountry;
  final String phoneNumber;
  final String phoneIsoCode;
}
