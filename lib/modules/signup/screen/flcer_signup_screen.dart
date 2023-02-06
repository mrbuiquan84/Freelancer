import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freelancer/common/bloc/city/city_state.dart';
import 'package:freelancer/common/bloc/city/select_city_bloc.dart';
import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/button/app_outlined_button.dart';
import 'package:freelancer/common/widgets/button/help_text_button.dart';
import 'package:freelancer/common/widgets/button/outlined_radio_button.dart';
import 'package:freelancer/common/widgets/form/dropdown_textfield_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/common/widgets/appbar/unauthenticated_appbar.dart';
import 'package:freelancer/common/widgets/popup/load_popup.dart';
import 'package:freelancer/common/widgets/text_field_label.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/signup/bloc/signup_bloc.dart';
import 'package:freelancer/modules/signup/bloc/signup_state.dart';
import 'package:freelancer/modules/signup/widget/toggle_outlined_button.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/city.dart';
import 'package:freelancer/utils/data/gender.dart';
import 'package:freelancer/utils/data/salary_type.dart';
import 'package:freelancer/utils/data/time.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/helpers/input_formatter.dart';
import 'package:freelancer/utils/helpers/pick_date.dart';
import 'package:freelancer/utils/helpers/pick_image.dart';
import 'package:freelancer/utils/helpers/validators.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:freelancer/utils/ui/show_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FlcerSignupScreen extends StatefulWidget {
  const FlcerSignupScreen({Key? key}) : super(key: key);

  @override
  State<FlcerSignupScreen> createState() => _FlcerSignupScreenState();
}

class _FlcerSignupScreenState extends State<FlcerSignupScreen> {
  var unAuthAppBar = const UnAuthAppBar(
    title: StringConst.flcerSignup,
  );

  final ValueNotifier<XFile?> _selectedAvatar = ValueNotifier(null);

  Gender _selectedGender = Gender.male;
  SalaryType _selectedSalaryType = SalaryType.staticSalaryType;
  Time _selectedTime = Time.day;

  DateTime? _selectedDob;
  City? _selectedCity;
  City? _selectedDistrict;
  List<JobCate> _selectedJobCate = [];

  late final AppRepo _appRepo;
  late final SignUpBloc _signupBloc;
  late final AuthBloc _authBloc;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _salaryTimeController = TextEditingController();

  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dobKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _cityKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _districtKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _rePasswordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _salaryKey = GlobalKey<FormState>();

  bool _isShowingDialog = false;

  @override
  void initState() {
    _appRepo = context.read<AppRepo>();
    _signupBloc = context.read<SignUpBloc>();
    _authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var imageSize = (MediaQuery.of(context).size.width / 3).clamp(0.0, 120.0);

    var uploadAvatarButton = Padding(
      padding: EdgeInsets.symmetric(vertical: kPadding(context)),
      child: AppOutlinedButton(
        child: StringConst.uploadAvatar,
        labelTextStyle: const TextStyle(
          color: AppColors.orangeAccent,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        buttonPrimaryColor: AppColors.orangeAccent,
        onPressed: () async {
          var pickedImage = await pickImage(context);
          if (pickedImage != null) {
            _selectedAvatar.value = pickedImage;
          }
        },
      ),
    );

    var loginFooter = HelpTextButton(
      header: StringConst.alreadyHaveAccount,
      label: StringConst.loginNow,
      onPressed: () {
        AppRouter.toPage(
          context,
          AppPages.login,
          blocValue: _authBloc,
        );
      },
    );

    Widget avatar = ClipOval(
      child: ValueListenableBuilder<XFile?>(
        valueListenable: _selectedAvatar,
        builder: (context, avatar, __) {
          if (avatar == null) {
            return Image.asset(
              AppAsset.imgNonAvatar,
              height: imageSize,
              width: imageSize,
              fit: BoxFit.cover,
            );
          } else {
            return Image.file(
              File(avatar.path),
              height: imageSize,
              width: imageSize,
              fit: BoxFit.cover,
            );
          }
        },
      ),
    );

    var textFieldHeight = 40.0;
    var _textFieldTextStyle = AppTextStyles.inputTextStyle.copyWith(
      fontSize: 16,
      height: 26 / 16,
      color: AppColors.hintColor,
    );
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          unAuthAppBar,
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(
                kPadding(context),
                unAuthAppBar.appbarHeight,
                kPadding(context),
                kPadding(context),
              ),
              padding: EdgeInsets.all(kPadding(context)),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kBorderRadius),
                border: Border.all(
                  width: 1,
                  color: AppColors.borderColor,
                ),
              ),
              child: BlocListener(
                bloc: _signupBloc,
                listener: (_, state) {
                  if (_isShowingDialog) {
                    _isShowingDialog = false;
                    AppRouter.back(context);
                  }
                  if (state is SignupLoadState) {
                    _isShowingDialog = true;
                    showDialog(
                      context: context,
                      builder: (_) => const LoadPopup(),
                    ).then((value) => _isShowingDialog = false);
                  } else if (state is SignupErrorState) {
                    showToast(state.error);
                  } else if (state is SignupReceivedOTPState &&
                      ModalRoute.of(context)?.settings.name !=
                          AppPages.signupOtp.name) {
                    AppRouter.toPage(
                      context,
                      AppPages.signupOtp,
                      blocValue: _signupBloc,
                      arguments: {StringConst.tokenKey: state.token},
                    );
                  }
                },
                child: Column(
                  children: [
                    avatar,
                    uploadAvatarButton,
                    AppTextField(
                      inputTextStyle: _textFieldTextStyle,
                      height: 40,
                      elevation: 0.0,
                      hint: StringConst.askName,
                      label: StringConst.nameLabel,
                      isRequired: true,
                      controller: _nameController,
                      validator: Validator.validateName,
                      inputFormatters: InputFormatter.nameFormatter,
                      formKey: _nameKey,
                    ),
                    AppTextField(
                      inputTextStyle: _textFieldTextStyle,
                      height: 40,
                      elevation: 0.0,
                      hint: StringConst.askPhone,
                      label: StringConst.phoneLabel,
                      isRequired: true,
                      controller: _phoneController,
                      validator: Validator.validatePhone,
                      inputFormatters: InputFormatter.phoneFormatter,
                      formKey: _phoneKey,
                    ),
                    DropDownTextFieldButton(
                      choices: Gender.values,
                      label: StringConst.genderLabel,
                      isRequired: true,
                      itemHeight: 40,
                      borderColor: AppColors.hintColor,
                      buttonTextStyle: AppTextStyles.inputTextStyle.copyWith(
                        fontSize: 16,
                        height: 26 / 16,
                        color: AppColors.hintColor,
                      ),
                      onChanged: (value) => _selectedGender = value as Gender,
                    ),
                    AppTextField(
                      inputTextStyle: _textFieldTextStyle,
                      hint: StringConst.askDob,
                      label: StringConst.dobLabel,
                      isRequired: true,
                      height: 40,
                      controller: _dobController,
                      validator: Validator.validateNotEmpty,
                      formKey: _dobKey,
                      readOnly: true,
                      suffixIcon: AppAsset.icCalendarDay,
                      onTapTextField: () async {
                        var picked = await pickDate(context);
                        if (picked != null) {
                          _selectedDob = picked;
                          _dobController.text =
                              DateFormat('yyyy-MM-dd').format(picked);
                        }
                      },
                    ),
                    AppTextField(
                      inputTextStyle: _textFieldTextStyle,
                      height: 40,
                      elevation: 0.0,
                      hint: StringConst.askCity,
                      label: StringConst.cityLabel,
                      isRequired: true,
                      controller: _cityController,
                      validator: Validator.validateCity,
                      formKey: _cityKey,
                      readOnly: true,
                      suffixIcon: AppAsset.icArrowDropDown,
                      onTapTextField: () async {
                        var pickedCity = await AppRouter.toPage(
                          context,
                          AppPages.selectCity,
                          blocValue: CityBloc(
                            CityListState(
                              _appRepo.cities,
                              selectedCities:
                                  _selectedCity != null ? [_selectedCity!] : [],
                            ),
                            appRepo: _appRepo,
                          ),
                        );
                        if (pickedCity != null) {
                          _selectedCity = (pickedCity as List)[0] as City;
                          _cityController.text = _selectedCity.toString();
                        }
                      },
                    ),
                    AppTextField(
                      inputTextStyle: _textFieldTextStyle,
                      height: 40,
                      elevation: 0.0,
                      hint: StringConst.askDistrict,
                      label: StringConst.districtLabel,
                      isRequired: true,
                      controller: _districtController,
                      validator: Validator.validateDistrict,
                      formKey: _districtKey,
                      readOnly: true,
                      suffixIcon: AppAsset.icArrowDropDown,
                      onTapTextField: () async {
                        if (_selectedCity != null) {
                          var districtBloc = CityBloc(
                            CityLoadState(),
                            appRepo: _appRepo,
                          );
                          districtBloc.getDistricts(_selectedCity!.citId);
                          var pickedCity = await AppRouter.toPage(
                            context,
                            AppPages.selectDistrict,
                            blocValue: districtBloc,
                          );
                          if (pickedCity != null) {
                            _selectedDistrict = (pickedCity as List)[0] as City;
                            _districtController.text =
                                _selectedDistrict.toString();
                          }
                        } else {
                          showToast(StringConst.selectCityFirst);
                        }
                      },
                    ),
                    AppTextField(
                      inputTextStyle: _textFieldTextStyle,
                      height: 40,
                      elevation: 0.0,
                      hint: StringConst.askEmail,
                      label: StringConst.emailLabel,
                      isRequired: true,
                      controller: _emailController,
                      formKey: _emailKey,
                      validator: Validator.validateEmail,
                      inputFormatters: InputFormatter.emailFormatter,
                    ),
                    AppTextField(
                      inputTextStyle: _textFieldTextStyle,
                      height: 40,
                      elevation: 0.0,
                      hint: StringConst.askPassword,
                      label: StringConst.passwordLabel,
                      isRequired: true,
                      controller: _passwordController,
                      formKey: _passwordKey,
                      isPassword: true,
                      validator: Validator.validatePassword,
                      inputFormatters: InputFormatter.passwordFormatter,
                    ),
                    AppTextField(
                      inputTextStyle: _textFieldTextStyle,
                      height: 40,
                      elevation: 0.0,
                      hint: StringConst.askPassword,
                      label: StringConst.rePasswordLabel,
                      isRequired: true,
                      controller: _rePasswordController,
                      formKey: _rePasswordKey,
                      isPassword: true,
                      validator: (value) => Validator.validateNewPassword(
                        _passwordController.text,
                        value,
                      ),
                    ),
                    AppTextField(
                      inputTextStyle: _textFieldTextStyle,
                      height: 40,
                      elevation: 0.0,
                      hint: StringConst.askSalary,
                      label: StringConst.salaryLabel,
                      isRequired: true,
                      validator: (value) => Validator.salaryValidator(
                        value,
                        salaryType: _selectedSalaryType,
                      ),
                      controller: _salaryController,
                      formKey: _salaryKey,
                      trailing: Align(
                        alignment: Alignment.centerRight,
                        child: ToggleOutlinedButton(
                          values: SalaryType.values,
                          onChanged: (value) {
                            _selectedSalaryType = value as SalaryType;
                          },
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: textFieldHeight,
                            alignment: Alignment.centerRight,
                            child: Text(
                              '/',
                              style: AppTextStyles.hintTxtStyle
                                  .copyWith(fontSize: 20.0),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          flex: 1,
                          child: DropDownTextFieldButton(
                            elevation: 0.0,
                            itemHeight: textFieldHeight,
                            hint: StringConst.week,
                            controller: _salaryTimeController,
                            choices: Time.values,
                            onChanged: (value) => _selectedTime = value as Time,
                          ),
                        ),
                      ],
                    ),
                    const TextFieldLabel(
                      label: StringConst.fieldOfWork,
                      isRequired: true,
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 5.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        StringConst.ableToSelectMultiFieldOfWorkHelper,
                        style: AppTextStyles.hintTxtStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _ListJobCateWidget(
                      appRepo: _appRepo,
                      selectedJobCate: _selectedJobCate,
                      onChanged: (value) {
                        _selectedJobCate = [...value];
                      },
                    ),
                    const SizedBox(height: 50 - kTextFieldBottomPadding),
                    AppElevatedButton(
                      label: StringConst.signUp,
                      width: double.infinity,
                      onPressed: () async {
                        if (_phoneKey.currentState!.validate() &&
                            _nameKey.currentState!.validate() &&
                            _dobKey.currentState!.validate() &&
                            _cityKey.currentState!.validate() &&
                            _districtKey.currentState!.validate() &&
                            _emailKey.currentState!.validate() &&
                            _passwordKey.currentState!.validate() &&
                            _rePasswordKey.currentState!.validate() &&
                            _salaryKey.currentState!.validate()) {
                          if (_selectedJobCate.isEmpty) {
                            showToast('Chọn ít nhất 1 lĩnh vực làm việc !');
                            return;
                          } else {
                            int minSalary;
                            int? maxSalary;
                            if (_selectedSalaryType ==
                                SalaryType.staticSalaryType) {
                              minSalary = int.parse(_salaryController.text);
                            } else {
                              var s = _salaryController.text.trim().split(' ');
                              s.removeWhere((_s) => _s == ' ');
                              minSalary = int.parse(s[0]);
                              maxSalary = int.parse(s[2]);
                            }
                            var avatar = await _loadAvatar();
                            _signupBloc.signupFlcer(
                              email: _emailController.text,
                              phone: _phoneController.text,
                              name: _nameController.text,
                              gender: _selectedGender,
                              password: _passwordController.text,
                              city: _selectedCity!,
                              district: _selectedDistrict!,
                              birthday: _selectedDob!,
                              salaryType: _selectedSalaryType,
                              listCate:
                                  _selectedJobCate.map((e) => e.id).toList(),
                              minSalary: minSalary,
                              maxSalary: maxSalary ?? minSalary,
                              salaryTime: _selectedTime,
                              avatarUser: avatar,
                            );
                          }
                        }
                      },
                    ),
                    loginFooter,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _loadAvatar() async {
    var avatar = _selectedAvatar.value;
    if (avatar != null) {
      return await MultipartFile.fromFile(
        avatar.path,
        filename: avatar.path.split('/').last,
      );
    }
    return null;
  }
}

class _ListJobCateWidget extends StatefulWidget {
  const _ListJobCateWidget({
    Key? key,
    required AppRepo appRepo,
    this.selectedJobCate = const [],
    this.onChanged,
  })  : _appRepo = appRepo,
        super(key: key);

  final AppRepo _appRepo;
  final List<JobCate> selectedJobCate;
  final ValueChanged<List<JobCate>>? onChanged;

  @override
  State<_ListJobCateWidget> createState() => _ListJobCateWidgetState();
}

class _ListJobCateWidgetState extends State<_ListJobCateWidget> {
  late List<JobCate> _selectedJobCate;
  late List<JobCate> _jobCates;
  late final List<GlobalKey<CustomRadioButtonState>> _keys;

  @override
  void initState() {
    super.initState();
    _selectedJobCate = [...widget.selectedJobCate];
    _jobCates = widget._appRepo.jobCates;
    _keys = _jobCates.map((e) => GlobalKey<CustomRadioButtonState>()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (_, index) {
        var e = widget._appRepo.jobCates[index];
        return CustomRadioButton(
          value: e,
          selected: _selectedJobCate.contains(e),
          textStyle: AppTextStyles.inputTextStyle.copyWith(
            fontSize: 16,
            height: 26 / 16,
            color: AppColors.textColor,
          ),
          height: 40,
          key: _keys[index],
          beforeChange: (selected) {
            if (!selected) {
              if (_selectedJobCate.length >= 3) {
                showToast(StringConst.selectOutOfMaxRange(max: 3));
                return false;
              }
            }
            return true;
          },
          onChanged: (isSelected) {
            _onChanged(isSelected, e);
            if (widget.onChanged != null) {
              widget.onChanged!(_selectedJobCate);
            }
          },
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget._appRepo.jobCates.length,
    );
  }

  void _onChanged(bool isSelected, JobCate e) {
    if (isSelected) {
      _selectedJobCate.add(e);
    } else {
      _selectedJobCate.remove(e);
    }
  }
}
