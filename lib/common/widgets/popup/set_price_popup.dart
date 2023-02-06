import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/widgets/popup/app_dialog.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/common/widgets/popup/save_job_success_popup.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/modules/flcer_order_job/bloc/flcer_order_job_bloc.dart';
import 'package:freelancer/modules/flcer_order_job/bloc/flcer_order_job_state.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_load_dialog.dart';
import 'package:freelancer/utils/ui/show_toast.dart';

class SetPricePopup extends StatefulWidget {
  const SetPricePopup({
    Key? key,
    required this.expDate,
    required this.jobId,
    required this.jobTitle,
    this.onSuccess,
  }) : super(key: key);

  final String expDate;
  final String jobId;
  final String jobTitle;
  final VoidCallback? onSuccess;

  @override
  State<SetPricePopup> createState() => _SetPricePopupState();
}

class _SetPricePopupState extends State<SetPricePopup> {
  late final FlcerOrderJobBloc _orderJobBloc;
  final TextEditingController _expectedSalaryController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isShowDialog = false;

  @override
  void initState() {
    super.initState();
    _orderJobBloc = context.read<FlcerOrderJobBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _orderJobBloc,
      listenWhen: (_, state) => mounted || state is FlcerOrderJobSuccessState,
      listener: (_, state) {
        if (_isShowDialog) {
          _isShowDialog = false;
          AppRouter.back(context);
        }
        if (state is FlcerOrderJobLoadState) {
          _isShowDialog = true;
          showLoadDialog(
            context,
            barrierColor: Colors.transparent,
            dismissible: true,
          ).then((value) => _isShowDialog = false);
        } else if (state is FlcerOrderJobSuccessState) {
          if (_isShowDialog) {
            AppRouter.back(context);
          }
        } else if (state is FlcerOrderJobErrorState) {
          showToast(state.error.toString());
        }
      },
      buildWhen: (_, __) => mounted,
      builder: (_, state) {
        if (state is FlcerOrderJobSuccessState) {
          return SaveJobSuccessPopup(
            successAlert: StringConst.orderSuccess,
          );
        }
        return AppDialog(
          title: StringConst.setPriceForJob,
          isShowCancelButton: true,
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 23.05),
          content: Column(
            children: [
              const SizedBox(height: 15.0),
              const Text(
                'Mời bạn đặt giá cho công việc này',
                style: TextStyle(
                  fontFamily: AppConst.fontNunito,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 25 / 16.0,
                  color: AppColors.textColor,
                ),
                textAlign: TextAlign.left,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  color: AppColors.lightIrisBlue,
                  border: Border.all(
                    color: AppColors.primaryColor,
                  ),
                ),
                alignment: Alignment.center,
                height: 35.0,
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Text(
                  'Đặt giá kết thúc ngày ' + widget.expDate,
                  style: const TextStyle(
                    fontFamily: AppConst.fontNunito,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 22 / 14.0,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: 'Đặt giá cho công việc ',
                  style: const TextStyle(
                    fontFamily: AppConst.fontNunito,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 23 / 15.0,
                    color: AppColors.textColor,
                  ),
                  children: [
                    TextSpan(
                      text: widget.jobTitle,
                      style: const TextStyle(
                        fontFamily: AppConst.fontNunito,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 23 / 15.0,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const TextSpan(
                      text: " để có mức giá phù hợp với bạn nhất. ",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              AppTextField(
                height: 40,
                elevation: 0,
                hint: StringConst.askExpectedSalary,
                controller: _expectedSalaryController,
              ),
              AppTextField(
                height: 40,
                elevation: 0,
                hint: StringConst.askYourEmail,
                controller: _emailController,
              ),
              AppElevatedButton(
                label: StringConst.setPriceForJob,
                width: double.infinity,
                elevation: 0,
                labelTextStyle: const TextStyle(
                  fontFamily: AppConst.fontNunito,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 25 / 16.0,
                  color: AppColors.white,
                ),
                onPressed: () {
                  _orderJobBloc.orderJob(
                    jobId: widget.jobId,
                    salary: _emailController.text,
                    email: _expectedSalaryController.text,
                    expDate: widget.expDate,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
