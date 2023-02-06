import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/layout/flcer_detail_card.dart';
import 'package:freelancer/common/widgets/popup/show_confirm_delete.dart';

import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/home/empler/project/get_freelancer_project.dart';
import 'package:freelancer/modules/profile/bloc/save_flcer_card_bloc/save_flcer_card_bloc.dart';

import 'package:freelancer/utils/data/error_state_action.dart';
import 'package:freelancer/utils/data/load_state_actions.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_load_dialog.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

import '../../../common/services/http/result_data.dart';
import '../../../common/widgets/button/app_elevated_button.dart';
import '../../../common/widgets/button/app_outlined_button.dart';
import '../../../common/widgets/button/couple_bottom_outlined_and_elevated_button.dart';
import '../../../common/widgets/header.dart';
import '../../../common/widgets/popup/app_dialog.dart';
import '../../../common/widgets/popup/load_popup.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/asset_path.dart';
import '../../../core/constants/string_constants.dart';
import '../../../router/app_router.dart';
import '../bloc/save_flcer_card_bloc/save_flcer_card_repo.dart';
import '../bloc/save_flcer_card_bloc/save_flcer_card_state.dart';

class EmplerSavedFlcer extends StatefulWidget {
  const EmplerSavedFlcer({
    Key? key,
  }) : super(key: key);

  @override
  State<EmplerSavedFlcer> createState() => _EmplerSavedFlcerState();
}

class _EmplerSavedFlcerState extends State<EmplerSavedFlcer> {
  @override
  Widget build(BuildContext context) {
    List<SavedFlc> savedFlcers = [];
    final savedFlcerBloc = context.read<SaveFlcerCardBloc>();
    // var scrSize = MediaQuery.of(context).size;
    // AppRepo _appRepo = context.read<AppRepo>();
    var deleteButton = SizedBox(
      height: 35.0,
      width: 35.0,
      child: OutlinedButton(
        onPressed: () async {},
        child: Center(
          child: SvgPicture.asset(
            AppAsset.icDeleteFill,
            color: AppColors.red,
            height: 35.0,
            width: 35.0,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: const BorderSide(
            color: AppColors.red,
          ),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
    Widget _itemBuilder(List<SavedFlc> flcer, int index) {
      return BlocProvider.value(
          value: savedFlcerBloc,
          child: Dismissible(
            // resizeDuration: const Duration(milliseconds: 10000),
            background: deleteButton,
            confirmDismiss: (direction) {
              return showDialog(
                  context: context,
                  builder: (_) => AppDialog(
                        title: 'Xác nhận xóa ứng viên đã lưu này',
                        titleTextAlign: TextAlign.center,
                        padding: const EdgeInsets.all(20),
                        centerTitle: true,
                        content: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: SvgPicture.asset(
                                AppAsset.icDeleteFill,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                color: AppColors.errorColor,
                              ),
                            ),
                            CoupleBottomOutlinedAndElevatedButtons(
                              firstLabel: StringConst.confirm,
                              secondaryLabel: StringConst.cancel,
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                              onPressedFirstButton: () async {
                                var repo = SaveFlcerCardRepo();
                                ResultData res;
                                res = await repo.saveFlcer(
                                    flcerId: flcer[index].flcId);
                                if (res.result) {
                                  showToast(res.message.toString());
                                  setState(() {
                                    savedFlcerBloc.loadData();
                                  });
                                } else {
                                  showToast(res.error.toString());
                                }
                                AppRouter.back(context);
                              },
                              onPressedSecondaryButton: () =>
                                  AppRouter.back(context),
                            ),
                          ],
                        ),
                      ));
            },
            onDismissed: (direction) {},
            key: Key(flcer[index].toString()),
            child: FlcerDetailCard(
              id: flcer[index].flcId,
              name: flcer[index].info.name,
              location: flcer[index].info.cityName,
              skills:
                  flcer[index].info.listSkill.map((e) => e.toString()).toList(),
              rating: double.parse(flcer[index].info.avgStar ?? "0"),
              avatar: flcer[index].info.avatar, //flcer.avatar,
              job: flcer[index].info.userJob, // flcer.userJob,
              favoriteButton: true,
            ),
          ));
    }

    return Scaffold(
      appBar: AppAppBar(
        title: Text(StringConst.savedFlcer),
        centerTitle: true,
        backButtonAsLeading: false,
      ),
      backgroundColor: AppColors.lightIrisBlue,
      body: Container(
          color: AppColors.white,
          margin: const EdgeInsets.only(
            top: kScaffoldBodyVerticalPadding,
          ),
          width: double.infinity,
          child: BlocConsumer<SaveFlcerCardBloc, SavedFlcerCardState>(
            bloc: savedFlcerBloc,
            listener: (_, state) {
              if (state is SavedFlcerLoadState &&
                  state.onLoad == LoadStateActions.popup) {
                showLoadDialog(context);
              } else if (state is SaveFlcerErrorState &&
                  state.error == ErrorStateActions.alert) {
                showToast(state.error.toString());
              }
            },
            buildWhen: (_, state) {
              var c1 = state.runtimeType == SavedFlcerCardState;
              var c2 = (state is SaveFlcerErrorState &&
                  state.error == ErrorStateActions.rebuild);
              var c3 = (state is SavedFlcerLoadState &&
                  state.onLoad == LoadStateActions.rebuild);
              var rebuildCondition = c1 || c2 || c3;
              return rebuildCondition;
            },
            builder: (context, state) {
              savedFlcers = [...state.savedFlcer];
              return RefreshIndicator(
                onRefresh: () => savedFlcerBloc.loadData(),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kPadding(context),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        Header(header: StringConst.listSavedFlcers),
                        const SizedBox(height: 15.0),
                        ListView.builder(
                            itemCount: savedFlcers.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                _itemBuilder(savedFlcers, index)),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
// class DeleteSavedFlcer extends StatefulWidget {
//   const DeleteSavedFlcer({
//     Key? key,
//     required this.flcerID,
//   }) : super(key: key);
//   final String flcerId;

//   @override
//   State<DeleteSavedFlcer> createState() =>
//       _DeleteSavedFlcer();
// }
// class _DeleteSavedFlcer extends State<DeleteSavedFlcer> {
//   late final SaveFlcerCardBloc _savedFlcerBloc;
//   bool? _isConfirm;

//   @override
//   void initState() {
//     super.initState();
//     _savedFlcerBloc = context.read<SaveFlcerCardBloc>();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var alertDialog = AppDialog(
//       title: 'Xác nhận xóa ứng viên đã lưu này',
//       titleTextAlign: TextAlign.center,
//       padding: const EdgeInsets.all(20),
//       centerTitle: true,
//       content: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             child: SvgPicture.asset(
//               AppAsset.icDeleteFill,
//               height: 50,
//               width: 50,
//               fit: BoxFit.cover,
//               color: AppColors.errorColor,
//             ),
//           ),
//           CoupleBottomOutlinedAndElevatedButtons(
//             firstLabel: StringConst.confirm,
//             secondaryLabel: StringConst.cancel,
//             margin: EdgeInsets.zero,
//             padding: EdgeInsets.zero,
//             onPressedFirstButton: () {
//               _savedFlcerBloc.(widget.projectId);
//               setState(() {
//                 _isConfirm = true;
//               });
//             },
//             onPressedSecondaryButton: () => AppRouter.back(context),
//           ),
//         ],
//       ),
//     );

//     var loadingDialog = const LoadPopup();

//     return BlocListener(
//       bloc: _savedFlcerBloc,
//       listener: (_, state) {
//         if (state is SaveFlcerDeleteSuccessState) {
//           AppRouter.back(context);
//         } else if (state is SavedProjectErrorState &&
//             state.action == ErrorStateActions.alert &&
//             mounted) {
//           AppRouter.back(context);
//         }
//       },
//       child: _isConfirm == null
//           ? alertDialog
//           : (_isConfirm! ? loadingDialog : const SizedBox.shrink()),
//     );
//   }
// }
