class GetFlcerProject {
  GetFlcerProject({
    required this.result,
    required this.message,
    required this.list,
  });
  final bool result;
  final String message;
  final ListClass list;

  factory GetFlcerProject.fromJson(Map<String, dynamic> json) =>
      GetFlcerProject(
        result: json["result"],
        message: json["message"],
        list: ListClass.fromJson(json["list"]),
      );
}

class ListClass {
  ListClass({
    required this.savedFlc,
    required this.flcWorking,
    required this.flcPriceSetted,
    required this.page,
    required this.limit,
  });

  final List<SavedFlc> savedFlc;
  final List<FlcWorking> flcWorking;
  final List<FlcPrice> flcPriceSetted;
  final String page;
  final String limit;

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        savedFlc: List<SavedFlc>.from(
            json["saved_flc"].map((x) => SavedFlc.fromJson(x))),
        flcWorking: List<FlcWorking>.from(
            json["flc_working"].map((x) => FlcWorking.fromJson(x))),
        flcPriceSetted: List<FlcPrice>.from(
            json["flc_price_setted"].map((x) => FlcPrice.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "saved_flc": List<dynamic>.from(savedFlc.map((x) => x.toJson())),
        "flc_working": List<dynamic>.from(flcWorking.map((x) => x.toJson())),
        "flc_price_setted": List<dynamic>.from(flcPriceSetted.map((x) => x)),
        "page": page,
        "limit": limit,
      };
}

class FlcWorking {
  FlcWorking({
    required this.id,
    required this.flcId,
    required this.jobId,
    required this.salary,
    required this.employeId,
    required this.statusWork,
    required this.jobName,
    required this.dateBidEnd,
    required this.freelancerName,
    required this.star,
  });

  final String id;
  final String flcId;
  final String jobId;
  final String salary;
  final String employeId;
  final String statusWork;
  final String jobName;
  final DateTime dateBidEnd;
  final String freelancerName;
  final dynamic star;

  factory FlcWorking.fromJson(Map<String, dynamic> json) => FlcWorking(
        id: json["id"],
        flcId: json["flc_id"],
        jobId: json["job_id"],
        salary: json["salary"],
        employeId: json["employe_id"],
        statusWork: json["status_work"],
        jobName: json["job_name"],
        dateBidEnd: DateTime.parse(json["date_bid_end"]),
        freelancerName: json["freelancer_name"],
        star: json["star"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "flc_id": flcId,
        "job_id": jobId,
        "salary": salary,
        "employe_id": employeId,
        "status_work": statusWork,
        "job_name": jobName,
        "date_bid_end":
            "${dateBidEnd.year.toString().padLeft(4, '0')}-${dateBidEnd.month.toString().padLeft(2, '0')}-${dateBidEnd.day.toString().padLeft(2, '0')}",
        "freelancer_name": freelancerName,
        "star": star,
      };
}

class SavedFlc {
  SavedFlc({
    required this.id,
    required this.employerId,
    required this.flcId,
    required this.createdAt,
    required this.info,
  });

  final String id;
  final String employerId;
  final String flcId;
  final String createdAt;
  final Info info;

  factory SavedFlc.fromJson(Map<String, dynamic> json) => SavedFlc(
        id: json["id"],
        employerId: json["employer_id"],
        flcId: json["flc_id"],
        createdAt: json["created_at"],
        info: Info.fromJson(json["info"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employer_id": employerId,
        "flc_id": flcId,
        "created_at": createdAt,
        "info": info.toJson(),
      };
}

class Info {
  Info({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.skillDetail,
    required this.cityId,
    required this.cityName,
    required this.listSkill,
    required this.listCate,
    required this.avgStar,
    required this.userJob,
    required this.avatar,
  });

  final String id;
  final String name;
  final String categoryId;
  final String? skillDetail;
  final String cityId;
  final String cityName;
  final List<ListSkill> listSkill;
  final List<ListCate> listCate;
  final dynamic avgStar;
  final String? avatar;
  final String? userJob;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        skillDetail: json["skill_detail"] ?? "",
        cityId: json["city_id"],
        cityName: json["city_name"],
        listSkill: List<ListSkill>.from(
            json["list_skill"].map((x) => ListSkill.fromJson(x))),
        listCate: List<ListCate>.from(
            json["list_cate"].map((x) => ListCate.fromJson(x))),
        avgStar: json["avg_star"],
        avatar: json['avatar'],
        userJob: json['user_job'] ?? "Chưa cập nhật",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "skill_detail": skillDetail,
        "city_id": cityId,
        "city_name": cityName,
        "list_skill": List<dynamic>.from(listSkill.map((x) => x.toJson())),
        "list_cate": List<dynamic>.from(listCate.map((x) => x.toJson())),
        "avg_star": avgStar,
        "user_job": userJob,
        "avatar": avatar,
      };
}

class ListCate {
  ListCate({
    required this.id,
    required this.categoryName,
  });

  final String id;
  final String categoryName;

  factory ListCate.fromJson(Map<String, dynamic> json) => ListCate(
        id: json["id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
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

class FlcPrice {
  FlcPrice({
    required this.id,
    required this.flcId,
    required this.jobId,
    required this.salary,
    required this.employeId,
    required this.statusWork,
    required this.jobName,
    required this.freelancerName,
    required this.freelancerPhone,
    required this.salaryExpected,
  });

  final String id;
  final String flcId;
  final String jobId;
  final String salary;
  final String employeId;
  final String statusWork;
  final String jobName;
  final String freelancerName;
  final String freelancerPhone;
  final SalaryExpected salaryExpected;

  factory FlcPrice.fromJson(Map<String, dynamic> json) => FlcPrice(
        id: json["id"],
        flcId: json["flc_id"],
        jobId: json["job_id"],
        salary: json["salary"],
        employeId: json["employe_id"],
        statusWork: json["status_work"],
        jobName: json["job_name"],
        freelancerName: json["freelancer_name"],
        freelancerPhone:
            json["freelancer_phone"] == null ? null : json["freelancer_phone"],
        salaryExpected: //json["salary_expected"] == null
            // ? null
            // :
            SalaryExpected.fromJson(json["salary_expected"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "flc_id": flcId,
  //       "job_id": jobId,
  //       "salary": salary,
  //       "employe_id": employeId,
  //       "status_work": statusWork,
  //       "job_name": jobName,
  //       "freelancer_name": freelancerName,
  //       "freelancer_phone": freelancerPhone == null ? null : freelancerPhone,
  //       "salary_expected":
  //           salaryExpected == null ? null : salaryExpected.toJson(),
  //     };
}

class SalaryExpected {
  SalaryExpected({
    required this.salaryType,
    required this.salaryPermanentNumber,
    required this.salaryPermanentDate,
  });

  final String salaryType;
  final String salaryPermanentNumber;
  final String salaryPermanentDate;

  factory SalaryExpected.fromJson(Map<String, dynamic> json) => SalaryExpected(
        salaryType: json["salary_type"],
        salaryPermanentNumber: json["salary_permanent_number"],
        salaryPermanentDate: json["salary_permanent_date"],
      );

  Map<String, dynamic> toJson() => {
        "salary_type": salaryType,
        "salary_permanent_number": salaryPermanentNumber,
        "salary_permanent_date": salaryPermanentDate,
      };
}
