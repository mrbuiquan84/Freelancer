import 'dart:convert';

import 'package:freelancer/modules/auth/model/empler_info.dart';

PostUpdateEmplerProfileResult postUpdateEmplerProfileResultFromJson(
        String str) =>
    PostUpdateEmplerProfileResult.fromJson(json.decode(str));

String postUpdateEmplerProfileResultToJson(
        PostUpdateEmplerProfileResult infor) =>
    json.encode(infor.toJson());

class PostUpdateEmplerProfileResult {
  PostUpdateEmplerProfileResult({
    required this.result,
    required this.message,
    required this.infor,
  });
  final bool result;
  final String message;
  final String infor;

  factory PostUpdateEmplerProfileResult.fromJson(Map<String, dynamic> json) =>
      PostUpdateEmplerProfileResult(
          result: json["result"],
          message: json["message"],
          infor: json["infor"]);
  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "infor": infor,
      };
}

// class Infor {
//   Infor({
//     this.avatar,
//     required this.name,
//     required this.birthday,
//     required this.gender,
//     required this.city,
//     required this.distric,
//   });
//   String? avatar;
//   final String name;
//   final String birthday;
//   final int gender;
//   final int city;
//   final int distric;

//   factory Infor.fromJson(Map<String, dynamic> json) => Infor(
//         name: json["name"],
//         birthday: json["birthday"],
//         gender: json["sex"],
//         city: json["city"],
//         distric: json["district_name"],
//       );
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "birthday": birthday,
//         "sex": gender,
//         "city": city,
//         "district_name": distric,
//       };
// }
