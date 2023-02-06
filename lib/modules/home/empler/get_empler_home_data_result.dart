import 'package:freelancer/modules/flcer/flcer_detail_bloc/post_flcer_detail_result.dart';

class GetEmplerHomeDataResult {
  GetEmplerHomeDataResult({
    required this.result,
    required this.message,
    required this.info,
  });

  final bool result;
  final String message;
  final List<Info> info;

  factory GetEmplerHomeDataResult.fromJson(Map<String, dynamic> json) =>
      GetEmplerHomeDataResult(
        result: json["result"],
        message: json["message"],
        info: List<Info>.from(json["data_render"].map((x) => Info.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //     "result": result,
  //     "message": message,
  //     "info": List<dynamic>.from(info.map((x) => x.toJson())),
  // };
}

class Info {
  Info({
    required this.id,
    required this.email,
    required this.userType,
    required this.phone,
    required this.name,
    required this.alias,
    required this.password,
    required this.cityId,
    required this.districtId,
    required this.sex,
    required this.birthday,
    required this.avatar,
    required this.salaryType,
    required this.salaryPermanentNumber,
    required this.salaryEstimateNumber1,
    required this.salarySalaryEstimateNumber2,
    required this.salaryPermanentDate,
    required this.salaryEstimatesDate,
    required this.categoryId,
    required this.skillDetail,
    required this.createdAt,
    required this.updatedAt,
    required this.userDes,
    required this.skillYear,
    required this.formOfWork,
    required this.workDesire,
    required this.userJob,
    required this.workPlace,
    required this.index,
    required this.brower,
    required this.userActive,
    required this.siteFrom,
    required this.isSearch,
    required this.listSkill,
    required this.citName,
    required this.districtName,
    required this.vote,
    required this.srcAvt,
    required this.savedFlc,
  });

  final String id;
  final String email;
  final String userType;
  final String phone;
  final String name;
  final String alias;
  final String password;
  final String cityId;
  final String districtId;
  final String sex;
  final String birthday;
  final String? avatar;
  final String salaryType;
  final String? salaryPermanentNumber;
  final String? salaryEstimateNumber1;
  final String? salarySalaryEstimateNumber2;
  final String? salaryPermanentDate;
  final String? salaryEstimatesDate;
  final String? categoryId;
  final String? skillDetail;
  final dynamic createdAt;
  final DateTime updatedAt;
  final String? userDes;
  final String? skillYear;
  final String? formOfWork;
  final String? workDesire;
  final String? userJob;
  final String? workPlace;
  final dynamic index;
  final String brower;
  final String userActive;
  final String siteFrom;
  final String isSearch;
  final List<ListSkill> listSkill;
  final String citName;
  final String districtName;
  final dynamic? vote;
  final String? srcAvt;
  final bool savedFlc;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"],
        email: json["email"],
        userType: json["user_type"],
        phone: json["phone"],
        name: json["name"],
        alias: json["alias"],
        password: json["password"],
        cityId: json["city_id"],
        districtId: json["district_id"],
        sex: json["sex"],
        birthday: json["birthday"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        salaryType: json["salary_type"],
        salaryPermanentNumber: json["salary_permanent_number"] == null
            ? null
            : json["salary_permanent_number"],
        salaryEstimateNumber1: json["salary_estimate_number_1"] == null
            ? null
            : json["salary_estimate_number_1"],
        salarySalaryEstimateNumber2:
            json["salary_salary_estimate_number_2"] == null
                ? null
                : json["salary_salary_estimate_number_2"],
        salaryPermanentDate: json["salary_permanent_date"] == null
            ? null
            : json["salary_permanent_date"],
        salaryEstimatesDate: json["salary_estimates_date"] == null
            ? null
            : json["salary_estimates_date"],
        categoryId: json["category_id"],
        skillDetail: json["skill_detail"] == null ? null : json["skill_detail"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        userDes: json["user_des"] == null ? null : json["user_des"],
        skillYear: json["skill_year"] == null ? null : json["skill_year"],
        formOfWork: json["form_of_work"] == null ? null : json["form_of_work"],
        workDesire: json["work_desire"] == null ? null : json["work_desire"],
        userJob: json["user_job"] == null ? null : json["user_job"],
        workPlace: json["work_place"] == null ? null : json["work_place"],
        index: json["index"],
        brower: json["brower"],
        userActive: json["user_active"],
        siteFrom: json["site_from"],
        isSearch: json["is_search"],
        listSkill: List<ListSkill>.from(
            json["list_skill"].map((x) => ListSkill.fromJson(x))),
        citName: json["cit_name"],
        districtName: json["district_name"],
        vote: json["vote"],
        srcAvt: json["src_avt"] == null ? null : json["src_avt"],
        savedFlc: json["saved_flc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "user_type": userType,
        "phone": phone,
        "name": name,
        "alias": alias,
        "password": password,
        "city_id": cityId,
        "district_id": districtId,
        "sex": sex,
        "birthday": birthday,
        "avatar": avatar == null ? null : avatar,
        "salary_type": salaryType,
        "salary_permanent_number":
            salaryPermanentNumber == null ? null : salaryPermanentNumber,
        "salary_estimate_number_1":
            salaryEstimateNumber1 == null ? null : salaryEstimateNumber1,
        "salary_salary_estimate_number_2": salarySalaryEstimateNumber2 == null
            ? null
            : salarySalaryEstimateNumber2,
        "salary_permanent_date":
            salaryPermanentDate == null ? null : salaryPermanentDate,
        "salary_estimates_date":
            salaryEstimatesDate == null ? null : salaryEstimatesDate,
        "category_id": categoryId,
        "skill_detail": skillDetail == null ? null : skillDetail,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "user_des": userDes == null ? null : userDes,
        "skill_year": skillYear == null ? null : skillYear,
        "form_of_work": formOfWork == null ? null : formOfWork,
        "work_desire": workDesire == null ? null : workDesire,
        "user_job": userJob == null ? null : userJob,
        "work_place": workPlace == null ? null : workPlace,
        "index": index,
        "brower": brower,
        "user_active": userActive,
        "site_from": siteFrom,
        "is_search": isSearch,
        "list_skill": List<dynamic>.from(listSkill.map((x) => x.toJson())),
        "cit_name": citName,
        "district_name": districtName,
        "vote": vote,
        "src_avt": srcAvt == null ? null : srcAvt,
        "saved_flc": savedFlc,
      };
}

class ListSkill {
  ListSkill({
    required this.skillName,
    required this.id,
  });

  final String skillName;
  final String id;

  factory ListSkill.fromJson(Map<String, dynamic> json) => ListSkill(
        skillName: json["skill_name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "skill_name": skillName,
        "id": id,
      };
  @override
  String toString() {
    // TODO: implement toString
    return skillName;
  }
}
