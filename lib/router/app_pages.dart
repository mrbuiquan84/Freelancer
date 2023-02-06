// ignore_for_file: unused_element

import 'package:freelancer/common/widgets/form/select_city_page.dart';
import 'package:freelancer/common/widgets/form/select_city_user_page.dart';
import 'package:freelancer/common/widgets/form/select_district_page.dart';
import 'package:freelancer/common/widgets/form/select_district_user_page.dart';
import 'package:freelancer/common/widgets/form/select_expected_location_page.dart';
import 'package:freelancer/common/widgets/form/select_job_user_page.dart';
import 'package:freelancer/modules/empler/post_job_by_project_screen.dart';
import 'package:freelancer/modules/empler/post_job_partime_screen.dart';
import 'package:freelancer/modules/flcer/flcer_screen.dart';
import 'package:freelancer/modules/home/flcer/list_job_by_cate_screen.dart';
import 'package:freelancer/modules/auth/screen/choose_action_screen.dart';
import 'package:freelancer/modules/auth/screen/login_screen.dart';
import 'package:freelancer/modules/auth/screen/waitting_screen.dart';
import 'package:freelancer/modules/empler/empler_screen.dart';
import 'package:freelancer/modules/forgot_password/forgot_password_otp_screen.dart';
import 'package:freelancer/modules/forgot_password/forgot_password_screen.dart';
import 'package:freelancer/modules/forgot_password/update_password_screen.dart';
import 'package:freelancer/modules/forgot_password/update_password_success.dart';
import 'package:freelancer/modules/home/flcer/list_job_by_type_screen.dart';
import 'package:freelancer/modules/home/flcer/model/list_flcer_screen.dart';
import 'package:freelancer/modules/home/nonflcer_home_page.dart';
import 'package:freelancer/modules/home/user_home_screen.dart';
import 'package:freelancer/modules/intro/screens/intro_screen.dart';
import 'package:freelancer/modules/job/job_detail_screen.dart';
import 'package:freelancer/modules/profile/screen/change_password_screen.dart';
import 'package:freelancer/modules/profile/screen/empler_flcer_managerment_screen.dart';
import 'package:freelancer/modules/profile/screen/empler_general_managerment_page.dart';
import 'package:freelancer/modules/profile/screen/empler_info_screen.dart';
import 'package:freelancer/modules/profile/screen/empler_saved_flcer.dart';
import 'package:freelancer/modules/profile/screen/general_management_page.dart';
import 'package:freelancer/modules/profile/screen/ongoing_project_screen.dart';
import 'package:freelancer/modules/profile/screen/posted_job_screen.dart';
import 'package:freelancer/modules/profile/screen/saved_project_screen.dart';
import 'package:freelancer/modules/profile/screen/set_price_project_screen.dart';
import 'package:freelancer/modules/profile/screen/update_basic_info_page.dart';
import 'package:freelancer/modules/profile/screen/update_info_empler.dart';
import 'package:freelancer/modules/profile/screen/update_profile_page.dart';
import 'package:freelancer/modules/search/list_search_result_screen.dart';
import 'package:freelancer/modules/search/models/list_search_flcer_result_screen.dart';
import 'package:freelancer/modules/search/models/search_flcer_screen.dart';
import 'package:freelancer/modules/search/search_filter_screen.dart';
import 'package:freelancer/modules/search/search_screen.dart';
import 'package:freelancer/modules/signup/screen/empler_signup_screen.dart';
import 'package:freelancer/modules/signup/screen/flcer_signup_screen.dart';
import 'package:freelancer/modules/signup/screen/signup_otp_screen.dart';
import 'package:freelancer/modules/signup/screen/signup_success_screen.dart';
import 'package:freelancer/modules/tutorial/hire_flcer_tutorial_screen.dart';
import 'package:freelancer/router/page_config.dart';

import '../common/widgets/form/select_skill_user_page.dart';
import '../modules/search/models/search_filler_flcer_screen.dart';
import '../modules/signup/screen/signup_empler_otp_screen.dart';

enum AppPages {
  login,
  flcerSignUp,
  emplerSignup,
  initial,
  intro,
  waiting,
  chooseAction,
  selectCity,
  selectDistrict,
  signupOtp,
  signupEmplerOtp,
  forgotPasswordOtp,
  signupSuccess,
  home,
  forgotPassword,
  updatePassword,
  updatePasswordSuccess,
  listJob,
  search,
  filterSearch,
  emplerDetail,
  flcerSavedProjects,
  flcerOngoingProjects,
  listSearchResult,
  listSearchFlcerResult,
  listJobByJobType,
  jobDetail,

  updateProfilePage,
  changePasswordScreen,
  flcerGeneralManagement,
  ongoingProjectScreen,
  savedProjectScreen,
  postedJobScreen,
  setPriceProjectScreen,

  selectCityUserPage,
  selectDistricUserPage,
  selectExpectedLocationPage,
  selectJobUserPage,
  selectSkillUserPage,
  emplerGeneralManagement,
  updateBasicInfo,
  updateInfoEmpler,
  emplerInfor,
  hireFlcerTutorial,
  postJobByProject,
  postJobPartime,
  emplerFlcerManagement,
  flcerDetail,
  searchFlcer,
  searchFillerFlcer,
  postedJob,
  listFlcerSceen,
  nonFlcer,
}

String _getPageArgumentErrorString(List<String> args) => args.join(', ');

void _checkMissingRequiredArgumentsAndAssureError(
    Map<String, dynamic>? arguments, List<String> argNames) {
  try {
    if (arguments == null) {
      throw ArgumentError.notNull(_getPageArgumentErrorString(argNames));
    }

    final List<String> missingArgNames =
        argNames.where((e) => arguments.containsKey(e) == false).toList();

    if (missingArgNames.isNotEmpty) {
      throw ArgumentError.notNull(_getPageArgumentErrorString(missingArgNames));
    }
  } catch (e) {
    print(e);
    rethrow;
  }
}

extension AppPagesExtension on AppPages {
  String get key => toString()
      .split('.')
      .last
      .replaceAll(r'_', '.')
      .replaceAllMapped(
        RegExp(r'(?<=[a-z])[A-Z]'),
        (Match m) => "_${m.group(0) ?? ''}",
      )
      .toLowerCase();

  String get path => "/${key.replaceAll(r'.', '/')}";

  String get name => path;

  static PageConfig getPageConfig(
      AppPages page, Map<String, dynamic>? arguments) {
    switch (page) {
      case AppPages.login:
        return PageConfig()..pageBuilder = () => const LoginScreen();

      case AppPages.flcerSignUp:
        return PageConfig()..pageBuilder = () => const FlcerSignupScreen();

      case AppPages.emplerSignup:
        return PageConfig()..pageBuilder = () => const EmplerSignupScreen();

      case AppPages.intro:
        return PageConfig()..pageBuilder = () => const IntroPage();

      case AppPages.waiting:
        return PageConfig()..pageBuilder = () => const WaitingScreen();

      case AppPages.chooseAction:
        return PageConfig()..pageBuilder = () => const ChooseActionScreen();

      case AppPages.selectCity:
        return PageConfig()..pageBuilder = () => const SelectCityPage();

      case AppPages.selectDistrict:
        return PageConfig()..pageBuilder = () => const SelectDistrictPage();

      case AppPages.signupOtp:
        return PageConfig()..pageBuilder = () => const SignupOTPScreen();
      case AppPages.signupEmplerOtp:
        return PageConfig()..pageBuilder = () => const SignupEmplerOTPScreen();

      case AppPages.signupSuccess:
        return PageConfig()..pageBuilder = () => const SignupSuccessScreen();

      case AppPages.home:
        return PageConfig()..pageBuilder = () => const UserHomeScreen();
      case AppPages.nonFlcer:
        return PageConfig()..pageBuilder = () => const NonFlcerHomePage();

      case AppPages.forgotPassword:
        return PageConfig()..pageBuilder = () => const ForgotPasswordScreen();

      case AppPages.forgotPasswordOtp:
        return PageConfig()
          ..pageBuilder = () => const ForgotPasswordOTPScreen();

      case AppPages.updatePassword:
        return PageConfig()..pageBuilder = () => const UpdatePasswordScreen();

      case AppPages.updatePasswordSuccess:
        return PageConfig()
          ..pageBuilder = () => const UpdatePasswordSuccessScreen();

      case AppPages.listJob:
        return PageConfig()..pageBuilder = () => const ListJobByCateScreen();

      case AppPages.search:
        return PageConfig()..pageBuilder = () => const SearchScreen();

      case AppPages.filterSearch:
        return PageConfig()..pageBuilder = () => const SearchFilterScreen();

      case AppPages.emplerDetail:
        return PageConfig()..pageBuilder = () => const EmplerScreen();

      case AppPages.emplerInfor:
        return PageConfig()..pageBuilder = () => const EmplerInfoScreen();

      case AppPages.flcerGeneralManagement:
        return PageConfig()
          ..pageBuilder = () => const FlcerGeneralManagementPage();

      case AppPages.flcerSavedProjects:
        return PageConfig()..pageBuilder = () => const SavedProjectScreen();
      case AppPages.flcerDetail:
        return PageConfig()..pageBuilder = () => const FlcerScreen();

      case AppPages.flcerOngoingProjects:
        return PageConfig()..pageBuilder = () => const OngoingProjectScreen();

      case AppPages.listSearchResult:
        return PageConfig()..pageBuilder = () => const ListSearchResultScreen();
      case AppPages.listSearchFlcerResult:
        return PageConfig()
          ..pageBuilder = () => const ListSearchFlcerResultScreen();

      case AppPages.listJobByJobType:
        return PageConfig()..pageBuilder = () => const ListJobByJobTypeScreen();
      case AppPages.jobDetail:
        return PageConfig()..pageBuilder = () => const JobDetailScreen();

      case AppPages.updateProfilePage:
        return PageConfig()..pageBuilder = () => const UpdateProfilePage();

      case AppPages.changePasswordScreen:
        return PageConfig()..pageBuilder = () => const ChangePasswordScreen();

      case AppPages.selectCityUserPage:
        return PageConfig()..pageBuilder = () => const SelectCityUserPage();
      case AppPages.selectExpectedLocationPage:
        return PageConfig()
          ..pageBuilder = () => const SelectExpectedLocationPage();

      case AppPages.selectJobUserPage:
        return PageConfig()..pageBuilder = () => const SelectJobUserPage();
      case AppPages.selectSkillUserPage:
        return PageConfig()..pageBuilder = () => const SelectSkillUserPage();

      case AppPages.selectDistricUserPage:
        return PageConfig()..pageBuilder = () => const SelectDistrictUserPage();

      case AppPages.updateBasicInfo:
        return PageConfig()..pageBuilder = () => const UpdateBasicInfoPage();

      case AppPages.updateInfoEmpler:
        return PageConfig()..pageBuilder = () => const UpdateInfoEmplerPage();

      case AppPages.ongoingProjectScreen:
        return PageConfig()..pageBuilder = () => const OngoingProjectScreen();

      case AppPages.savedProjectScreen:
        return PageConfig()..pageBuilder = () => const SavedProjectScreen();

      case AppPages.postedJobScreen:
        return PageConfig()..pageBuilder = () => const PostedJobScreen();

      case AppPages.setPriceProjectScreen:
        return PageConfig()..pageBuilder = () => const SetPriceProjectScreen();

      case AppPages.emplerGeneralManagement:
        return PageConfig()
          ..pageBuilder = () => const EmplerGeneralManagermentPage();

      case AppPages.postJobByProject:
        return PageConfig()..pageBuilder = () => const PostJobByProjectScreen();
      case AppPages.postJobPartime:
        return PageConfig()..pageBuilder = () => const PostJobPartimeScreen();

      case AppPages.emplerFlcerManagement:
        return PageConfig()
          ..pageBuilder = () => const EmplerFlcerManagermentScreen();

      case AppPages.searchFlcer:
        return PageConfig()..pageBuilder = () => const SearchFlcerScreen();
      case AppPages.searchFillerFlcer:
        return PageConfig()
          ..pageBuilder = () => const SearchFillerFlcerScreen();
      case AppPages.hireFlcerTutorial:
        return PageConfig()
          ..pageBuilder = () => const HireFlcerTutorialScreen();
      case AppPages.postedJob:
        return PageConfig()..pageBuilder = () => const PostedJobScreen();
      case AppPages.listFlcerSceen:
        return PageConfig()..pageBuilder = () => const ListFlcerScreen();
      case AppPages.initial:
      default:
        throw StateError(
            "Missing page: ${page.toString()} in AppPagesExtension.getPageConfig()");
    }
  }
}
