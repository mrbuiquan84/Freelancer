import 'package:freelancer/common/models/job_cate.dart';

class GetSavedOngoingProjectResult {
  GetSavedOngoingProjectResult({
    required this.result,
    required this.message,
    required this.dataRender,
  });

  final bool result;
  final String message;
  final DataRender dataRender;

  factory GetSavedOngoingProjectResult.fromJson(Map<String, dynamic> json) =>
      GetSavedOngoingProjectResult(
        result: json["result"],
        message: json["message"],
        dataRender: DataRender.fromJson(json["data_render"]),
      );
}

class DataRender {
  DataRender({
    required this.flcSaveJob,
    required this.countSaveJob,
    required this.flcGoingJob,
    required this.countGoingJob,
    required this.page,
    required this.limit,
  });

  final List<FlcSaveJob> flcSaveJob;
  final int countSaveJob;
  final List<FlcGoingJob> flcGoingJob;
  final int countGoingJob;
  final String page;
  final String limit;

  factory DataRender.fromJson(Map<String, dynamic> json) => DataRender(
        flcSaveJob: List<FlcSaveJob>.from(
            json["flc_save_job"].map((x) => FlcSaveJob.fromJson(x))),
        countSaveJob: json["count_save_job"],
        flcGoingJob: List<FlcGoingJob>.from(
            json["flc_going_job"].map((x) => FlcGoingJob.fromJson(x))),
        countGoingJob: json["count_going_job"],
        page: json["page"],
        limit: json["limit"],
      );
}

class FlcGoingJob {
  FlcGoingJob({
    required this.id,
    required this.workType,
    required this.userId,
    required this.titleJob,
    required this.dateBidEnd,
    required this.salaryType,
    required this.salaryPermanentNumber,
    required this.salaryEstimateNumber1,
    required this.salarySalaryEstimateNumber2,
    required this.createdAt,
    required this.flcId,
    required this.acceptPriceSetting,
    required this.statusWork,
    required this.jobId,
    required this.workingTerm,
    required this.skillId,
    required this.listSkill,
    required this.status,
    this.star = '0',
  });

  final String id;
  final String workType;
  final String userId;
  final String titleJob;
  final DateTime dateBidEnd;
  final String salaryType;
  final String salaryPermanentNumber;
  final String salaryEstimateNumber1;
  final String salarySalaryEstimateNumber2;
  final DateTime createdAt;
  final String flcId;
  final String acceptPriceSetting;
  final String statusWork;
  final String jobId;
  final String workingTerm;
  final String skillId;
  final List<JobCate> listSkill;
  final String status;
  final String star;

  factory FlcGoingJob.fromJson(Map<String, dynamic> json) => FlcGoingJob(
        id: json["id"],
        workType: json["work_type"],
        userId: json["user_id"],
        titleJob: json["title_job"],
        dateBidEnd: DateTime.parse(json["date_bid_end"]),
        salaryType: json["salary_type"],
        salaryPermanentNumber: json["salary_permanent_number"],
        salaryEstimateNumber1: json["salary_estimate_number_1"],
        salarySalaryEstimateNumber2: json["salary_salary_estimate_number_2"],
        createdAt: DateTime.parse(json["created_at"]),
        flcId: json["flc_id"],
        acceptPriceSetting: json["accept_price_setting"],
        statusWork: json["status_work"],
        jobId: json["job_id"],
        workingTerm: json["working_term"],
        skillId: json["skill_id"],
        listSkill: List<JobCate>.from(
            json["list_skill"].map((x) => JobCate.fromListSkill(x))),
        status: json["status"],
        star: json['star'] != null ? json["star"] : '0',
      );
}

class FlcSaveJob {
  FlcSaveJob({
    required this.id,
    required this.workType,
    required this.userId,
    required this.titleJob,
    required this.skillId,
    required this.dateBidEnd,
    required this.salaryType,
    this.salaryPermanentNumber,
    this.salaryEstimateNumber1,
    this.salarySalaryEstimateNumber2,
    required this.createdAt,
    required this.flcId,
    required this.workingTerm,
    required this.listSkill,
  });

  final String id;
  final String workType;
  final String userId;
  final String titleJob;
  final String skillId;
  final DateTime dateBidEnd;
  final String salaryType;
  final String? salaryPermanentNumber;
  final String? salaryEstimateNumber1;
  final String? salarySalaryEstimateNumber2;
  final DateTime createdAt;
  final String flcId;
  final String workingTerm;
  final List<JobCate> listSkill;

  factory FlcSaveJob.fromJson(Map<String, dynamic> json) => FlcSaveJob(
        id: json["id"],
        workType: json["work_type"],
        userId: json["user_id"],
        titleJob: json["title_job"],
        skillId: json["skill_id"],
        dateBidEnd: DateTime.parse(json["date_bid_end"]),
        salaryType: json["salary_type"],
        salaryPermanentNumber: json["salary_permanent_number"],
        salaryEstimateNumber1: json["salary_estimate_number_1"],
        salarySalaryEstimateNumber2: json["salary_salary_estimate_number_2"],
        createdAt: DateTime.parse(json["created_at"]),
        flcId: json["flc_id"],
        workingTerm: json["working_term"],
        listSkill: List<JobCate>.from(
            json["list_skill"].map((x) => JobCate.fromListSkill(x))),
      );
}
