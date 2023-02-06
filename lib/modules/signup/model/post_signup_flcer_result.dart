import 'dart:convert';

PostRegisterFlcerResult postRegisterFlcerResultFromJson(String str) =>
    PostRegisterFlcerResult.fromJson(json.decode(str));

String postRegisterFlcerResultToJson(PostRegisterFlcerResult data) =>
    json.encode(data.toJson());

class PostRegisterFlcerResult {
  PostRegisterFlcerResult({
    required this.result,
    required this.message,
    required this.user,
    required this.token,
  });

  final bool result;
  final String message;
  final User user;
  final String token;

  factory PostRegisterFlcerResult.fromJson(Map<String, dynamic> json) =>
      PostRegisterFlcerResult(
        result: json["result"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  User({
    required this.email,
    required this.phone,
    required this.name,
    required this.sex,
    required this.password,
    required this.cityId,
    required this.districtId,
    required this.birthday,
    required this.categoryId,
    required this.brower,
    required this.createdAt,
    required this.userType,
    required this.userActive,
    required this.salaryType,
    this.salaryPermanentDate,
    this.salaryPermanentNumber,
    this.salaryEstimateNumber1,
    this.salarySalaryEstimateNumber2,
    this.salaryEstimatesDate,
  });

  final String email;
  final String phone;
  final String name;
  final String sex;
  final String password;
  final String cityId;
  final String districtId;
  final String birthday;
  final String salaryType;
  final String categoryId;
  final int brower;
  final DateTime createdAt;
  final String? salaryPermanentDate;
  final String? salaryPermanentNumber;
  final String? salaryEstimatesDate;
  final String? salaryEstimateNumber1;
  final String? salarySalaryEstimateNumber2;
  final int userType;
  final int userActive;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        sex: json["sex"],
        password: json["password"],
        cityId: json["city_id"],
        districtId: json["district_id"],
        birthday: json["birthday"],
        salaryType: json["salary_type"],
        categoryId: json["category_id"],
        brower: json["brower"],
        createdAt: DateTime.parse(json["created_at"]),
        salaryEstimatesDate: json["salary_estimates_date"],
        salaryEstimateNumber1: json["salary_estimate_number_1"],
        salarySalaryEstimateNumber2: json["salary_salary_estimate_number_2"],
        salaryPermanentDate: json['salary_permanent_date'],
        salaryPermanentNumber: json['salary_permanent_number'],
        userType: json["user_type"],
        userActive: json["user_active"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
        "name": name,
        "sex": sex,
        "password": password,
        "city_id": cityId,
        "district_id": districtId,
        "birthday": birthday,
        "salary_type": salaryType,
        "category_id": categoryId,
        "brower": brower,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "salary_estimate_number_1": salaryEstimateNumber1,
        "salary_salary_estimate_number_2": salarySalaryEstimateNumber2,
        "salary_estimates_date": salaryEstimatesDate,
        "user_type": userType,
        "user_active": userActive,
      };
}
