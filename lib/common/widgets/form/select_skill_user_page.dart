import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/bloc/jobcate/jobcate_state.dart';
import 'package:freelancer/common/bloc/jobcate/select_job_bloc.dart';
import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/common/widgets/appbar/unauthenticated_appbar.dart';
import 'package:freelancer/common/widgets/layout/select_page_layout.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/router/app_router.dart';

import '../../../core/constants/string_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../utils/ui/show_toast.dart';
import '../button/outlined_radio_button.dart';

class SelectSkillUserPage extends StatefulWidget {
  const SelectSkillUserPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectSkillUserPage> createState() => _SelectSkillUserPageState();
}

class _SelectSkillUserPageState extends State<SelectSkillUserPage> {
  // late final AppRepo _appRepo;

  void initState() {
    super.initState();
    // _appRepo = context.read<AppRepo>();
  }

  @override
  Widget build(BuildContext context) {
    var _skillBloc = context.read<JobBloc>();
    var choices = [];
    late Skill initChoice;
    // TODO: implement build
    return Scaffold(
        backgroundColor: AppColors.lightIrisBlue,
        body: BlocConsumer(
          bloc: _skillBloc,
          listener: (_, state) {
            if (state is JobcateLoadState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const AppDialog(),
              );
            }
          },
          builder: (context, state) {
            if (state is SkillListState) {
              choices = state.skills;
              initChoice = state.selectedSkills.isNotEmpty
                  ? state.selectedSkills
                  : choices[0];
            }
            return SelectPageLayout(
              choices: choices,
              appBarTitle: "Kĩ năng mong muốn",
              helperText: "Chọn kĩ năng: ",
              maxSelect: 3,
              onAppliedButtonPressed: ((value) => AppRouter.back(context,
                  result: value.map((e) => e as Skill).toList())),
            );
          },
        ));
  }
}
