import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelancer/common/bloc/city/city_state.dart';
import 'package:freelancer/common/bloc/city/select_city_bloc.dart';
import 'package:freelancer/common/models/empler.dart';
import 'package:freelancer/common/models/flcer.dart';
import 'package:freelancer/common/services/share_pref/pref_service.dart';
import 'package:freelancer/common/widgets/app_circle_avatar.dart';
import 'package:freelancer/common/widgets/appbar/unauthenticated_appbar.dart';
import 'package:freelancer/common/widgets/button/app_elevated_button.dart';
import 'package:freelancer/common/widgets/form/dropdown_textfield_button.dart';
import 'package:freelancer/common/widgets/form/outline_text_form_field.dart';
import 'package:freelancer/core/constants/app_constants.dart';
import 'package:freelancer/core/constants/asset_path.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/core/theme/app_colors.dart';
import 'package:freelancer/core/theme/app_text_styles.dart';
import 'package:freelancer/modules/auth/bloc/auth_bloc.dart';
import 'package:freelancer/modules/auth/model/empler_info.dart';
import 'package:freelancer/modules/bloc/app_repo.dart';
import 'package:freelancer/modules/profile/bloc/flcer_profile_bloc/flcer_profile_repo.dart';
import 'package:freelancer/modules/profile/bloc/update_empler_profile/update_empler_profile_repo.dart';
import 'package:freelancer/modules/profile/bloc/update_flcer_profile/update_flcer_profile_bloc.dart';
import 'package:freelancer/modules/profile/bloc/update_flcer_profile/update_flcer_profile_repo.dart';
import 'package:freelancer/modules/signup/model/post_signup_flcer_result.dart';
import 'package:freelancer/router/app_pages.dart';
import 'package:freelancer/router/app_router.dart';
import 'package:freelancer/utils/data/user_type.dart';
import 'package:freelancer/utils/helpers/datetime_extension.dart';
import 'package:freelancer/utils/ui/app_num.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../utils/data/city.dart';
import '../../../utils/data/gender.dart';
import '../../../utils/helpers/pick_date.dart';
import '../../../utils/helpers/pick_image.dart';
import '../../../utils/helpers/validators.dart';
import '../../../utils/ui/show_toast.dart';

class UpdateBasicInfoPage extends StatefulWidget {
  const UpdateBasicInfoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateBasicInfoPage> createState() => _UpdateBasicInfoPageState();
}

class _UpdateBasicInfoPageState extends State<UpdateBasicInfoPage> {
  // final ValueNotifier<XFile?> _selectedAvatar = ValueNotifier(null);
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
  String? scravatar;
  // late final UpdateFlcerProfileBloc _updatebloc;
  City? _selectedCity;
  City? _selectedDistrict;
  int? _selectedDistrictId;
  Gender? _selectedGender;
  final UserType userType = UserType.freelancer;
  // late final String token;

  @override
  void initState() {
    _appRepo = context.read<AppRepo>();
    super.initState();

    final flcerInfoBloc = CurrentUser.of(context).flcerProfileBloc!;
    final info = flcerInfoBloc.flcerInfo!.info;
    _nameController.text = info.name;
    _selectedCity = City.fromId(int.parse(info.cityId), list: _appRepo.cities);
    _selectedDistrictId = int.parse(info.districtId);
    _dobController.text = DateFormat('yyyy-MM-dd').format(info.birthday);
    _selectedGender = Gender.fromStringId(info.sex);
    // _phoneController.text = info.phone;
    _mailController.text = info.email;
    _cityController.text = info.city;
    _genderController.text = info.sex;
    _districtController.text = info.district;
    scravatar = info.srcAvatar;
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
                AppCircleAvatar(
                  avatar: scravatar,
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
            // AppTextField(
            //   elevation: 0,
            //   labelTextStyle: _labelTextStyle,
            //   label: StringConst.dobLabel,
            //   hint: StringConst.askDob,
            //   formKey: _dobKey,
            //   controller: _dobController,
            //   validator: Validator.validateNotEmpty,
            //   isRequired: true,
            //   readOnly: false,
            //   suffixIcon: AppAsset.icCalendarMonth,
            // ),
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
                  // _selectedDob = picked;
                  _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
                }
              },
            ),
            DropDownTextFieldButton(
                elevation: 0,
                labelTextStyle: _labelTextStyle,
                label: StringConst.genderLabel,
                itemHeight: 40,
                controller: _genderController,
                choices: const ['Nữ', 'Nam', 'Khác'],
                isRequired: true,
                onChanged: (value) {
                  _selectedGender = Gender.fromStringId(value.toString());
                  _genderController.text = _selectedGender.toString();
                }),
            // AppTextField(
            //   elevation: 0,
            //   labelTextStyle: _labelTextStyle,
            //   label: StringConst.phoneLabel,
            //   hint: StringConst.askPhone,
            //   formKey: _phoneKey,
            //   controller: _phoneController,
            //   isRequired: true,
            //   keyboardType: TextInputType.phone,
            // ),
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
                      selectedCities: [_selectedCity!],
                    ),
                    appRepo: _appRepo,
                  ),
                );
                // _selectedCity = (pickedCity as List)[0] as City;
                // _cityController.text = _selectedCity.toString();
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
                    _selectedDistrictId = _selectedDistrict!.citId;
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
                    if (_nameKey.currentState!.validate() &&
                        _dobKey.currentState!.validate() &&
                        _cityKey.currentState!.validate() &&
                        _districtKey.currentState!.validate()) {
                      // var res = UpdateFlcerProfileBloc(appRepo: _appRepo);
                      var _repo = UpdateFlcerProfileRepo();
                      var res = await _repo.updateFlcerProfileRepo(
                          name: _nameController.text,
                          gender: _selectedGender!.id,
                          city: _selectedCity!.citId,
                          district: _selectedDistrictId!,
                          birthday: _dobController.text);
                      // AppRouter.backToPage(
                      //     context, AppPages.flcerGeneralManagement);
                      if (res.result) {
                        showToast(res.message.toString());
                        AppRouter.backToPage(
                            context, AppPages.flcerGeneralManagement);
                      } else {
                        showToast(res.error.toString());
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
