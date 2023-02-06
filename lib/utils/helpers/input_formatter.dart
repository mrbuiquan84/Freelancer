import 'package:flutter/services.dart';

class InputFormatter {
  static get nameFormatter =>
      [FilteringTextInputFormatter.deny(RegExp(r'[\n]'))];

  static get phoneFormatter => [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ];

  static get passwordFormatter => [
        FilteringTextInputFormatter.deny(
          RegExp(r'[ ]'),
        ),
        FilteringTextInputFormatter.deny(
          RegExp(r'\n'),
        ),
        LengthLimitingTextInputFormatter(20),
      ];

  static get emailFormatter => [
        FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
        FilteringTextInputFormatter.singleLineFormatter,
        // FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*$')),
      ];

  static get otpFormatter => [
        FilteringTextInputFormatter.digitsOnly,
      ];

  static get numberFormatter => [
        FilteringTextInputFormatter.digitsOnly,
        NonZeroLeadingInputFormatter(),
      ];

  static get salaryFormatter => [
        FilteringTextInputFormatter.digitsOnly,
        NonZeroLeadingInputFormatter(),
      ];
}

class NonZeroLeadingInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.startsWith('0')) {
      return TextEditingValue(
        text: oldValue.text.replaceAll(RegExp(r'^0+'), ''),
      );
    }
    if (newValue.text.startsWith('0')) {
      return oldValue;
    }
    return newValue;
  }
}
