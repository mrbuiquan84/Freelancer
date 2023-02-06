import 'package:freelancer/utils/helpers/datetime_extension.dart';

class PostJobDetailResult {
  PostJobDetailResult({
    required this.result,
    required this.message,
    required this.info,
    required this.jobsSame,
    required this.listsFlc,
  });

  final bool result;
  final String message;
  final JobDetail info;
  final List<JobsSame> jobsSame;
  final List<ListsFlc> listsFlc;

  factory PostJobDetailResult.fromJson(Map<String, dynamic> json) =>
      PostJobDetailResult(
        result: json["result"],
        message: json["message"],
        info: JobDetail.fromJson(json["info"]),
        jobsSame: List<JobsSame>.from(
            json["Jobs_same"].map((x) => JobsSame.fromJson(x))),
        listsFlc: List<ListsFlc>.from(
            json["lists_flc"].map((x) => ListsFlc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "info": info.toJson(),
        "Jobs_same": List<dynamic>.from(jobsSame.map((x) => x.toJson())),
        "lists_flc": List<dynamic>.from(listsFlc.map((x) => x.toJson())),
      };
}

class JobDetail {
  JobDetail({
    required this.id,
    required this.userId,
    required this.titleJob,
    required this.alias,
    required this.categoryId,
    required this.workType,
    required this.workDes,
    required this.workFileDes,
    required this.salaryType,
    required this.salaryEstimateNumber1,
    required this.salarySalaryEstimateNumber2,
    required this.salaryPermanentDate,
    required this.salaryEstimatesDate,
    required this.salaryPermanentNumber,
    required this.workingTerm,
    required this.jobType,
    required this.companyLogo,
    required this.createdAt,
    required this.updatedAt,
    required this.seoIndex,
    required this.workName,
    required this.name,
    required this.avatar,
    required this.skillName,
    required this.categoryName,
    required this.citName,
    required this.expName,
    required this.avatars,
    required this.startDid,
    required this.createdAts,
    required this.endDid,
    required this.startWork,
    required this.jobsPosted,
    required this.orderedFlc,
  });

  final String id;
  final String userId;
  final String titleJob;
  final String alias;
  final String categoryId;
  final String workType;
  final String workDes;
  final String? workFileDes;
  final String? salaryType;
  final String? salaryEstimateNumber1;
  final String? salarySalaryEstimateNumber2;
  final String? salaryPermanentDate;
  final String? salaryEstimatesDate;
  final String? salaryPermanentNumber;
  final String workingTerm;
  final String jobType;
  final String? companyLogo;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String seoIndex;
  final String workName;
  final String? name;
  final String? avatar;
  final String skillName;
  final String categoryName;
  final String citName;
  final String expName;
  final String? avatars;
  final DateTime startDid;
  final DateTime? createdAts;
  final DateTime endDid;
  final DateTime startWork;
  final int jobsPosted;
  final int orderedFlc;

  factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
        id: json["id"],
        userId: json["user_id"],
        titleJob: json["title_job"],
        alias: json["alias"],
        categoryId: json["category_id"],
        workType: json["work_type"],
        workDes: json["work_des"],
        workFileDes: json["work_file_des"],
        salaryType: json["salary_type"],
        salaryEstimateNumber1: json["salary_estimate_number_1"],
        salarySalaryEstimateNumber2: json["salary_salary_estimate_number_2"],
        salaryPermanentDate: json["salary_permanent_date"],
        salaryPermanentNumber: json["salary_permanent_number"],
        salaryEstimatesDate: json["salary_estimates_date"],
        workingTerm: json["working_term"],
        jobType: json["job_type"],
        companyLogo: json["company_logo"],
        createdAt: DateTimeExt.parse(json["created_at"]),
        updatedAt: DateTimeExt.parse(json["updated_at"]),
        seoIndex: json["seo_index"],
        workName: json["work_name"],
        name: json["name"],
        avatar: json["avatar"],
        skillName: json["skill_name"],
        categoryName: json["category_name"],
        citName: json["cit_name"],
        expName: json["exp_name"],
        avatars: json["avatars"],
        startDid: DateTimeExt.parse(json["start_did"]),
        createdAts: DateTimeExt.parse(json["created_ats"]),
        endDid: DateTimeExt.parse(json["end_did"]),
        startWork: DateTimeExt.parse(json["start_work"]),
        jobsPosted: json["jobs_posted"],
        orderedFlc: json["Flc_dided"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title_job": titleJob,
        "alias": alias,
        "category_id": categoryId,
        "work_type": workType,
        "work_des": workDes,
        "work_file_des": workFileDes,
        "salary_type": salaryType,
        "salary_estimate_number_1": salaryEstimateNumber1,
        "salary_salary_estimate_number_2": salarySalaryEstimateNumber2,
        "salary_permanent_date": salaryPermanentDate,
        "salary_estimates_date": salaryEstimatesDate,
        "working_term": workingTerm,
        "job_type": jobType,
        "company_logo": companyLogo,
        "created_at": createdAt.toIso8601String(),
        "updated_at":
            "${updatedAt?.year.toString().padLeft(4, '0')}-${updatedAt?.month.toString().padLeft(2, '0')}-${updatedAt?.day.toString().padLeft(2, '0')}",
        "seo_index": seoIndex,
        "work_name": workName,
        "name": name,
        "avatar": avatar,
        "skill_name": skillName,
        "category_name": categoryName,
        "cit_name": citName,
        "exp_name": expName,
        "avatars": avatars,
        "start_did": startDid,
        "created_ats": createdAts,
        "end_did": endDid,
        "start_work": startWork,
        "jobs_posted": jobsPosted,
        "Flc_dided": orderedFlc,
      };
}

class JobsSame {
  JobsSame({
    required this.id,
    required this.salaryType,
    required this.titleJob,
    required this.salaryPermanentNumber,
    required this.salarySalaryEstimateNumber2,
    required this.salaryEstimateNumber1,
    required this.categoryId,
    required this.categoryName,
  });

  final String id;
  final String? salaryType;
  final String titleJob;
  final String? salaryPermanentNumber;
  final String? salarySalaryEstimateNumber2;
  final String? salaryEstimateNumber1;
  final String categoryId;
  final String categoryName;

  factory JobsSame.fromJson(Map<String, dynamic> json) => JobsSame(
        id: json["id"],
        salaryType: json["salary_type"],
        titleJob: json["title_job"],
        salaryPermanentNumber: json["salary_permanent_number"],
        salarySalaryEstimateNumber2:
            json["salary_salary_estimate_number_2"] == null
                ? null
                : json["salary_salary_estimate_number_2"],
        salaryEstimateNumber1: json["salary_estimate_number_1"] == null
            ? null
            : json["salary_estimate_number_1"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "salary_type": salaryType,
        "title_job": titleJob,
        "salary_permanent_number": salaryPermanentNumber,
        "salary_salary_estimate_number_2": salarySalaryEstimateNumber2 == null
            ? null
            : salarySalaryEstimateNumber2,
        "salary_estimate_number_1":
            salaryEstimateNumber1 == null ? null : salaryEstimateNumber1,
        "category_id": categoryId,
        "category_name": categoryName,
      };
}

class ListsFlc {
  ListsFlc({
    required this.name,
    required this.userJob,
    required this.salary,
    required this.listsSkill,
  });

  final String name;
  final String userJob;
  final String salary;
  final List<String> listsSkill;

  factory ListsFlc.fromJson(Map<String, dynamic> json) => ListsFlc(
        name: json["name"],
        userJob: json["user_job"],
        salary: json["salary"],
        listsSkill: List<String>.from(json["lists_skill"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "user_job": userJob,
        "salary": salary,
        "lists_skill": List<dynamic>.from(listsSkill.map((x) => x)),
      };
}
