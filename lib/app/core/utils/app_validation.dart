import 'package:flutter/material.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/core/utils/app_regex.dart';

class AppValidators {
  /// Validate email field
  static String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return AppLocale(context).enterYourEmail;
    } else if (!AppRegex.isEmailValid(value.trim())) {
      return AppLocale(context).thisEmailIsNotValid;
    }
    return null;
  }

  /// Validate password field
  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocale(context).enterYourPassword;
    } else if (!AppRegex.hasMinLength(value)) {
      return AppLocale(context).passwordMinLength;
    } else if (!AppRegex.hasUpperCase(value)) {
      return AppLocale(context).passwordUpperCase;
    } else if (!AppRegex.hasLowerCase(value)) {
      return AppLocale(context).passwordLowerCase;
    } else if (!AppRegex.hasNumber(value)) {
      return AppLocale(context).passwordNumber;
    } else if (!AppRegex.hasSpecialCharacter(value)) {
      return AppLocale(context).passwordSpecialChar;
    }
    return null;
  }

  /// Validate confirm password field
  static String? validateConfirmPassword(
    String? value,
    String? originalPassword,
    BuildContext context,
  ) {
    if (value == null || value.isEmpty) {
      return AppLocale(context).confirmPasswordRequired;
    } else if (value != originalPassword) {
      return AppLocale(context).passwordNotMatched;
    }

    return null;
  }

  /// Validate name field
  static String? validateUserName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocale(context).userNameRequired;
    }
    return null;
  }

  /// Validate phone field
  static String? validateNumberPhone(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocale(context).phoneNumberRequired;
    }
    return null;
  }

  static String? validateFirstName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocale(context).firstNameRequired;
    }
    return null;
  }

  static String? validateLastName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocale(context).lastNameRequired;
    }
    return null;
  }
}
