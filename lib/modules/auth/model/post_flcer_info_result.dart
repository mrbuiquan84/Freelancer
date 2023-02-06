import 'package:flutter/widgets.dart';
import 'package:freelancer/common/models/job_cate.dart';
import 'package:freelancer/common/widgets/app_network_image.dart';
import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/modules/profile/widget/user_list_tile.dart';
import 'package:freelancer/utils/data/city.dart';
import 'package:freelancer/utils/data/salary.dart';
import 'package:intl/intl.dart';

class PostFlcerInfoResult {
  PostFlcerInfoResult({
    required this.result,
    required this.message,
    required this.info,
    required this.dataRender,
  });

  final bool result;
  final String message;
  final Info info;
  final DataRender dataRender;

  factory PostFlcerInfoResult.fromJson(Map<String, dynamic> json) =>
      PostFlcerInfoResult(
        result: json["result"],
        message: json["message"],
        info: Info.fromJson(json["info"]),
        dataRender: DataRender.fromJson(json["data_render"]),
      );

  // Map<String, dynamic> toJson() => {
  //     "result": result,
  //     "message": message,
  //     "info": info.toJson(),
  //     "data_render": dataRender.toJson(),
  // };
}

class DataRender {
  DataRender({
    required this.basic,
    required this.intro,
    required this.work,
    required this.skill,
    required this.proficiency,
  });

  final Basic basic;
  final Intro intro;
  final Work work;
  final Skill skill;
  final Proficency2 proficiency;

  factory DataRender.fromJson(Map<String, dynamic> json) => DataRender(
        basic: Basic.fromJson(json["basic"]),
        intro: Intro.fromJson(json["intro"]),
        work: Work.fromJson(json["work"]),
        skill: Skill.fromJson(json["skill"]),
        proficiency: Proficency2.fromJson(json["proficency"]),
      );

  // Map<String, dynamic> toJson() => {
  //     "basic": basic.toJson(),
  //     "intro": intro.toJson(),
  //     "work": work.toJson(),
  //     "skill": skill.toJson(),
  //     "proficency": proficency.toJson(),
  // };
}

class Basic {
  Basic({
    this.avatar,
    this.srcAvatar,
    required this.name,
    required this.birthday,
    required this.sex,
    required this.city,
    required this.district,
    required this.phone,
    required this.email,
  });

  final String? avatar;
  final String? srcAvatar;
  final String name;
  final DateTime birthday;
  final String sex;
  final String city;
  final String district;
  final String phone;
  final String email;

  factory Basic.fromJson(Map<String, dynamic> json) => Basic(
        avatar: json["avatar"],
        srcAvatar: json["src_avatar"],
        name: json["name"],
        birthday: DateTime.parse(json["birthday"]),
        sex: json["sex"],
        city: json["city"],
        district: json["district"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "src_avatar": srcAvatar,
        "name": name,
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "sex": sex,
        "city": city,
        "district": district,
        "phone": phone,
        "email": email,
      };
}

class Intro {
  Intro({
    required this.skillYear,
    required this.info,
  });

  final String skillYear;
  final String? info;

  factory Intro.fromJson(Map<String, dynamic> json) => Intro(
        skillYear: json["skill_year"],
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "skill_year": skillYear,
        "info": info,
      };
}

class Proficency2 {
  Proficency2({
    required this.img,
    required this.file,
  });

  final List<String> img;
  final List<dynamic> file;

  factory Proficency2.fromJson(Map<String, dynamic> json) => Proficency2(
        img: List<String>.from(json["img"].map((x) => (x))),
        file: List<dynamic>.from(json["file"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "img": List<String>.from(img.map((x) => x)),
        "file": List<dynamic>.from(file.map((x) => x)),
      };
}

class Proficiency {
  Proficiency({
    required this.id,
    this.name,
    required this.img,
    required this.idUser,
    required this.typeProficiency,
    this.srcImg,
    this.source,
  });

  final String id;
  final String? name;
  final String img;
  final String idUser;
  final String typeProficiency;
  final String? srcImg;
  final String? source;

  factory Proficiency.fromJson(Map<String, dynamic> json) => Proficiency(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        idUser: json["id_user"],
        typeProficiency: json["type_proficiency"],
        srcImg: json["src_img"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "id_user": idUser,
        "type_proficiency": typeProficiency,
        "src_img": srcImg,
        "source": source,
      };
}

class Skill {
  Skill({
    required this.category,
    required this.skillDetail,
  });

  final List<JobCate> category;
  final List<JobCate> skillDetail;

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        category: List<JobCate>.from(
            json["category"].map((x) => JobCate.fromJobCate(x))),
        skillDetail: List<JobCate>.from(
            json["skill_detail"].map((x) => JobCate.fromListSkill(x))),
      );

  // Map<String, dynamic> toJson() => {
  //     "category": List<dynamic>.from(category.map((x) => x.toJson())),
  //     "skill_detail": List<dynamic>.from(skillDetail.map((x) => x.toJson())),
  // };
}

class Work {
  Work({
    required this.userJob,
    required this.formOfWork,
    required this.workDesire,
    required this.workPlace,
    required this.salary,
  });

  final String userJob;
  final String formOfWork;
  final JobCate workDesire;
  final City workPlace;
  final Salary salary;

  factory Work.fromJson(Map<String, dynamic> json) => Work(
        userJob: json["user_job"],
        formOfWork: json["form_of_work"],
        workDesire: JobCate.fromJobCate(json["work_desire"]),
        workPlace: City.fromJson(json["work_place"]),
        salary: Salary.fromJson(json["salary"]),
      );

  // Map<String, dynamic> toJson() => {
  //     "user_job": userJob,
  //     "form_of_work": formOfWork,
  //     "work_desire": workDesire.toJson(),
  //     "work_place": workPlace.toJson(),
  //     "salary": salary.toJson(),
  // };
}

class Info {
  Info({
    required this.id,
    required this.name,
    required this.cityId,
    required this.districtId,
    required this.birthday,
    required this.sex,
    required this.phone,
    required this.email,
    required this.skillYear,
    required this.userJob,
    required this.workDesire,
    required this.formOfWork,
    required this.workPlace,
    required this.salaryType,
    required this.salaryPermanentNumber,
    required this.salaryPermanentDate,
    required this.salaryEstimateNumber1,
    required this.avatar,
    required this.userDes,
    required this.salarySalaryEstimateNumber2,
    required this.salaryEstimatesDate,
    required this.skillDetail,
    required this.categoryId,
    required this.createdAt,
    required this.city,
    required this.district,
    required this.listSkill,
    required this.proficiency,
    required this.srcAvatar,
  });

  final String id;
  final String name;
  final String cityId;
  final String districtId;
  final DateTime birthday;
  final String sex;
  final String phone;
  final String email;
  final String skillYear;
  final String userJob;
  final JobCate workDesire;
  final String formOfWork;
  final City workPlace;
  final String salaryType;
  final String salaryPermanentNumber;
  final String salaryPermanentDate;
  final dynamic salaryEstimateNumber1;
  final String? avatar;
  final String? userDes;
  final dynamic salarySalaryEstimateNumber2;
  final dynamic salaryEstimatesDate;
  final dynamic skillDetail;
  final String categoryId;
  final DateTime createdAt;
  final String city;
  final String district;
  final List<JobCate> listSkill;
  final List<Proficiency> proficiency;
  final String srcAvatar;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"],
        name: json["name"],
        cityId: json["city_id"],
        districtId: json["district_id"],
        birthday: DateTime.parse(json["birthday"]),
        sex: json["sex"],
        phone: json["phone"],
        email: json["email"],
        skillYear: json["skill_year"],
        userJob: json["user_job"],
        workDesire: JobCate.fromJobCate(json["work_desire"]),
        formOfWork: json["form_of_work"],
        workPlace: City.fromJson(json["work_place"]),
        salaryType: json["salary_type"],
        salaryPermanentNumber: json["salary_permanent_number"],
        salaryPermanentDate: json["salary_permanent_date"],
        salaryEstimateNumber1: json["salary_estimate_number_1"],
        avatar: json["avatar"],
        userDes: json["user_des"],
        salarySalaryEstimateNumber2: json["salary_salary_estimate_number_2"],
        salaryEstimatesDate: json["salary_estimates_date"],
        skillDetail: json["skill_detail"],
        categoryId: json["category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        city: json["city"],
        district: json["district"],
        listSkill: List<JobCate>.from(
            json["list_skill"].map((x) => JobCate.fromListSkill(x))),
        proficiency: List<Proficiency>.from(
            json["proficiency"].map((x) => Proficiency.fromJson(x))),
        srcAvatar: json["src_avatar"],
      );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "name": name,
  //     "city_id": cityId,
  //     "district_id": districtId,
  //     "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
  //     "sex": sex,
  //     "phone": phone,
  //     "email": email,
  //     "skill_year": skillYear,
  //     "user_job": userJob,
  //     "work_desire": workDesire.toJson(),
  //     "form_of_work": formOfWork,
  //     "work_place": workPlace.toJson(),
  //     "salary_type": salaryType,
  //     "salary_permanent_number": salaryPermanentNumber,
  //     "salary_permanent_date": salaryPermanentDate,
  //     "salary_estimate_number_1": salaryEstimateNumber1,
  //     "avatar": avatar,
  //     "user_des": userDes,
  //     "salary_salary_estimate_number_2": salarySalaryEstimateNumber2,
  //     "salary_estimates_date": salaryEstimatesDate,
  //     "skill_detail": skillDetail,
  //     "category_id": categoryId,
  //     "created_at": createdAt,
  //     "city": city,
  //     "district": district,
  //     "list_skill": List<dynamic>.from(listSkill.map((x) => x.toJson())),
  //     "proficiency": List<dynamic>.from(proficiency.map((x) => x.toJson())),
  //     "src_avatar": srcAvatar,
  // };
}
