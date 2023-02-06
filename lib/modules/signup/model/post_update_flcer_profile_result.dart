import 'dart:convert';

PostUpdateFlcerProfileResult postUpdateFlcerProfileResultFromJson(String str) =>
    PostUpdateFlcerProfileResult.fromJson(json.decode(str));

String postUpdateFlcerResultToJson(PostUpdateFlcerProfileResult data) =>
    json.encode(data.toJson());

class PostUpdateFlcerProfileResult {
  PostUpdateFlcerProfileResult({
    required this.result,
    required this.message,
    required this.data,
  });

  final bool result;
  final String message;
  final Data data;

  factory PostUpdateFlcerProfileResult.fromJson(Map<String, dynamic> json) =>
      PostUpdateFlcerProfileResult(
        result: json["result"],
        message: json["message"],
        data: json["data"],
      );
  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.name,
    required this.birthday,
    required this.gender,
    required this.cityId,
    required this.districtId,
    required this.updatedAt,
    this.siteFrom,
  });

  final String name;
  final String birthday;
  final int gender;
  final int cityId;
  final int districtId;
  DateTime updatedAt;
  int? siteFrom;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      name: json["name"],
      birthday: json["birthday"],
      gender: json["sex"],
      cityId: json["city_id"],
      districtId: json["district_id"],
      updatedAt: DateTime.parse(json["updated_at"]),
      siteFrom: json["site_from"]);
  Map<String, dynamic> toJson() => {
        "name": name,
        "birthday": birthday,
        "sex": gender,
        "city_id": cityId,
        "district_id": districtId,
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
        "site_from": siteFrom,
      };
}
