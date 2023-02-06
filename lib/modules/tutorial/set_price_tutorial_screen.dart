import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/utils/ui/app_num.dart';

class SetPriceTutorialScreen extends StatelessWidget {
  const SetPriceTutorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bodyTextStyle = const TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      height: 25.0 / 15.0,
      color: AppColors.textColor,
    );

    var headerTextStyle = const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 25.63 / 15.0,
      color: AppColors.textColor,
    );

    buildTutorBody({required List<String> text}) {
      return RichText(
        text: TextSpan(
          text: text[0],
          style: bodyTextStyle,
          children: [
            if (text.length > 1)
              TextSpan(
                text: text[1],
                style: bodyTextStyle.copyWith(
                  color: AppColors.orangeAccent,
                ),
              ),
          ],
        ),
      );
    }

    buildTutorHeader({required String text}) {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
        child: Text(
          text,
          style: headerTextStyle,
        ),
      );
    }

    return Scaffold(
      appBar: AppAppBar(
        title: const Text(StringConst.tutorial),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
          child: Column(
            children: [
              const SizedBox(height: kSizedBoxHeight),
              const Text(
                StringConst.guideFreelancerSetPrice,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  height: 27.66 / 18.0,
                ),
              ),
              const SizedBox(height: kSizedBoxHeight),
              Image.asset(AppAsset.imgSteps),
              const SizedBox(height: kSizedBoxHeight),
              Image.asset(AppAsset.imgLogo4),
              const SizedBox(height: kSizedBoxHeight),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTutorBody(text: [StringConst.tutorBody0]),
                  buildTutorHeader(text: StringConst.tutorHeader1),
                  buildTutorBody(text: [StringConst.tutorBody1]),
                  buildTutorHeader(text: StringConst.tutorHeader2),
                  buildTutorBody(text: [StringConst.tutorBody2]),
                  buildTutorHeader(text: StringConst.tutorHeader3),
                  buildTutorBody(
                    text: [
                      StringConst.tutorBody31,
                      StringConst.tutorBody32,
                    ],
                  ),
                ],
              ),
              const SizedBox(height: kSizedBoxHeight),
            ],
          ),
        ),
      ),
    );
  }
}
