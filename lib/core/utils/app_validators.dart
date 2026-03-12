// lib/utils/app_validators.dart

class AppValidators {
  /// Validator for generic non-empty fields.
  static String? validateEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validator for username.
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    // Regex for a valid username: 3-20 characters, alphanumeric and underscores.
    final RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    if (!usernameRegExp.hasMatch(value)) {
      return 'Username 3–20 characters';
    }
    return null;
  }

  /// Validator for email.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Regex for a valid email address.
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validator for mobile number.
  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    // Regex for a valid 10-digit mobile number.
    final RegExp mobileRegExp = RegExp(r'^[0-9]{10}$');
    if (!mobileRegExp.hasMatch(value)) {
      return 'Enter 10 digit mobile number';
    }
    return null;
  }

  /// Validator for OTP.
  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }
    return null;
  }

  /// Validator for password (can be used for both password and new password).
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Min 6 characters required';
    }
    // Regex for password strength (at least one uppercase, one lowercase, one digit, one special character).
    // final RegExp passwordRegExp = RegExp(
    //   r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    // );
    // if (!passwordRegExp.hasMatch(value)) {
    //   return 'Password must contain uppercase, lowercase, number, and a special character.';
    // }
    return null;
  }

  static String? loginValidatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Min 6 characters required';
    }

    return null;
  }

  /// Validator for confirm password.
  /// This requires the value of the original password controller.
  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Validator for Bank Name.
  static String? validateBankName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bank name is required';
    }
    final RegExp bankNameRegExp = RegExp(r'^[a-zA-Z ]{3,50}$');
    if (!bankNameRegExp.hasMatch(value)) {
      return 'Enter valid bank name (3–50 letters)';
    }
    return null;
  }

  /// Validator for Account Holder Name.
  static String? validateAccountHolderName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Account holder name is required';
    }
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]{3,50}$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Enter valid name (3–50 letters)';
    }
    return null;
  }

  /// Validator for Account Number.
  static String? validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Account number is required';
    }
    final RegExp accountNumberRegExp = RegExp(r'^[0-9]{9,18}$');
    if (!accountNumberRegExp.hasMatch(value)) {
      return 'Account number must be 9–18 digits';
    }
    return null;
  }

  /// Validator for Confirm Account Number.
  static String? validateConfirmAccountNumber(
    String? accountNumber,
    String? confirmAccountNumber,
  ) {
    if (confirmAccountNumber == null || confirmAccountNumber.isEmpty) {
      return 'Please confirm your account number';
    }
    if (accountNumber != confirmAccountNumber) {
      return 'Account numbers do not match';
    }
    return null;
  }

  /// Validator for IFSC Code.
  static String? validateIfscCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'IFSC code is required';
    }
    final RegExp ifscRegExp = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
    if (!ifscRegExp.hasMatch(value)) {
      return 'Please enter a valid IFSC code';
    }
    return null;
  }

  /// Validator for deposit amount.
  static String? validateDepositAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Deposit amount is required';
    }
    final double? amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid number';
    }
    if (amount <= 0) {
      return 'Amount must be greater than zero';
    }
    return null;
  }

  /// Validator for deposit amount.
  static String? validateWithdrawalAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Withdrawal amount is required';
    }
    final double? amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid number';
    }
    if (amount <= 0) {
      return 'Amount must be greater than zero';
    }
    return null;
  }

  /// Validator for UPI or generic transaction ID.
  static String? validateUpiOrTransactionId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Transaction ID is required';
    }
    // Generic regex for alphanumeric transaction IDs, typically 10 to 30 characters.
    // This accommodates various formats including 12-digit UPI reference numbers.
    // final RegExp transactionIdRegExp = RegExp(r'^[a-zA-Z0-9]{10,30}$');
    // if (!transactionIdRegExp.hasMatch(value)) {
    //   return 'Please enter a valid Transaction ID';
    // }
    return null;
  }

  static String? validateUPIId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'UPI ID is required';
    }

    final upi = value.trim();

    // Basic UPI pattern: username@bank
    final RegExp upiRegExp = RegExp(r'^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$');

    if (!upiRegExp.hasMatch(upi)) {
      return 'Enter a valid UPI ID (e.g. name@bank)';
    }

    return null;
  }

  static String? validateString({
    required String? value,
    String fieldName = 'Field',
    int minLength = 3,
    int maxLength = 50,
    bool allowSpecialCharacters = false,
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter this field';
    }

    // Minimum length validation
    if (value.length < minLength) {
      return 'Field must be at least required characters long';
    }

    // Maximum length validation
    if (value.length > maxLength) {
      return 'Field cannot be longer than maximum characters';
    }

    // Special character validation (optional)
    if (!allowSpecialCharacters) {
      final RegExp regExp = RegExp(r'^[a-zA-Z0-9 ]+$');
      if (!regExp.hasMatch(value)) {
        return 'Field can only contain letters, numbers, and spaces';
      }
    }

    return null; // Valid input
  }

  static String? validateInt({
    required String? value,
    String fieldName = 'Field',
    int minLength = 0,
    int maxLength = 50,
    bool allowSpecialCharacters = false,
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter this field';
    }

    // Minimum length validation
    if (value.length < minLength) {
      return 'Field must be at least required characters long';
    }

    // Maximum length validation
    if (value.length > maxLength) {
      return 'Field cannot be longer than maximum characters';
    }

    // Special character validation (optional)
    if (!allowSpecialCharacters) {
      final RegExp regExp = RegExp(r'^[a-zA-Z0-9 ]+$');
      if (!regExp.hasMatch(value)) {
        return 'Field can only contain letters, numbers, and spaces';
      }
    }

    return null; // Valid input
  }

  /// Validator for deposit amount.
  static String? validateOrderPrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Order price is required';
    }
    final double? amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a price';
    }
    if (amount <= 0) {
      return 'Price must be greater than zero';
    }
    return null;
  }

  static String? validateOrderQuantity(
    String? value, {
    int decimalPlaces = 0,
    double? maxQty,
  }) {
    if (value == null || value.isEmpty) {
      return 'Order qty is required';
    }

    final double? qty = double.tryParse(value);

    if (qty == null) {
      return 'Please enter a valid Qty';
    }

    if (qty <= 0) {
      return 'Qty must be greater than zero';
    }

    if (maxQty != null && qty > maxQty) {
      return 'Max quantity allowed is $maxQty';
    }

    if (decimalPlaces == 0 && value.contains(".")) {
      return 'Decimal not allowed';
    }

    if (value.contains(".")) {
      final decimalLength = value.split(".")[1].length;

      if (decimalLength > decimalPlaces) {
        return 'Max $decimalPlaces decimal allowed';
      }
    }

    return null;
  }
}
