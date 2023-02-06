import 'package:freelancer/utils/data/salary.dart';

class ApiAddress {
  static const _baseUrl = 'https://freelancer.vieclam88.vn/api_app/';
  static const _baseUrl2 = 'https://freelancer.vieclam88.vn/API/';

  static var getSearchFlcer = _baseUrl + 'home/searchFreelancer';
  static var getJobByCate = _baseUrl + 'home/jobByCategory';
  static var getTopFlcer = _baseUrl + 'employer/topFreelancer';
  static var postLoginEmpler = _baseUrl + 'loginEmployer';
  static var getSkill = _baseUrl + 'freelancer/getSkill';
  static var getProvince = _baseUrl + 'freelancer/getProvince';
  static var postRegisterFlcer = _baseUrl + 'freelancer/registerFreelancer';
  static var postActiveFlcer = _baseUrl + 'freelancer/activeFreelancer';
  static var postActiveEmpler = _baseUrl + 'activeEpl';
  static var postRegisterEmpler = _baseUrl + 'addemployer';
  static var loginFlcer = _baseUrl + 'freelancer/loginFreelancer';
  static var loginEmpler = _baseUrl + 'loginEmployer';
  static var postGetForgotPasswordOTP =
      _baseUrl + 'freelancer/checkMailForgotPass';
  static var postCheckForgotPasswordOTP =
      _baseUrl + 'freelancer/checkOTPforgotPassFLC';
  static var postUpdateNewPassword = _baseUrl + 'freelancer/rePassFLC';
  static var getHomeLoadData = _baseUrl + 'home/loadDataIndex';
  static var getSearchJob = _baseUrl + 'home/searchJob';
  static var getFilterJob = _baseUrl2 + 'home/filter';
  static var getFillerFlcer = _baseUrl + 'home/fillerFLC';
  static var postSeenDetailEmpler = _baseUrl + 'SeenDetailEpl';
  static var postFlcerOrderJob = _baseUrl + 'freelancer/bidPrince';
  static var getFlcerInfo = _baseUrl + 'freelancer/loadInfo';
  static var getEmplerInfo = _baseUrl + 'ProfileEpl';
  static var updateEmplerProfile = _baseUrl + "editProfileEpl";
  static var getFlcerSavedProject = _baseUrl + 'freelancer/loadflcSaveJob';
  static var getFlcerOngoingProject = _baseUrl + 'freelancer/loadflcSaveJob';
  static var getFlcerProjectPrice = _baseUrl + 'employer/ProjectPriceSetting';
  static var postFlcerSavedProject = _baseUrl + 'freelancer/deleteSaveJob';
  static var postFlcerSaveJob = _baseUrl + 'freelancer/flcSavedJobs';
  static var updateIntroFlcer = _baseUrl + 'freelancer/updateInfoBasic';
  static var updateExpectedJobFlcer = _baseUrl + 'freelancer/updateToDo';
  static var postJob = _baseUrl + 'employer/pJobByProject';
  static var updateInfoFlcer = _baseUrl + 'freelancer/updateInfo';
  static var getEmplerHomeData = _baseUrl + 'home/searchFLC';
  static var saveFlcer = _baseUrl + 'employer/saveFLC';
  static var getSavedFlcer = _baseUrl + 'employer/eplSavedFlc';
  static var postDetailJob = _baseUrl + 'detailJob';
  static var confirmSetPrice = _baseUrl + 'employer/confirmPriceSetting';
  static var postedJob = _baseUrl + 'postjobByProject';

  static var getFlcerDetail = _baseUrl + 'employer/detailFreelancer';
  static var voteFlcer = _baseUrl + 'employer/employeVoteFlc';
  static var changePassword = _baseUrl + 'freelancer/changePassFLC';
  static var changePassword2 = _baseUrl + 'updatePassLoginEpl';
  static var emplerGeneral = _baseUrl + 'managerEmploye';
  static var refreshJob = _baseUrl + 'refeshJob';
}
