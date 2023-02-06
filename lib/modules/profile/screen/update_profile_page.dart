import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/common/widgets/layout/screen_with_tab_layout.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/profile/screen/update_capacity_profile_page.dart';
import 'package:freelancer/modules/profile/screen/update_basic_info_page.dart';
import 'package:freelancer/modules/profile/screen/update_expected_job_page.dart';
import 'package:freelancer/modules/profile/screen/update_intro_page.dart';
import 'package:freelancer/modules/profile/screen/update_skill_page.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final List<String> tabLabels = [
    StringConst.basicInfo,
    StringConst.introYourself,
    StringConst.expectedJob,
    StringConst.skill,
    StringConst.capacityProfile,
  ];

  @override
  Widget build(BuildContext context) {
    var tabs = [
      const UpdateBasicInfoPage(),
      const UpdateIntroPage(),
      const UpdateExpectedJobPage(),
      const UpdateSkillPage(),
      const UpdateCapacityProfilePage(),
    ];

    return ScreenWithTabLayout(
      appBarTitle: StringConst.updateProfile.toTitleCase(),
      tabLabels: tabLabels,
      tabs: tabs,
    );
  }
}
