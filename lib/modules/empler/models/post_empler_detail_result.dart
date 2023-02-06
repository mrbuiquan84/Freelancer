import 'package:freelancer/utils/helpers/datetime_extension.dart';

class PostEmplerDetailResult {
  PostEmplerDetailResult({
    required this.result,
    required this.message,
    required this.info,
    required this.infoJobs,
  });

  final bool result;
  final String message;
  final Info info;
  final List<InfoJob> infoJobs;

  factory PostEmplerDetailResult.fromJson(Map<String, dynamic> json) =>
      PostEmplerDetailResult(
        result: json["result"],
        message: json["message"],
        info: Info.fromJson(json["infor"]),
        infoJobs: List<InfoJob>.from(
            json["info_jobs"].map((x) => InfoJob.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "infor": info.toJson(),
        "info_jobs": List<dynamic>.from(infoJobs.map((x) => x.toJson())),
      };
}

class InfoJob {
  InfoJob({
    required this.id,
    required this.workType,
    required this.workCity,
    required this.createdAt,
    required this.titleJob,
    required this.jobType,
    required this.dateBidEnd,
    required this.citName,
    required this.skillId,
    required this.salaryType,
    required this.salaryEstimateNumber1,
    required this.salarySalaryEstimateNumber2,
    required this.salaryPermanentNumber,
    required this.namesSkill,
    required this.recordsDid,
  });

  final String id;
  final String workType;
  final String workCity;
  final DateTime createdAt;
  final String titleJob;
  final String jobType;
  final DateTime dateBidEnd;
  final String citName;
  final String skillId;
  final String? salaryType;
  final String? salaryEstimateNumber1;
  final String? salarySalaryEstimateNumber2;
  final String? salaryPermanentNumber;
  final List<String> namesSkill;
  final int recordsDid;

  factory InfoJob.fromJson(Map<String, dynamic> json) => InfoJob(
        id: json["id"],
        workType: json["work_type"],
        workCity: json["work_city"],
        createdAt:
            DateTime.parse((json["created_at"] as String).substring(0, 10)),
        titleJob: json["title_job"],
        jobType: json["job_type"],
        dateBidEnd: DateTimeExt.parse(json["date_bid_end"]),
        citName: json["cit_name"],
        skillId: json["skill_id"],
        salaryType: json["salary_type"],
        salaryEstimateNumber1: json["salary_estimate_number_1"],
        salarySalaryEstimateNumber2: json["salary_salary_estimate_number_2"],
        salaryPermanentNumber: json["salary_permanent_number"],
        namesSkill:
            List<String>.from(json["names_skill"].map((x) => x['skill_name'])),
        recordsDid: json["records_did"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "work_type": workType,
        "work_city": workCity,
        "created_at": createdAt,
        "title_job": titleJob,
        "job_type": jobType,
        "date_bid_end":
            "${dateBidEnd.year.toString().padLeft(4, '0')}-${dateBidEnd.month.toString().padLeft(2, '0')}-${dateBidEnd.day.toString().padLeft(2, '0')}",
        "cit_name": citName,
        "skill_id": skillId,
        "salary_type": salaryType,
        "salary_estimate_number_1": salaryEstimateNumber1,
        "salary_salary_estimate_number_2": salarySalaryEstimateNumber2,
        "salary_permanent_number": salaryPermanentNumber,
        "names_skill": List<dynamic>.from(namesSkill.map((x) => x)),
        "records_did": recordsDid,
      };
}

class Info {
  Info({
    this.avatar,
    this.name,
    required this.city,
    required this.districtName,
    required this.jobsPosted,
    required this.email,
    required this.phone,
  });

  final String? avatar;
  final String? name;
  final String? city;
  final String? districtName;
  final int jobsPosted;
  final String? email;
  final String? phone;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        avatar: json["avatar"],
        name: json["name"],
        city: json["city"],
        districtName: json["district_name"],
        jobsPosted: json["jobs_posted"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "name": name,
        "city": city,
        "district_name": districtName,
        "jobs_posted": jobsPosted,
        "email": email,
        "phone": phone,
      };
}
