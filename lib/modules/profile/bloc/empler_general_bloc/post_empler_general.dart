class PostEmplerGeneral {
  PostEmplerGeneral({
    required this.result,
    required this.message,
    required this.data1,
    required this.data2,
    required this.data3,
    required this.error,
  });

  final bool result;
  final String message;
  final Data1 data1;
  final List<Data2> data2;
  final List<Data3> data3;
  final bool error;

  factory PostEmplerGeneral.fromJson(Map<String, dynamic> json) =>
      PostEmplerGeneral(
        result: json["result"],
        message: json["message"],
        data1: Data1.fromJson(json["data_1"]),
        data2: List<Data2>.from(json["data_2"].map((x) => Data2.fromJson(x))),
        data3: List<Data3>.from(json["data_3"].map((x) => Data3.fromJson(x))),
        error: json["error"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data_1": data1.toJson(),
        "data_2": List<dynamic>.from(data2.map((x) => x.toJson())),
        "data_3": List<dynamic>.from(data3.map((x) => x.toJson())),
        "error": error,
      };
}

class Data1 {
  Data1({
    required this.freelancerBid,
    required this.freelancerSaved,
    required this.freelancerDoing,
    required this.freelancerFinish,
  });

  final String freelancerBid;
  final int freelancerSaved;
  final int freelancerDoing;
  final int freelancerFinish;

  factory Data1.fromJson(Map<String, dynamic> json) => Data1(
        freelancerBid: json["Freelancer_bid"],
        freelancerSaved: json["Freelancer_saved"],
        freelancerDoing: json["Freelancer_doing"],
        freelancerFinish: json["Freelancer_finish"],
      );

  Map<String, dynamic> toJson() => {
        "Freelancer_bid": freelancerBid,
        "Freelancer_saved": freelancerSaved,
        "Freelancer_doing": freelancerDoing,
        "Freelancer_finish": freelancerFinish,
      };
}

class Data2 {
  Data2({
    required this.id,
    required this.titleJob,
    required this.salaryType,
    required this.createdAt,
    required this.salaryPermanentNumber,
    required this.dateBidEnd,
    required this.freelancerBided,
    required this.date,
  });

  final String id;
  final String titleJob;
  final String salaryType;
  final DateTime createdAt;
  final String salaryPermanentNumber;
  final DateTime dateBidEnd;
  final int freelancerBided;
  final String date;

  factory Data2.fromJson(Map<String, dynamic> json) => Data2(
        id: json["id"],
        titleJob: json["title_job"],
        salaryType: json["salary_type"],
        createdAt: DateTime.parse(json["created_at"]),
        salaryPermanentNumber: json["salary_permanent_number"],
        dateBidEnd: DateTime.parse(json["date_bid_end"]),
        freelancerBided: json["Freelancer_bided"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_job": titleJob,
        "salary_type": salaryType,
        "created_at": createdAt.toIso8601String(),
        "salary_permanent_number": salaryPermanentNumber,
        "date_bid_end":
            "${dateBidEnd.year.toString().padLeft(4, '0')}-${dateBidEnd.month.toString().padLeft(2, '0')}-${dateBidEnd.day.toString().padLeft(2, '0')}",
        "Freelancer_bided": freelancerBided,
        "date": date,
      };
}

class Data3 {
  Data3({
    required this.flcId,
    required this.phone,
    required this.name,
    required this.titleJob,
    required this.salaryType,
    required this.salaryEstimateNumber1,
    required this.salarySalaryEstimateNumber2,
    required this.salaryPermanentNumber,
    required this.salary,
    required this.acceptPriceSetting,
    required this.dateBidEnd,
    required this.createdAt,
    required this.count,
    required this.date,
  });

  final String flcId;
  final String phone;
  final String name;
  final String titleJob;
  final String salaryType;
  final String salaryEstimateNumber1;
  final String salarySalaryEstimateNumber2;
  final String salaryPermanentNumber;
  final String salary;
  final String acceptPriceSetting;
  final DateTime dateBidEnd;
  final DateTime createdAt;
  final int count;
  final String date;

  factory Data3.fromJson(Map<String, dynamic> json) => Data3(
        flcId: json["flc_id"],
        phone: json["phone"],
        name: json["name"],
        titleJob: json["title_job"],
        salaryType: json["salary_type"],
        salaryEstimateNumber1: json["salary_estimate_number_1"],
        salarySalaryEstimateNumber2: json["salary_salary_estimate_number_2"],
        salaryPermanentNumber: json["salary_permanent_number"],
        salary: json["salary"],
        acceptPriceSetting: json["accept_price_setting"],
        dateBidEnd: DateTime.parse(json["date_bid_end"]),
        createdAt: DateTime.parse(json["created_at"]),
        count: json["count"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "flc_id": flcId,
        "phone": phone,
        "name": name,
        "title_job": titleJob,
        "salary_type": salaryType,
        "salary_estimate_number_1": salaryEstimateNumber1,
        "salary_salary_estimate_number_2": salarySalaryEstimateNumber2,
        "salary_permanent_number": salaryPermanentNumber,
        "salary": salary,
        "accept_price_setting": acceptPriceSetting,
        "date_bid_end":
            "${dateBidEnd.year.toString().padLeft(4, '0')}-${dateBidEnd.month.toString().padLeft(2, '0')}-${dateBidEnd.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "count": count,
        "date": date,
      };
}
