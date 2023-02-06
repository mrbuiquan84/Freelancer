import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/popup/confirm_popup.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?>? pickImage(BuildContext context) async {
  final ImageSource? mode = await showDialog(
    context: context,
    builder: (_) => ConfirmPopup(
      title: StringConst.selectImageMode,
      firstLabel: StringConst.camera,
      secondeLabel: StringConst.gallery,
      onPressedFirstButton: () => AppRouter.back(
        context,
        result: ImageSource.camera,
      ),
      onPressedSecondButton: () => AppRouter.back(
        context,
        result: ImageSource.gallery,
      ),
    ),
  );
  if (mode != null) {
    return await ImagePicker().pickImage(source: mode);
  }
}
