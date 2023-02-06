import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class ShowContactAlertPopup extends StatelessWidget {
  const ShowContactAlertPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      fontFamily: AppConst.fontNunito,
      fontSize: 15.0,
      fontWeight: FontWeight.w700,
      height: 23.05 / 15.0,
    );

    var buttonRadius = 50.0;
    var buttonHeight = 37.0;

    return AppDialog(
      padding: const EdgeInsets.fromLTRB(45.0, 20.0, 45.0, 47.0),
      // padding: EdgeInsets.zero,
      content: Column(
        children: [
          Text(
            StringConst.notif,
            style: TextStyle(
              fontFamily: AppConst.fontNunito,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 31 / 20.0,
              color: AppColors.textColor,
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 4.0,
                )
              ],
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 20.0),
          SvgPicture.asset(
            AppAsset.icInfo,
            color: AppColors.orangeAccent,
            height: 50.0,
            width: 50.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 30.0),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              text: 'Bạn có ',
              style: TextStyle(
                fontFamily: AppConst.fontNunito,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 24 / 16.0,
                color: AppColors.textColor,
              ),
              children: [
                TextSpan(
                  text: '10',
                  style: TextStyle(
                    fontFamily: AppConst.fontNunito,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 23 / 15.0,
                    color: AppColors.orangeAccent,
                  ),
                ),
                TextSpan(
                  text: ' điểm hôm nay. Bạn có muốn dùng ',
                ),
                TextSpan(
                  text: '1 điểm ',
                  style: TextStyle(
                    fontFamily: AppConst.fontNunito,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 23 / 15.0,
                    color: AppColors.red,
                  ),
                ),
                TextSpan(
                  text: ' để xem liên hệ Freelancer này không?',
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 59.0 - 45.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AppOutlinedButton(
                    child: StringConst.cancel,
                    height: buttonHeight,
                    width: double.infinity,
                    buttonPrimaryColor: AppColors.orangeAccent,
                    labelTextStyle:
                        textStyle.copyWith(color: AppColors.orangeAccent),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(buttonRadius),
                  ),
                ),
                const SizedBox(width: kSizedBoxWidth),
                Expanded(
                  flex: 1,
                  child: AppElevatedButton(
                    label: StringConst.agree,
                    height: buttonHeight,
                    width: double.infinity,
                    labelTextStyle: textStyle.copyWith(
                      color: AppColors.white,
                    ),
                    elevation: 0.0,
                    onPressed: () {},
                    borderRadius: buttonRadius,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
