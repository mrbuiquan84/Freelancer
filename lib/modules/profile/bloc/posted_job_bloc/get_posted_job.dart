class GetPostedJob {
  GetPostedJob({
    required this.result,
    required this.message,
    required this.infor,
    required this.record,
  });

  final bool result;
  final String message;
  final List<PostedJob> infor;
  final int record;

  factory GetPostedJob.fromJson(Map<String, dynamic> json) => GetPostedJob(
        result: json["result"],
        message: json["message"],
        infor: List<PostedJob>.from(
            json["infor"].map((x) => PostedJob.fromJson(x))),
        record: json["record"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "infor": List<dynamic>.from(infor.map((x) => x.toJson())),
        "record": record,
      };
}

class PostedJob {
  PostedJob({
    required this.id,
    required this.workType,
    required this.workCity,
    required this.createdAt,
    required this.titleJob,
    required this.jobType,
    required this.citName,
    required this.skillId,
    required this.salaryType,
    required this.salaryEstimateNumber1,
    required this.salarySalaryEstimateNumber2,
    required this.salaryPermanentNumber,
    required this.workDes,
    required this.date,
    required this.status,
    required this.flcDided,
  });

  final String id;
  final String workType;
  final String workCity;
  final DateTime createdAt;
  final String titleJob;
  final String jobType;
  final String citName;
  final String skillId;
  final String salaryType;
  final String? salaryEstimateNumber1;
  final String? salarySalaryEstimateNumber2;
  final String salaryPermanentNumber;
  final String workDes;
  final String date;
  final String status;
  final int flcDided;

  factory PostedJob.fromJson(Map<String, dynamic> json) => PostedJob(
        id: json["id"],
        workType: json["work_type"],
        workCity: json["work_city"],
        createdAt: DateTime.parse(json["created_at"]),
        titleJob: json["title_job"],
        jobType: json["job_type"],
        citName: json["cit_name"],
        skillId: json["skill_id"],
        salaryType: json["salary_type"],
        salaryEstimateNumber1: json["salary_estimate_number_1"] ?? "",
        salarySalaryEstimateNumber2:
            json["salary_salary_estimate_number_2"] ?? " ",
        salaryPermanentNumber: json["salary_permanent_number"],
        workDes: json["work_des"],
        date: json["date"],
        status: json["status"],
        flcDided: json["FLC_dided"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "work_type": workType,
        "work_city": workCity,
        "created_at": createdAt.toIso8601String(),
        "title_job": titleJob,
        "job_type": jobType,
        "cit_name": citName,
        "skill_id": skillId,
        "salary_type": salaryType,
        "salary_estimate_number_1": salaryEstimateNumber1,
        "salary_salary_estimate_number_2": salarySalaryEstimateNumber2,
        "salary_permanent_number": salaryPermanentNumber,
        "work_des": workDes,
        "date": date,
        "status": status,
        "FLC_dided": flcDided,
      };
}
