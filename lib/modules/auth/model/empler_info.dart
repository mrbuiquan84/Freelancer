import 'package:dio/dio.dart';
import 'package:freelancer/modules/auth/model/post_flcer_info_result.dart';
import 'package:intl/intl.dart';

class EmplerInfo {
  EmplerInfo({
    required this.avatar,
    required this.name,
    required this.birthday,
    required this.sex,
    required this.city,
    required this.district,
    required this.phone,
    required this.email,
    required this.createdAt,
    required this.point,
  });
  final String point;
  final String avatar;
  final String name;
  final DateTime birthday;
  final String sex;
  final String city;
  final String district;
  final String phone;
  final String email;
  final DateTime createdAt;

  factory EmplerInfo.fromJson(Map<String, dynamic> json) => EmplerInfo(
        avatar: json["avatar"],
        name: json["name"],
        birthday: DateTime.parse(json["birthday"]),
        sex: json["sex"],
        city: json["city"],
        district: json["district"],
        phone: json["phone"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        point: json["point"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "name": name,
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "sex": sex,
        "city": city,
        "district": district,
        "phone": phone,
        "email": email,
        "created_at": createdAt,
        "point": point,
      };
}

class Proficency {
  Proficency({
    required this.img,
    required this.file,
  });

  final List<Proficiency> img;
  final List<dynamic> file;

  factory Proficency.fromJson(Map<String, dynamic> json) => Proficency(
        img: List<Proficiency>.from(
            json["img"].map((x) => Proficiency.fromJson(x))),
        file: List<dynamic>.from(json["file"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "img": List<dynamic>.from(img.map((x) => x.toJson())),
        "file": List<dynamic>.from(file.map((x) => x)),
      };
}
