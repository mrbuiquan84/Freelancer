import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/form/dropdown_textfield_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/profile/bloc/update_flcer_profile/update_intro_bloc/update_intro_repo.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../../utils/ui/show_toast.dart';

class UpdateIntroPage extends StatefulWidget {
  const UpdateIntroPage({Key? key}) : super(key: key);

  @override
  State<UpdateIntroPage> createState() => _UpdateIntroPageState();
}

class _UpdateIntroPageState extends State<UpdateIntroPage> {
  final _introController = TextEditingController();
  final _selectedExpText = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final flcerInfoBloc = CurrentUser.of(context).flcerProfileBloc!;
    final info = flcerInfoBloc.flcerInfo!.info;
    _introController.text = info.userDes.toString();
    _selectedExpText.text = info.skillYear;
    int _selectedExp;
    if (_selectedExpText == 'Chưa có kinh nghiệm') {
      _selectedExp = 1;
    } else if (_selectedExpText == '0 - 1 năm kinh nghiệm') {
      _selectedExp = 2;
    } else if (_selectedExpText == '1 - 2 năm kinh nghiệm') {
      _selectedExp = 3;
    } else if (_selectedExpText == '2 -5 năm kinh nghiệm') {
      _selectedExp = 4;
    } else if (_selectedExpText == '5 - 10 năm kinh nghiệm') {
      _selectedExp = 5;
    } else {
      _selectedExp = 6;
    }
    var _labelTextStyle = AppTextStyles.textFieldLabelTxtStyle;
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kSizedBoxHeight),
            DropDownTextFieldButton(
              label: StringConst.expWorking,
              labelTextStyle: _labelTextStyle,
              controller: _selectedExpText,
              isRequired: true,
              choices: const [
                'Chưa có kinh nghiệm',
                '0 - 1 năm kinh nghiệm',
                '1 - 2 năm kinh nghiệm',
                '2 -5 năm kinh nghiệm',
                '5 - 10 năm kinh nghiệm',
                'Hơn 10 năm kinh nghiệm',
              ],
              onChanged: (value) {
                if (value == 'Chưa có kinh nghiệm') {
                  _selectedExp = 1;
                } else if (value == '0 - 1 năm kinh nghiệm') {
                  _selectedExp = 2;
                } else if (value == '1 - 2 năm kinh nghiệm') {
                  _selectedExp = 3;
                } else if (value == '2 -5 năm kinh nghiệm') {
                  _selectedExp = 4;
                } else if (value == '5 - 10 năm kinh nghiệm') {
                  _selectedExp = 5;
                } else {
                  _selectedExp = 6;
                }
                print(value);
              },
            ),
            AppTextField(
              elevation: 0,
              label: StringConst.introYourself,
              labelTextStyle: _labelTextStyle,
              isRequired: true,
              hint: StringConst.introYourself,
              inputTextStyle:
                  AppTextStyles.inputTextStyle.copyWith(height: 29.73 / 15.0),
              controller: _introController,
              maxLines: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Center(
                child: AppElevatedButton(
                  label: StringConst.update,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 41.0, vertical: 5.0),
                  onPressed: () async {
                    var repo = UpdateIntroRepo();
                    var res = await repo.updateIntroRepo(
                        expYear: _selectedExp, intro: _introController.text);
                    if (res.result) {
                      showToast(res.message.toString());
                      Navigator.pop(context);
                    } else {
                      showToast(res.error.toString());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
