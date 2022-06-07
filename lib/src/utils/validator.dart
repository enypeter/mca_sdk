import '../const.dart';

class EmailValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return emptyEmailField;
    }
    // Regex for email validation
    final regExp = RegExp(emailRegex);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return invalidEmailField;
  }
}

class PhoneNumberValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }

    if (value.length != 11) {
      return phoneNumberLengthError;
    }
    // Regex for phone number validation
    final regExp = RegExp(phoneNumberRegex);
    print(regExp.hasMatch(value));
    if (regExp.hasMatch(value)) {
      return null;
    }
    return invalidPhoneNumberField;
  }
}

class FieldValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }

    return null;
  }
}
