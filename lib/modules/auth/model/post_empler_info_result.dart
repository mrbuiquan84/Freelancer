import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class PostEmplerInfoResult {
  PostEmplerInfoResult({
    required this.result,
    required this.message,
    required this.info,
  });

  final bool result;
  final String message;
  final Infor info;

  factory PostEmplerInfoResult.fromJson(Map<String, dynamic> json) =>
      PostEmplerInfoResult(
          result: json["result"],
          message: json["message"],
          info: Infor.fromJson(json["infor"]));
}

class Infor {
  Infor({
    required this.avatar,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.city,
    required this.district,
    required this.email,
    required this.point,
    required this.createdAt,
    required this.phone,
  });
  final String avatar;
  final String email;
  final String phone;
  final String name;
  final DateTime birthday;
  final String gender;
  final String city;
  final String district;
  final String point;
  final DateTime createdAt;

  factory Infor.fromJson(Map<String, dynamic> json) => Infor(
        avatar: json["avatar"] ?? "",
        name: json["name"],
        birthday: DateTime.parse(json["birthday"]),
        email: json["email"],
        gender: json["sex"] ?? "",
        city: json["city"] ?? "",
        phone: json["phone"],
        district: json["district_name"] ?? "",
        point: json["point"],
        createdAt: DateTime.parse(json["created_at"]),
      );
  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "name": name,
        "birthday": birthday,
        "email": email,
        "phone": phone,
        "sex": gender,
        "city": city,
        "district_name": district,
        "point": point,
        "created_at": createdAt,
      };
}
