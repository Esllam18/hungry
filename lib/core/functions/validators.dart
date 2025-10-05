class AppValidators {
  /// ✅ Validate Name (First / Last)
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name cannot be empty';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  /// ✅ Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
    ).hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// ✅ Validate Password (Upper + Lower + Number + Length >= 6)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain upper, lower, and a number';
    }
    return null;
  }

  /// ✅ Validate Phone Number (E.164 format)
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }
    // E.164 regex: starts with +, country code (1–3 digits), then 4–14 digits
    final regex = RegExp(r'^\+[1-9]\d{1,14}$');
    if (!regex.hasMatch(value)) {
      return 'Enter phone in E.164 format (e.g. +201234567890)';
    }
    return null;
  }

  /// ✅ Validate Address
  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Address cannot be empty';
    } else if (value.length < 5) {
      return 'Address must be at least 5 characters';
    }
    return null;
  }

  /// ✅ Generic Non-empty Validator
  static String? validateRequired(String? value, {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  /// ✅ Validate Image
  static String? validateImage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Image cannot be empty';
    }
    return null;
  }

  /// ✅ Validate Video
  static String? validateVideo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Video cannot be empty';
    }
    return null;
  }

  // validateAdditionalInfo
  static String? validateAdditionalInfo(
    String? value, {
    String fieldName = "Additional Info",
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }
}
