import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow clearing the field
    if (newValue.text.isEmpty) {
      return TextEditingValue.empty;
    }

    // Remove any existing commas and other non-numeric characters except decimal point
    String newUnformattedText =
        newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Ensure that only one decimal point is allowed
    if (newUnformattedText.indexOf('.') !=
        newUnformattedText.lastIndexOf('.')) {
      // If there is more than one decimal point, return the old value
      return oldValue;
    }

    // Handle case where the input ends with more than one zero after the decimal
    bool endsWithDecimal = newUnformattedText.endsWith('.');
    bool endsWithZeroAfterDecimal =
        newUnformattedText.contains('.') && newUnformattedText.endsWith('0');

    // Prevent trailing unnecessary zeros after decimal points
    if (!endsWithDecimal &&
        endsWithZeroAfterDecimal &&
        newUnformattedText.split('.').last.length > 2) {
      return oldValue;
    }

    // Attempt to parse the new value to ensure it's a valid number
    num? newDoubleValue = num.tryParse(newUnformattedText);
    if (newUnformattedText.isNotEmpty && newDoubleValue == null) {
      // If parsing fails (e.g., due to invalid input like an incomplete decimal), return the oldValue
      return oldValue;
    }

    // Format the number with commas (without affecting the decimal part if it exists)
    String newFormattedText = NumberFormat('#,##0.##').format(newDoubleValue);

    // Preserving decimal point and following zeros
    if (endsWithDecimal) {
      newFormattedText += '.';
    } else if (endsWithZeroAfterDecimal) {
      newFormattedText +=
          newUnformattedText.substring(newUnformattedText.indexOf('.'));
    }

    // Ensure the cursor does not exceed the length of the new text
    int cursorPosition = newValue.selection.end;
    int offsetFromEnd = newUnformattedText.length - cursorPosition;
    int newCursorPosition = newFormattedText.length - offsetFromEnd;

    // Adjust the cursor position to ensure it's within the bounds of the new text length
    newCursorPosition = newCursorPosition > newFormattedText.length
        ? newFormattedText.length
        : newCursorPosition;
    newCursorPosition = newCursorPosition < 0 ? 0 : newCursorPosition;

    return TextEditingValue(
      text: newFormattedText,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }
}
