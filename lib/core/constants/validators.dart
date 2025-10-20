// This file contains static methods for form field validation.

class Validators {
  // FIX: Updated to a more robust RegEx to correctly validate addresses
  // like 'junaidriaz194@gmail.com'.
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$",
  );

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!_emailRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Simple check for complexity (must contain at least one digit and one letter)
    if (!value.contains(RegExp(r'[0-9]')) ||
        !value.contains(RegExp(r'[a-zA-Z]'))) {
      return 'Password must contain letters and numbers';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }
}
