import 'validation_patterns.dart';

class Validations {
  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required field';
    }

    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Required field';
    }

    return '';
  }

  static String validateConfirmPassword(
    String password,
    String? confirmationPassword,
  ) {
    if (confirmationPassword?.isEmpty ?? false) {
      return 'Required field';
    }

    if (confirmationPassword != password) {
      return 'Passwords does not match';
    }

    return '';
  }

  static String validatePasswordAndConfirmPassword(
    String password,
    String confirmationPassword,
  ) {
    if (password.isEmpty || confirmationPassword.isEmpty) {
      return 'All fields are Required';
    }

    if (password != confirmationPassword) {
      return 'Passwords does not match';
    }

    return '';
  }

  static String validateChangePassword({
    required String password,
    required String confirmationPassword,
    required String oldPassword,
  }) {
    if (password.isEmpty ||
        confirmationPassword.isEmpty ||
        oldPassword.isEmpty) {
      return 'All fields are Required';
    }

    if (password != confirmationPassword) {
      return 'Passwords does not match';
    }

    if (password == oldPassword) {
      return "The new password can't be the same";
    }

    return '';
  }

  static String? validateText(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Required field';
    }

    return '';
  }

  static String? validateZipCode(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Required field';
    }

    if (!ValidationPatterns.zipCodeRexExp.hasMatch(value ?? '')) {
      return 'Invalid Zip Code Format';
    }

    return '';
  }

  static String? validatePhoneNumber(String? value) {
    if (value?.isEmpty ?? false) {
      return 'Required field';
    }

    return '';
  }

  static String validateEmail(String? value) {
    if (value?.isEmpty ?? false) {
      return 'Required field';
    }

    if (!ValidationPatterns.emailRegExp.hasMatch(value ?? '')) {
      return 'Invalid Email Format';
    }

    return '';
  }
}
