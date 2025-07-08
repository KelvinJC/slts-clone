import 'package:intl/intl.dart';

/// Formats a number with commas as thousand separators,
/// and optionally enforces a certain number of decimals.
///
/// Examples:
/// ```dart
/// formatNumberWithCommas(1234567.89);      // "1,234,567.89"
/// formatNumberWithCommas(1234567, 0);      // "1,234,567"
/// ```
String formatNumberWithCommas(num number, [int decimalDigits = 2]) {
  final pattern =
      '#,##0${decimalDigits > 0 ? '.${List.filled(decimalDigits, '0').join()}' : ''}';
  final formatter = NumberFormat(pattern);
  return formatter.format(number);
}

/// Formats a [DateTime] to a localized date string (e.g. "Jul  8, 2025").
/// You can customize the date pattern as needed.
String formatDateShort(DateTime dt, {String pattern = 'MMM d, y'}) {
  return DateFormat(pattern).format(dt);
}

/// Parses a localized number string back to a [num].
/// Returns null if parsing fails.
num? parseFormattedNumber(String formatted) {
  try {
    return NumberFormat().parse(formatted);
  } catch (_) {
    return null;
  }
}
