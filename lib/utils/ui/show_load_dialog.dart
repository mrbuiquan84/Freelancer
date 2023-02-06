import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/popup/load_popup.dart';

Future<T?> showLoadDialog<T>(
  BuildContext context, {
  bool dismissible = false,
  Color? barrierColor,
}) =>
    showDialog<T>(
      context: context,
      barrierDismissible: dismissible,
      barrierColor: barrierColor,
      builder: (_) => const LoadPopup(),
    );
