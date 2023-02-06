import 'dart:convert';

PostRegisterEmplerResult postRegisterEmperResult(String str) =>
    PostRegisterEmplerResult.fromJson(json.decode(str));

String postRegisterEmplerResultToJson(PostRegisterEmplerResult data) =>
    json.encode(data.toJson());

class PostRegisterEmplerResult {
  PostRegisterEmplerResult({
    required this.result,
    required this.message,
    required this.empler,
    required this.token,
  });

  final bool result;
  final String message;
  final Empler empler;
  final String token;

  factory PostRegisterEmplerResult.fromJson(Map<String, dynamic> json) =>
      PostRegisterEmplerResult(
        result: json["result"],
        message: json["message"],
        empler: Empler.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "user": empler.toJson(),
        "token": token,
      };
}

class Empler {
  Empler({
    required this.email,
    required this.name,
    required this.sex,
    required this.phone,
    required this.password,
    required this.alias,
    required this.cityId,
    required this.districtId,
    required this.birthday,
    required this.brower,
    required this.createdAt,
    required this.userType,
    required this.userActive,
    required this.updatedAt,
  });

  final String email;
  final String phone;
  final String alias;
  final String name;
  final String sex;
  final String password;
  final String cityId;
  final String districtId;
  final String birthday;
  final int brower;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userType;
  final int userActive;

  factory Empler.fromJson(Map<String, dynamic> json) => Empler(
        email: json["email"],
        name: json["name"],
        sex: json["sex"],
        phone: json["phone"],
        alias: json["alias"],
        password: json["password"],
        cityId: json["city_id"],
        districtId: json["district_id"],
        birthday: json["birthday"],
        brower: json["brower"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        userType: json["user_type"],
        userActive: json["user_active"],
      );
  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "sex": sex,
        "phone": phone,
        "alias": alias,
        "password": password,
        "city_id": cityId,
        "district_id": districtId,
        "birthday": birthday,
        "brower": brower,
        "update_at": updatedAt,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "user_type": userType,
        "user_active": userActive,
      };
}
