import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  Map<String, dynamic> routeArgs() =>
      ModalRoute.of(this)!.settings.arguments as Map<String, dynamic>;
}
