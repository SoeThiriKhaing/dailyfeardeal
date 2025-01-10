import 'package:dailyfairdeal/config/messages.dart';

class Validators {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return validationMessages.passwordRequired;
    }

    if (value.length < 6) {
      return validationMessages.passwordMinLength;
    }

    final letterPattern = RegExp(r'[a-zA-Z]');
    if (!letterPattern.hasMatch(value)) {
      return validationMessages.passwordDigitRequired;
    }

    final digitPattern = RegExp(r'[0-9]');
    if (!digitPattern.hasMatch(value)) {
      return validationMessages.passwordDigitRequired;
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return validationMessages.emailRequired;
    }

    final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailPattern.hasMatch(value)) {
      return validationMessages.emailInvalid;
    }

    if (!value.endsWith('@gmail.com')) {
      return validationMessages.emailDomainInvalid;
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return validationMessages.nameRequired;
    }
    return null;
  }

  static String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return validationMessages.textFieldRequired;
    }
    return null;
  }
}
