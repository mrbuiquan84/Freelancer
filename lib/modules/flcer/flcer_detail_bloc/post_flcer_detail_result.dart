import 'package:freelancer/common/models/job_cate.dart';

class PostFlcerDetailResult {
  PostFlcerDetailResult({
    required this.result,
    required this.message,
    required this.info,
  });
  final String message;
  final bool result;
  final Info info;

  factory PostFlcerDetailResult.fromJson(Map<String, dynamic> json) =>
      PostFlcerDetailResult(
          result: json["result"],
          message: json["message"],
          info: Info.fromJson(json['info']));
  // Map<String, dynamic> toJson() => {
  //       "result": result,
  //       "message": message,
  //       "info": info.toJson(),
  //     };
}

class Info {
  Info({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.cityId,
    required this.districtId,
    required this.sex,
    required this.birthday,
    required this.avatar,
    required this.categoryId,
    required this.skillDetail,
    required this.createdAt,
    required this.userDes,
    required this.skillYear,
    required this.workDesire,
    required this.userJob,
    required this.avtSrc,
    required this.listSkill,
    required this.cityName,
    required this.districtName,
    required this.proficiency,
    required this.slider,
    required this.vote,
    required this.isSaveFlc,
  });

  final String id;
  final String? email;
  final String? phone;
  final String name;
  final String cityId;
  final String districtId;
  final String sex;
  final DateTime birthday;
  final dynamic? avatar;
  final String categoryId;
  final dynamic skillDetail;
  final DateTime createdAt;
  final dynamic userDes;
  final dynamic skillYear;
  final dynamic workDesire;
  final dynamic userJob;
  final dynamic? avtSrc;
  final List<ListSkill> listSkill;
  final String cityName;
  final String districtName;
  final List<Proficiency> proficiency;
  final List<Proficiency> slider;
  final Vote vote;
  final String isSaveFlc;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"],
        email: json["email"] ?? "",
        phone: json["phone"] ?? "",
        name: json["name"],
        cityId: json["city_id"],
        districtId: json["district_id"],
        sex: json["sex"],
        birthday: DateTime.parse(json["birthday"]),
        avatar: json["avatar"] ?? "",
        categoryId: json["category_id"],
        skillDetail: json["skill_detail"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        userDes: json["user_des"] ?? "",
        skillYear: json["skill_year"],
        workDesire: json["work_desire"] ?? "",
        userJob: json["user_job"] ?? "",
        avtSrc: json["avt_src"] ?? "",
        listSkill: List<ListSkill>.from(
            json["list_skill"].map((x) => ListSkill.fromJson(x))),
        cityName: json["city_name"],
        districtName: json["district_name"],
        proficiency: List<Proficiency>.from(
            json["proficiency"].map((x) => Proficiency.fromJson(x))),
        slider: List<Proficiency>.from(
            json["slider"].map((x) => Proficiency.fromJson(x))),
        vote: Vote.fromJson(json["vote"]),
        isSaveFlc: json["is_save_flc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "name": name,
        "city_id": cityId,
        "district_id": districtId,
        "sex": sex,
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "avatar": avatar,
        "category_id": categoryId,
        "skill_detail": skillDetail,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "user_des": userDes,
        "skill_year": skillYear,
        "work_desire": workDesire,
        "user_job": userJob,
        "avt_src": avtSrc,
        "list_skill": List<ListSkill>.from(listSkill.map((x) => x.toJson())),
        "city_name": cityName,
        "district_name": districtName,
        "proficiency":
            List<Proficiency>.from(proficiency.map((x) => x.toJson())),
        "slider": List<Proficiency>.from(slider.map((x) => x.toJson())),
        "vote": vote.toJson(),
        "is_save_flc": isSaveFlc,
      };
}

class ListSkill {
  ListSkill({
    required this.id,
    required this.skillName,
  });

  final String id;
  final String skillName;

  factory ListSkill.fromJson(Map<String, dynamic> json) => ListSkill(
        id: json["id"],
        skillName: json["skill_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "skill_name": skillName,
      };
  @override
  String toString() {
    // TODO: implement toString
    return skillName;
  }
}

class Proficiency {
  Proficiency({
    required this.id,
    required this.name,
    required this.img,
    required this.idUser,
    required this.typeProficiency,
    required this.src,
  });

  final String id;
  final String name;
  final String img;
  final String idUser;
  final String typeProficiency;
  final String src;

  factory Proficiency.fromJson(Map<String, dynamic> json) => Proficiency(
        id: json["id"],
        name: json["name"] ?? " ",
        img: json["img"],
        idUser: json["id_user"],
        typeProficiency: json["type_proficiency"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "id_user": idUser,
        "type_proficiency": typeProficiency,
        "src": src,
      };
}

class Vote {
  Vote({
    required this.avg,
    required this.percent,
  });

  final String? avg;
  final int percent;

  factory Vote.fromJson(Map<String, dynamic> json) => Vote(
        avg: json["avg"] ?? "",
        percent: json["percent"],
      );

  Map<String, dynamic> toJson() => {
        "avg": avg,
        "percent": percent,
      };
}
