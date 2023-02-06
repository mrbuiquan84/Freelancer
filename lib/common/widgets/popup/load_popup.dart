import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';

class LoadPopup extends StatelessWidget {
  const LoadPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppDialog(
      content: CircularProgressIndicator(),
      elevation: 0.0,
    );
  }
}
