import 'package:flutter/services.dart';

sealed class TextFormatter {
  static final _decimalRegex = RegExp(r'^\d+(\.\d{0,2})?$');

  /// Check for a valid number with up to two decimal places
  static final decimalFormatter = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      final text = newValue.text;

      return text.isEmpty || _decimalRegex.hasMatch(text) ? newValue : oldValue;
    },
  );
}
