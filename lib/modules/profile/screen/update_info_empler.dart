import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/bloc/city/city_state.dart';
import 'package:freelancer/common/bloc/city/select_city_bloc.dart';

import 'package:freelancer/common/widgets/app_circle_avatar.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/form/dropdown_textfield_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/user_type.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../utils/data/city.dart';
import '../../../utils/data/gender.dart';
import '../../../utils/helpers/pick_date.dart';
import '../../../utils/helpers/validators.dart';
import '../../../utils/ui/show_toast.dart';
import '../bloc/update_empler_profile/update_empler_profile_repo.dart';

class UpdateInfoEmplerPage extends StatefulWidget {
  const UpdateInfoEmplerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateInfoEmplerPage> createState() => _UpdateInfoEmplerState();
}

class _UpdateInfoEmplerState extends State<UpdateInfoEmplerPage> {
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();
  final _mailController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();

  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _dobKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _cityKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _districtKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _genderKey = GlobalKey<FormState>();
  late final AppRepo _appRepo;
  // late final UpdateEmplerProfileBloc _updatebloc;
  City? _selectedCity;
  City? _selectedDistrict;
  Gender _selectedGender = Gender.male;
  DateTime? _selectedDob;
  final UserType userType = UserType.employer;
  // late final String token;

  @override
  void initState() {
    _appRepo = context.read<AppRepo>();
    super.initState();
    final emplerInfoBloc = CurrentUser.of(context).emplerProfileBloc!;
    final info = emplerInfoBloc.emplerInfo!;
    _nameController.text = info.name;
    _dobController.text = DateFormat('yyyy-MM-dd').format(info.birthday);
    _genderController.text = info.sex;
    _selectedGender = Gender.fromGender(info.sex);
    _phoneController.text = info.phone;
    _mailController.text = info.email;
    _cityController.text = info.city;
    _districtController.text = info.district;
  }

  final TextStyle _labelTextStyle = const TextStyle(
    fontFamily: AppConst.fontNunito,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 26 / 16.0,
    color: AppColors.textColor,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppAppBar(
          title: Text(StringConst.updateProfile),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          color: AppColors.white,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: kPadding(context),
              vertical: 15.0,
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const AppCircleAvatar(
                      nonAvatarAsset: AppAsset.imgColoredNonAvatar1,
                      imgSize: 100.0,
                    ),
                    InkWell(
                      child: SvgPicture.asset(AppAsset.icCircleCamera),
                      onTap: () {},
                    ),
                  ],
                ),
                AppTextField(
                  elevation: 0,
                  labelTextStyle: _labelTextStyle,
                  label: StringConst.nameLabel,
                  hint: StringConst.askName,
                  formKey: _nameKey,
                  controller: _nameController,
                  validator: Validator.validateName,
                  isRequired: true,
                  readOnly: false,
                ),
                AppTextField(
                  hint: StringConst.askDob,
                  label: StringConst.dobLabel,
                  isRequired: true,
                  // height: 40,
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
                DropDownTextFieldButton(
                    elevation: 0,
                    labelTextStyle: _labelTextStyle,
                    label: StringConst.genderLabel,
                    controller: _genderController,
                    choices: const ['Nam', 'Nữ', 'Khác'],
                    isRequired: true,
                    buttonTextStyle: AppTextStyles.inputTextStyle.copyWith(
                      fontSize: 20,
                      height: 26 / 16,
                      color: AppColors.hintColor,
                    ),
                    onChanged: (value) {
                      _selectedGender = Gender.fromStringId(value.toString());
                      _genderController.text = _selectedGender.toString();
                    }),
                AppTextField(
                  elevation: 0,
                  labelTextStyle: _labelTextStyle,
                  label: StringConst.phoneLabel,
                  hint: StringConst.askPhone,
                  formKey: _phoneKey,
                  controller: _phoneController,
                  validator: Validator.validatePhone,
                  isRequired: true,
                  keyboardType: TextInputType.phone,
                ),
                AppTextField(
                  elevation: 0,
                  labelTextStyle: _labelTextStyle,
                  label: StringConst.loginMailLabel,
                  hint: StringConst.askEmail,
                  controller: _mailController,
                  validator: Validator.validateEmail,
                  formKey: _emailKey,
                  isRequired: true,
                  readOnly: true,
                ),
                AppTextField(
                  elevation: 0,
                  labelTextStyle: _labelTextStyle,
                  label: StringConst.cityLabel,
                  hint: StringConst.askCity,
                  controller: _cityController,
                  validator: Validator.validateCity,
                  formKey: _cityKey,
                  isRequired: true,
                  readOnly: true,
                  suffixIcon: AppAsset.icArrowDropDown,
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
                      _cityController.text = _selectedCity.toString();
                    }
                  },
                ),
                AppTextField(
                  elevation: 0,
                  labelTextStyle: _labelTextStyle,
                  label: StringConst.districtLabel,
                  hint: StringConst.askDistrict,
                  formKey: _districtKey,
                  controller: _districtController,
                  validator: Validator.validateDistrict,
                  isRequired: true,
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
                        AppPages.selectDistricUserPage,
                        blocValue: districtBloc,
                      );
                      if (pickedCity != null) {
                        _selectedDistrict = (pickedCity as List)[0] as City;
                        _districtController.text = _selectedDistrict.toString();
                      }
                    } else {
                      showToast(StringConst.selectCityFirst);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    bottom: 50.0,
                  ),
                  child: AppElevatedButton(
                      label: StringConst.update,
                      elevation: 0,
                      labelTextStyle: AppTextStyles.buttonNormalTxtStyle,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 45.0,
                        vertical: 10.0,
                      ),
                      onPressed: () async {
                        // emit(UpdateEmplerProfileLoadState());
                        if (_nameKey.currentState!.validate() &&
                            _dobKey.currentState!.validate() &&
                            _cityKey.currentState!.validate() &&
                            _districtKey.currentState!.validate() &&
                            _phoneKey.currentState!.validate()) {
                          if (_selectedCity != null &&
                              _selectedDistrict != null) {
                            var repo = UpdateEmperProfileRepo();
                            var res = await repo.updateEmplerProfileRepo(
                                name: _nameController.text,
                                gender: _selectedGender.id,
                                city: _selectedCity!.citId,
                                phone: _phoneController.text,
                                district: _selectedDistrict!.citId,
                                birthday: _dobController.text);
                            if (res.result) {
                              showToast(res.message.toString());
                              Navigator.pop(context);
                            } else {
                              showToast(res.error.toString());
                            }
                          } else {
                            showToast("Vui lòng điền đầy đủ thông tin");
                          }
                        }
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
