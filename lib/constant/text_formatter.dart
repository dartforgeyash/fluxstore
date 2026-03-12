import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class DateTimeHelper {
  /// Normalize API format
  static String _normalize(String pattern) {
    if (pattern.isEmpty) return 'd MMM yyyy';

    return pattern
        .replaceAll("YYYY", "yyyy")
        .replaceAll("YY", "yy")
        .replaceAll("DD", "dd")
        .replaceAll("D", "d");
  }

  /// Safe DateTime
  static DateTime? _safe(DateTime? dateTime, {bool toLocal = true}) {
    try {
      if (dateTime == null) return null;
      return toLocal ? dateTime.toLocal() : dateTime;
    } catch (_) {
      return null;
    }
  }

  /// Day suffix (st, nd, rd, th)
  static String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  /// Returns BOTH separately
  static Map<String, String> formatDateTime(
    DateTime? dateTime, {
    String datePattern = 'd MMM yyyy',
    String timePattern = 'HH:mm',
    bool toLocal = true,
    bool withSuffix = false,
  }) {
    final dt = _safe(dateTime, toLocal: toLocal);

    if (dt == null) {
      return {"date": "", "time": ""};
    }

    try {
      String datePart;

      /// Date
      if (withSuffix) {
        final day = dt.day;
        final suffix = _getDaySuffix(day);

        final month = DateFormat('MMMM').format(dt);
        final year = DateFormat('yy').format(dt);

        datePart = "$day$suffix $month $year";
      } else {
        final normalizedDate = _normalize(datePattern);
        datePart = DateFormat(normalizedDate).format(dt);
      }

      /// Time
      final normalizedTime = _normalize(timePattern);
      final timePart = DateFormat(normalizedTime).format(dt);

      return {"date": datePart, "time": timePart};
    } catch (_) {
      return {"date": "", "time": ""};
    }
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalRange;

  DecimalTextInputFormatter({required this.decimalRange});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String value = newValue.text;

    if (decimalRange == 0) {
      return FilteringTextInputFormatter.digitsOnly.formatEditUpdate(
        oldValue,
        newValue,
      );
    }

    if (value.isEmpty) {
      return newValue;
    }

    final regEx = RegExp(r'^\d+\.?\d{0,' + decimalRange.toString() + r'}');

    if (regEx.hasMatch(value)) {
      return newValue;
    }

    return oldValue;
  }
}

String formatQuantity({required String quantity, required int decimalPlaces}) {
  double value = double.tryParse(quantity) ?? 0;
  return value.toStringAsFixed(decimalPlaces);
}
