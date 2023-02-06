import 'package:flutter/material.dart';

pickDate(
  BuildContext context, {
  DateTime? initDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  return await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: firstDate ?? DateTime.utc(1960),
    lastDate: lastDate ?? DateTime.utc(2100),
  );
}
