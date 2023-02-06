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

class SelectJobUserPage extends StatefulWidget {
  const SelectJobUserPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectJobUserPage> createState() => _SelectJobUserPageState();
}

class _SelectJobUserPageState extends State<SelectJobUserPage> {
  late final AppRepo _appRepo;

  void initState() {
    super.initState();
    _appRepo = context.read<AppRepo>();
  }

  @override
  Widget build(BuildContext context) {
    var _jobcateBloc = context.read<JobBloc>();
    var choices = [];
    late JobCate initChoice;
    // TODO: implement build
    return Scaffold(
        backgroundColor: AppColors.lightIrisBlue,
        body: BlocConsumer(
          bloc: _jobcateBloc,
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
            choices = (state as JobcateListState).jobcates;
            initChoice = state.selectedJobcates.isNotEmpty
                ? state.selectedJobcates[0]
                : choices[0];
            return SelectPageLayout(
              choices: choices,
              appBarTitle: StringConst.expectedJob,
              helperText: "Nhập công việc mong muốn",
              maxSelect: 1,
              onAppliedButtonPressed: ((value) =>
                  AppRouter.back(context, result: value)),
            );
          },
        ));
  }
}

// class _ListJobCateWidget extends StatefulWidget {
//   const _ListJobCateWidget({
//     Key? key,
//     required AppRepo appRepo,
//     this.selectedJobCate = const [],
//     this.onChanged,
//   })  : _appRepo = appRepo,
//         super(key: key);

//   final AppRepo _appRepo;
//   final List<JobCate> selectedJobCate;
//   final ValueChanged<List<JobCate>>? onChanged;

//   @override
//   State<_ListJobCateWidget> createState() => _ListJobCateWidgetState();
// }

// class _ListJobCateWidgetState extends State<_ListJobCateWidget> {
//   late List<JobCate> _selectedJobCate;
//   late List<JobCate> _jobCates;
//   late final List<GlobalKey<CustomRadioButtonState>> _keys;

//   @override
//   void initState() {
//     super.initState();
//     _selectedJobCate = [...widget.selectedJobCate];
//     _jobCates = widget._appRepo.jobCates;
//     _keys = _jobCates.map((e) => GlobalKey<CustomRadioButtonState>()).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       separatorBuilder: (_, __) => const SizedBox(height: 20),
//       itemBuilder: (_, index) {
//         var e = widget._appRepo.jobCates[index];
//         return CustomRadioButton(
//           value: e,
//           selected: _selectedJobCate.contains(e),
//           textStyle: AppTextStyles.inputTextStyle.copyWith(
//             fontSize: 16,
//             height: 26 / 16,
//             color: AppColors.textColor,
//           ),
//           height: 40,
//           key: _keys[index],
//           beforeChange: (selected) {
//             if (!selected) {
//               if (_selectedJobCate.length >= 3) {
//                 showToast(StringConst.selectOutOfMaxRange(max: 3));
//                 return false;
//               }
//             }
//             return true;
//           },
//           onChanged: (isSelected) {
//             _onChanged(isSelected, e);
//             if (widget.onChanged != null) {
//               widget.onChanged!(_selectedJobCate);
//             }
//           },
//         );
//       },
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: widget._appRepo.jobCates.length,
//     );
//   }

//   void _onChanged(bool isSelected, JobCate e) {
//     if (isSelected) {
//       _selectedJobCate.add(e);
//     } else {
//       _selectedJobCate.remove(e);
//     }
//   }
// }
