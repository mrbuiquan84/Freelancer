import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/common/services/http/result_data.dart';
import 'package:freelancer/common/widgets/app_chip.dart';
import 'package:freelancer/common/widgets/appbar/app_bar.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/common/widgets/button/couple_bottom_outlined_and_elevated_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/common/widgets/layout/outlined_dotted_border_card.dart';
import 'package:freelancer/common/widgets/text_field_label.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/empler/bloc/post_job_bloc/post_job_repo.dart';
import 'package:freelancer/modules/signup/widget/toggle_outlined_button.dart';
import 'package:freelancer/utils/data/salary_type.dart';
import 'package:freelancer/utils/helpers/input_formatter.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../common/bloc/city/city_state.dart';
import '../../common/bloc/city/select_city_bloc.dart';
import '../../common/bloc/jobcate/jobcate_state.dart';
import '../../common/bloc/jobcate/select_job_bloc.dart';
import '../../common/models/job.dart';
import '../../common/widgets/form/dropdown_textfield_button.dart';
import '../../core/constants/app_constants.dart';
import '../../router/app_pages.dart';
import '../../router/app_router.dart';
import '../../utils/data/city.dart';
import '../../utils/helpers/pick_date.dart';
import '../../utils/helpers/pick_image.dart';
import '../../utils/helpers/validators.dart';
import '../bloc/app_repo.dart';
import 'bloc/post_job_bloc/post_job_bloc.dart';

class PostJobPartimeScreen extends StatefulWidget {
  const PostJobPartimeScreen({Key? key}) : super(key: key);

  @override
  State<PostJobPartimeScreen> createState() => _PostJobPartimeScreenState();
}

class _PostJobPartimeScreenState extends State<PostJobPartimeScreen> {
  // late final AppRepo _appRepo;
  // late final PostJobBloc _postJobBloc;
  @override
  void initState() {
    _appRepo = context.read<AppRepo>();
    super.initState();
  }

  City? _selectedCity;
  JobCate? _selectedJob;
  List<Skill> _selectedSkill = [];
  int _selectedWorkingForm = 1;
  int _selectedExp = 0;
  int _selectedSalaryType = 1;
  int _selectedType = 1;
  late final AppRepo _appRepo;
  final ValueNotifier<XFile?> _selectedLogo = ValueNotifier(null);
  final TextEditingController _estimatedBudgetController =
      TextEditingController();
  final TextEditingController _titleJobController = TextEditingController();
  final TextEditingController _expectedJobController = TextEditingController();
  final TextEditingController _expectedLocationController =
      TextEditingController();
  final TextEditingController _workingFormController = TextEditingController();
  final TextEditingController _startDayController = TextEditingController();
  final TextEditingController _endDayController = TextEditingController();
  final TextEditingController _startWorkDayController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _jobDetailController = TextEditingController();
  final TextEditingController _workingTermController = TextEditingController();
  final GlobalKey<FormState> _titleJobKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _expectedJobKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _expectedLocationKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _workingFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _jobDetailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _startDayKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _endDAyKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _startWorkDayKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _skillKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _estimatedBudgetKey = GlobalKey<FormState>();
  _loadLogo() async {
    var avatar = _selectedLogo.value;
    if (avatar != null) {
      return await MultipartFile.fromFile(
        avatar.path,
        filename: avatar.path.split('/').last,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var _labelTextStyle = const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 21.82 / 16.0,
      color: AppColors.textColor,
    );

    TextStyle _inputTextStyle = const TextStyle(
      fontFamily: AppConst.fontNunito,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 26 / 16.0,
      color: AppColors.gray,
    );
    var _endDate = DateTime.now();
    var _startWork = DateTime.now();
    var _startDate = DateTime.now();
    return Scaffold(
      backgroundColor: AppColors.lightIrisBlue,
      appBar: AppAppBar(
        title: Text(StringConst.postJobPartime.toTitleCase()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                  vertical: kScaffoldBodyVerticalPadding),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kPadding(context)),
                child: Column(
                  children: [
                    Container(
                      width: 197.0,
                      height: 132.0,
                      margin: const EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kBorderRadius20),
                        border: Border.all(
                          color: const Color(0xFFCCCCCC),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 38.0,
                            child: ValueListenableBuilder<XFile?>(
                              valueListenable: _selectedLogo,
                              builder: (context, logo, __) {
                                if (logo == null) {
                                  return Image.asset(
                                    AppAsset.imgLogo,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return Image.file(
                                    File(logo.path),
                                    fit: BoxFit.cover,
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          AppOutlinedButton(
                            child: '+ ' + StringConst.chooseImage,
                            onPressed: () async {
                              var pickedImage = await pickImage(context);
                              if (pickedImage != null) {
                                _selectedLogo.value = pickedImage;
                              }
                            },
                            labelTextStyle: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              height: 24.59 / 16.0,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        StringConst.comLogo,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          height: 24.55 / 18.0,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                    const _HeaderText(text: StringConst.jobThatNeedFlcer),
                    AppTextField(
                      elevation: 0.0,
                      labelTextStyle: _labelTextStyle,
                      hint: 'VD: Thiết kế web bán hàng cao cấp',
                      label: StringConst.namingForJob,
                      isRequired: true,
                      // validator: Validator.validateName,
                      // inputFormatters: InputFormatter.nameFormatter,
                      formKey: _titleJobKey,
                      controller: _titleJobController,
                    ),
                    AppTextField(
                      elevation: 0.0,
                      labelTextStyle: _labelTextStyle,
                      hint: StringConst.askField,
                      label: StringConst.selectNeedField,
                      controller: _expectedJobController,
                      formKey: _expectedJobKey,
                      suffixIcon: AppAsset.icArrowDropDown,
                      isRequired: true,
                      readOnly: true,
                      onTapTextField: () async {
                        var pickedJob = await AppRouter.toPage(
                          context,
                          AppPages.selectJobUserPage,
                          blocValue: JobBloc(
                            JobcateListState(
                              _appRepo.jobCates,
                              selectedJobcates:
                                  _selectedJob != null ? [_selectedJob!] : [],
                            ),
                            appRepo: _appRepo,
                          ),
                        );
                        if (pickedJob != null) {
                          _selectedJob = (pickedJob as List)[0] as JobCate;
                          _expectedJobController.text = pickedJob.toString();
                        }
                      },
                    ),
                    _HeaderText(
                      text: StringConst.detailAboutRequirement,
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 10.0,
                      ),
                    ),
                    DropDownTextFieldButton(
                      hint: StringConst.askWorkingForm,
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
                      initChoice: 'online',
                      onChanged: (value) {
                        // _selectedWorkingForm = value.toString();
                        if (value == 'online')
                          _selectedWorkingForm = 1;
                        else
                          _selectedWorkingForm = 2;
                        print(value);
                      },
                    ),
                    AppTextField(
                      // borderColor: AppColors.gray2,
                      elevation: 0.0,
                      labelTextStyle: _labelTextStyle,
                      hint: StringConst.askLocation,
                      label: StringConst.locationLabel,
                      isRequired: true,
                      formKey: _expectedLocationKey,
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
                          _selectedCity = (pickedCity as List)[0] as City;
                          _expectedLocationController.text =
                              _selectedCity.toString();
                        }
                      },
                    ),
                    DropDownTextFieldButton(
                      elevation: 0.0,
                      hint: StringConst.askExp,
                      label: StringConst.requireExpLabel,
                      labelTextStyle: _labelTextStyle,
                      initChoice: 'Chưa có kinh nghiệm',
                      itemHeight: 45.0,
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
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text:
                                'Yêu Nội dung chi tiết, và các đầu việc cần Freelancer thực hiện ',
                            style:
                                _labelTextStyle.copyWith(height: 25.0 / 16.0),
                            children: [
                              TextSpan(
                                text: '*',
                                style: _labelTextStyle.copyWith(
                                    color: AppColors.red),
                              ),
                              const TextSpan(
                                text:
                                    '\n(càng chi tiết, freelancer càng có đầy đủ thông tin để gửi báo giá chính xác hơn)',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        AppTextField(
                          elevation: 0.0,
                          hint:
                              'VD: Thiết kế các giao diện website cần thiết như: Trang chủ, xem hàng, thanh toán...',
                          controller: _jobDetailController,
                          formKey: _jobDetailKey,
                          maxLines: 6,
                          hintTxtStyle: const TextStyle(
                            fontSize: 15.0,
                            height: 23.05 / 15.0,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        StringConst.addAttachDocument,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 25 / 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    OutlinedDottedBorderCard(
                      radius: kBorderRadius10,
                      padding: const EdgeInsets.fromLTRB(11.0, 14.0, 35.0, 9.0),
                      borderColor: AppColors.borderColor,
                      child: Row(
                        children: [
                          AppOutlinedButton(
                            child: '+ ' + StringConst.upload,
                            onPressed: () {},
                            borderColor: AppColors.borderColor,
                            labelTextStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 23.05 / 15.0,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          const Expanded(
                            child: Text(
                              StringConst.uploadProjectHelper,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                height: 23.05 / 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    AppTextField(
                      hint: "Chọn kĩ năng cần có",
                      label: StringConst.requireFlcerSkill,
                      isRequired: true,
                      labelTextStyle:
                          AppTextStyles.textFieldLabelTxtStyle.copyWith(
                        color: AppColors.primaryColor,
                      ),
                      readOnly: true,
                      controller: _skillController,
                      formKey: _skillKey,
                      suffixIcon: AppAsset.icArrowDropDown,
                      onTapTextField: () async {
                        if (_selectedJob != null) {
                          var skillBloc =
                              JobBloc(JobcateLoadState(), appRepo: _appRepo);
                          skillBloc.getSkill(_selectedJob!.id);
                          var pickedSkill = await AppRouter.toPage(
                              context, AppPages.selectSkillUserPage,
                              blocValue: skillBloc);
                          if (pickedSkill != null) {
                            _skillController.text = pickedSkill.toString();
                            _selectedSkill = [...(pickedSkill as List<Skill>)];
                          }
                        }
                      },
                    ),
                    // Wrap(
                    //   runSpacing: 10.0,
                    //   children: [
                    //       ..._selectedSkill.map(
                    //         (e) => _buildRequireSkillChip(label: e.skillName)
                    //         ).toList()
                    //     // _buildRequireSkillChip(
                    //     //   label: 'SEO',
                    //     // ),
                    //     // _buildRequireSkillChip(
                    //     //   label: 'Quảng cáo facebook',
                    //     // )
                    //   ],
                    // ),
                    const _HeaderText(
                      text: StringConst.priceAndTime,
                    ),
                    TextFieldLabel(
                      label: StringConst.estimatedBudgetLabel,
                      isRequired: true,
                      labelTextStyle: _labelTextStyle,
                    ),
                    ToggleOutlinedButton(
                      isMaxWidth: true,
                      radius: kBorderRadius,
                      labelAlignment: Alignment.centerLeft,
                      onChanged: (value) {
                        if (value == StringConst.staticSalary) {
                          _selectedType = 1;
                        } else {
                          _selectedType = 2;
                        }
                      },
                      values: const [
                        StringConst.staticSalary,
                        StringConst.estimateSalary,
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    AppTextField(
                      elevation: 0.0,
                      hint: '2.500.000',
                      suffixIcon: Text(
                        StringConst.vnd,
                        style: AppTextStyles.hintTxtStyle,
                      ),
                      inputFormatters: InputFormatter.numberFormatter,
                      controller: _estimatedBudgetController,
                      formKey: _estimatedBudgetKey,
                    ),
                    // AppTextField(
                    //   elevation: 0.0,
                    //   hint: 'Tháng',
                    //   readOnly: true,
                    //   onTapTextField: () {},
                    //   suffixIcon: AppAsset.icArrowDropDown,
                    // ),
                    DropDownTextFieldButton(
                      elevation: 0.0,
                      itemHeight: 45.0,
                      isRequired: true,
                      choices: const ['Ngày', 'Tuần', 'Tháng', 'Năm'],
                      onChanged: (value) {
                        if (value == 'Ngày') {
                          _selectedSalaryType = 1;
                        } else if (value == 'Tuần') {
                          _selectedSalaryType = 2;
                        } else if (value == 'Tháng') {
                          _selectedSalaryType = 3;
                        } else
                          _selectedSalaryType = 4;
                        print(value);
                      },
                    ),
                    AppTextField(
                      elevation: 0.0,
                      labelTextStyle: _labelTextStyle,
                      hint: StringConst.selectStartDate,
                      readOnly: true,
                      label: StringConst.timeStartSetPrice,
                      isRequired: true,
                      suffixIcon: AppAsset.icCalendarDay,
                      controller: _startDayController,
                      validator: Validator.validateNotEmpty,
                      formKey: _startDayKey,
                      onTapTextField: () async {
                        var picked = await pickDate(context);
                        if (picked != null) {
                          _startDate = picked;
                          _startDayController.text =
                              DateFormat('yyyy-MM-dd').format(picked);
                        }
                      },
                    ),
                    AppTextField(
                      elevation: 0.0,
                      labelTextStyle: _labelTextStyle,
                      hint: StringConst.selectLastDate,
                      readOnly: true,
                      label: StringConst.timeLastSetPrice,
                      isRequired: true,
                      suffixIcon: AppAsset.icCalendarDay,
                      controller: _endDayController,
                      validator: (e) =>
                          Validator.validateTwoDate(_startDate, _endDate),
                      formKey: _endDAyKey,
                      onTapTextField: () async {
                        var picked = await pickDate(context);
                        if (picked != null) {
                          _endDate = picked;
                          _endDayController.text =
                              DateFormat('yyyy-MM-dd').format(picked);
                        }
                      },
                    ),
                    AppTextField(
                      elevation: 0.0,
                      labelTextStyle: _labelTextStyle,
                      hint: StringConst.selectDate,
                      readOnly: true,
                      label: StringConst.timeStartWorking,
                      isRequired: true,
                      suffixIcon: AppAsset.icCalendarDay,
                      controller: _startWorkDayController,
                      validator: (e) =>
                          Validator.validateTwoDate2(_endDate, _startWork),
                      formKey: _startWorkDayKey,
                      onTapTextField: () async {
                        var picked = await pickDate(context);
                        if (picked != null) {
                          // _selectedStartWorkDay = picked;
                          _startWork = picked;
                          _startWorkDayController.text =
                              DateFormat('yyyy-MM-dd').format(picked);
                        }
                      },
                    ),
                    AppTextField(
                      elevation: 0.0,
                      labelTextStyle: _labelTextStyle,
                      hint: 'VD: 1 tháng',
                      label: StringConst.workingTerm,
                      isRequired: true,
                      controller: _workingTermController,
                      inputFormatters: InputFormatter.numberFormatter,
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
            CoupleBottomOutlinedAndElevatedButtons(
              firstLabel: StringConst.cancel,
              secondaryLabel: StringConst.postJob,
              onPressedFirstButton: () {
                Navigator.pop(context);
              },
              onPressedSecondaryButton: () async {
                if (_expectedJobKey.currentState!.validate() &&
                    _expectedLocationKey.currentState!.validate() &&
                    _startDayKey.currentState!.validate() &&
                    _endDAyKey.currentState!.validate() &&
                    _startWorkDayKey.currentState!.validate() &&
                    _skillKey.currentState!.validate() &&
                    _estimatedBudgetKey.currentState!.validate() &&
                    _skillKey.currentState!.validate() &&
                    _titleJobKey.currentState!.validate()) {
                  var logo = await _loadLogo();
                  PostJobRepo _appRepo = PostJobRepo();
                  ResultData res = await _appRepo.postJob(
                      companyLogo: logo,
                      titleJob: _titleJobController.text,
                      categoryID: _selectedJob!.id,
                      workType: _selectedWorkingForm,
                      workCity: _selectedCity!.citId,
                      workExp: _selectedExp,
                      workDes: _jobDetailController.text,
                      skillId: _selectedSkill.map((e) => e.id).toList(),
                      salaryType: _selectedType,
                      salaryNumber: _estimatedBudgetController.text,
                      salaryDate: _selectedSalaryType,
                      startDay: _startDayController.text,
                      endDay: _endDayController.text,
                      startWorkDay: _startWorkDayController.text,
                      workingTerm: int.parse(_workingTermController.text),
                      jobType: 2);
                  if (res.result) {
                    showToast(res.message.toString());
                    Navigator.pop(context);
                  } else {
                    showToast(res.error.toString());
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

_buildRequireSkillChip({
  required String label,
}) {
  return AppChip(
    label: label,
    trailing: Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: SvgPicture.asset(
        AppAsset.icClose,
        color: AppColors.primaryColor,
      ),
    ),
  );
}

class _HeaderText extends StatelessWidget {
  const _HeaderText({
    Key? key,
    required this.text,
    this.padding,
  }) : super(key: key);
  final String text;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    var scrSize = MediaQuery.of(context).size;
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 15.0,
          ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 10.0 / 2,
            backgroundColor: AppColors.orangeAccent,
          ),
          const SizedBox(width: 10.0),
          SizedBox(
            width: 350.0,
            // (210.0 / 375.0 * scrSize.width).clamp(210.0, double.infinity),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                height: 24.55 / 18.0,
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
