import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _numberFormat = NumberFormat('#,###');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow empty input
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove all non-digit characters
    final String cleanedText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // If no digits remain, return empty
    if (cleanedText.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Parse the number
    final int? number = int.tryParse(cleanedText);
    if (number == null) {
      return oldValue;
    }

    // Format number with commas
    final String formatted = _numberFormat.format(number);

    // Calculate cursor position
    final int oldCursorPosition = oldValue.selection.base.offset;
    
    // Count commas before cursor in old text
    int commasBeforeCursor = 0;
    for (int i = 0; i < oldCursorPosition && i < oldValue.text.length; i++) {
      if (oldValue.text[i] == ',') {
        commasBeforeCursor++;
      }
    }
    
    // Calculate position in cleaned text (without commas)
    final int positionInCleanedText = oldCursorPosition - commasBeforeCursor;
    
    // Find new cursor position in formatted text
    int newCursorPosition = 0;
    int digitCount = 0;
    for (int i = 0; i < formatted.length; i++) {
      if (formatted[i] != ',') {
        digitCount++;
        if (digitCount >= positionInCleanedText) {
          newCursorPosition = i + 1;
          break;
        }
      }
      newCursorPosition = i + 1;
    }
    
    // Ensure cursor doesn't exceed text length
    newCursorPosition = newCursorPosition.clamp(0, formatted.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }
}


class VatFormatters {
  static String formatCurrency(double value) {
    if (value == 0) return '₦0';
    return '₦${NumberFormat('#,###').format(value)}';
  }

  static double parseFormattedNumber(String value) {
    return double.parse(value.replaceAll(',', '').replaceAll('₦', ''));
  }
}