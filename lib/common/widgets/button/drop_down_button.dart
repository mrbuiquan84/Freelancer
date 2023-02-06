import 'package:flutter/material.dart';
import 'package:freelancer/core/theme/app_colors.dart';

class DropDownButton<T> extends StatelessWidget {
  const DropDownButton({
    Key? key,
    this.initValue,
    this.choices = const [],
  }) : super(key: key);
  final T? initValue;
  final List<T> choices;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      color: AppColors.gray,
      alignment: Alignment.center,
      child: const Text('Implement dropdown button'),
    );
  }
}
