import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer/common/bloc/city/city_state.dart';
import 'package:freelancer/common/bloc/city/select_city_bloc.dart';
import 'package:freelancer/common/bloc/jobcate/jobcate_state.dart';
import 'package:freelancer/common/bloc/jobcate/select_job_bloc.dart';
import 'package:freelancer/common/models/flcer.dart';
import 'package:freelancer/common/models/job.dart';
import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/form/dropdown_textfield_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/common/widgets/text_field_label.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/profile/bloc/update_flcer_profile/update_expected_job_repo/update_expected_job_repo.dart';
import 'package:freelancer/modules/signup/widget/toggle_outlined_button.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/city.dart';
import 'package:freelancer/utils/data/salary.dart';
import 'package:freelancer/utils/ui/app_num.dart';

import '../../../utils/data/salary_type.dart';
import '../../../utils/helpers/validators.dart';
import '../../../utils/ui/show_toast.dart';

class UpdateExpectedJobPage extends StatefulWidget {
  const UpdateExpectedJobPage({Key? key}) : super(key: key);

  @override
  State<UpdateExpectedJobPage> createState() => _UpdateExpectedJobPageState();
}

class _UpdateExpectedJobPageState extends State<UpdateExpectedJobPage> {
  final _careerController = TextEditingController();
  final _workingFormController = TextEditingController();
  final _expectedJobController = TextEditingController();
  final _expectedLocationController = TextEditingController();
  final _expectedSalaryController = TextEditingController();
  final _expectedSalaryTypeController = TextEditingController();
  final _expectedSalaryTimeController = TextEditingController();

  final GlobalKey<FormState> _Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _careerKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _workingFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _expectedJobKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _expectedLocationKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _expectedSalaryKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _expectedSalarKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _expectedSalaryTimeKey = GlobalKey<FormState>();
  SalaryType _selectedSalaryType = SalaryType.staticSalaryType;

  late final AppRepo _appRepo;
  City? _selectedCity;
  Job? _selectedJob;

  @override
  void initState() {
    super.initState();
    _appRepo = context.read<AppRepo>();
  }

  final TextStyle _inputTextStyle = const TextStyle(
    fontFamily: AppConst.fontNunito,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 26 / 16.0,
    color: AppColors.gray,
  );

  final TextStyle _labelTextStyle = const TextStyle(
    fontFamily: AppConst.fontNunito,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 26 / 16.0,
    color: AppColors.textColor,
  );

  @override
  Widget build(BuildContext context) {
    final flcerInfoBloc = CurrentUser.of(context).flcerProfileBloc!;
    final info = flcerInfoBloc.flcerInfo!.work;
    _careerController.text = info.userJob;
    _workingFormController.text = info.formOfWork;
    int _selectedWorkingForm;
    if (_workingFormController.text == 'online') {
      _selectedWorkingForm = 1;
    } else {
      _selectedWorkingForm = 2;
    }
    _expectedJobController.text = info.workDesire.jobCate.toString();
    int _selectedWork = info.workDesire.id;
    _expectedLocationController.text = info.workPlace.toString();
    int _selectedCity = info.workPlace.citId;
    _expectedSalaryController.text = info.salary.toString();
    int _salaryType = info.salary.salaryType.id;
    int _salaryDate = 1;
    _expectedSalaryController.text =
        flcerInfoBloc.flcerInfo!.info.salaryPermanentNumber;
    return Container(
      color: AppColors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: kPadding(context),
          vertical: 15.0,
        ),
        child: Column(
          children: [
            AppTextField(
              iconColor: AppColors.gray2,
              height: 45.0,
              labelTextStyle: _labelTextStyle,
              inputTextStyle: _inputTextStyle,
              elevation: 0,
              hint: '',
              label: StringConst.career,
              isRequired: true,
              controller: _careerController,
              formKey: _careerKey,
            ),
            DropDownTextFieldButton(
              hint: '',
              label: StringConst.workingForm,
              labelTextStyle: _labelTextStyle,
              isRequired: true,
              itemHeight: 45.0,
              controller: _workingFormController,
              borderColor: AppColors.gray2,
              buttonTextStyle: _inputTextStyle,
              choices: const [
                'online',
                'Tại văn phòng',
              ],
              initChoice: info.formOfWork.toString(),
              onChanged: (value) {
                if (value == 'online') {
                  _selectedWorkingForm = 1;
                } else {
                  _selectedWorkingForm = 2;
                }
                print(value);
              },
            ),
            AppTextField(
              iconColor: AppColors.gray2,
              height: 45.0,
              labelTextStyle: _labelTextStyle,
              inputTextStyle: _inputTextStyle,
              elevation: 0,
              hint: '',
              label: StringConst.expectedJob,
              isRequired: true,
              controller: _expectedJobController,
              suffixIcon: AppAsset.icArrowDropDown,
              readOnly: true,
              formKey: _expectedJobKey,
              onTapTextField: () async {
                var pickedJob = await AppRouter.toPage(
                  context,
                  AppPages.selectJobUserPage,
                  blocValue: JobBloc(
                    JobcateListState(
                      _appRepo.jobCates,
                      selectedJobcates: [],
                    ),
                    appRepo: _appRepo,
                  ),
                );
                if (pickedJob != null) {
                  _selectedWork = (pickedJob as JobCate).id;
                  _expectedJobController.text = pickedJob.toString();
                }
              },
            ),
            AppTextField(
              iconColor: AppColors.gray2,
              height: 45.0,
              labelTextStyle: _labelTextStyle,
              inputTextStyle: _inputTextStyle,
              elevation: 0,
              hint: '',
              label: StringConst.expectedLocation,
              formKey: _expectedLocationKey,
              isRequired: true,
              controller: _expectedLocationController,
              suffixIcon: AppAsset.icArrowDropDown,
              readOnly: true,
              onTapTextField: () async {
                var pickedCity = await AppRouter.toPage(
                  context,
                  AppPages.selectCityUserPage,
                  blocValue: CityBloc(
                    CityListState(
                      _appRepo.cities,
                      selectedCities: [],
                    ),
                    appRepo: _appRepo,
                  ),
                );
                if (pickedCity != null) {
                  _selectedCity = ((pickedCity as List)[0] as City).citId;
                  _expectedLocationController.text =
                      ((pickedCity as List)[0] as City).toString();
                }
              },
            ),
            // TextFieldLabel(
            //   label: StringConst.askSalary,
            //   labelTextStyle: _labelTextStyle,
            //   isRequired: true,
            // ),
            // const ToggleOutlinedButton(
            //   isMaxWidth: true,
            //   values: [
            //     StringConst.staticSalary,
            //     StringConst.estimateSalary,
            //   ],
            // ),
            AppTextField(
              inputTextStyle: AppTextStyles.inputTextStyle.copyWith(
                fontSize: 16,
                height: 26 / 16,
                color: AppColors.hintColor,
              ),
              height: 40,
              elevation: 0.0,
              hint: StringConst.askSalary,
              label: StringConst.salaryLabel,
              isRequired: true,
              validator: (value) => Validator.salaryValidator(
                value,
                salaryType: _selectedSalaryType,
              ),
              controller: _expectedSalaryController,
              formKey: _expectedSalarKey,
              trailing: Align(
                alignment: Alignment.centerRight,
                child: ToggleOutlinedButton(
                  values: SalaryType.values,
                  onChanged: (value) {
                    _selectedSalaryType = value as SalaryType;
                    if (value == StringConst.staticSalary) {
                      _salaryType = 1;
                    } else {
                      _salaryType = 2;
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: kTextFieldBottomPadding),

            DropDownTextFieldButton(
                borderColor: AppColors.gray2,
                itemHeight: 45.0,
                labelTextStyle: _labelTextStyle,
                buttonTextStyle: _inputTextStyle,
                elevation: 0,
                hint: '',
                controller: _expectedSalaryTimeController,
                choices: Salary.times,
                onChanged: (value) {
                  if (value == 'Ngày') {
                    _salaryDate = 1;
                  } else if (value == 'Tuần') {
                    _salaryDate = 2;
                  } else if (value == 'Tháng') {
                    _salaryDate = 3;
                  } else
                    _salaryDate = 4;
                  print(value);
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Center(
                child: AppElevatedButton(
                    label: StringConst.update,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 41.0,
                      vertical: kButtonLabelVerticalPadding,
                    ),
                    elevation: 0.0,
                    labelTextStyle: AppTextStyles.buttonNormalTxtStyle,
                    onPressed: () async {
                      var repo = UpdateExpectedJobRepo();
                      var res = await repo.updateExpectedJobRepo(
                          userJob: _careerController.text,
                          formWork: _selectedWorkingForm,
                          workDesire: _selectedWork,
                          workPlace: _selectedCity,
                          salaryTpye: _salaryType,
                          salaryDate: _salaryDate,
                          salaryPermanent:
                              int.parse(_expectedSalaryController.text));
                      if (res.result) {
                        showToast(res.message.toString());
                        Navigator.pop(context);
                      } else {
                        showToast(res.error.toString());
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
