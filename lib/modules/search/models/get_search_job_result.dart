import 'package:freelancer/common/models/job_cate.dart';

class GetSearchJobResult {
  GetSearchJobResult({
    required this.result,
    required this.message,
    required this.dataRender,
    this.record,
  });

  final bool result;
  final String message;
  final List<JobModel2> dataRender;
  final int? record;

  factory GetSearchJobResult.fromJson(Map<String, dynamic> json) =>
      GetSearchJobResult(
        result: json["result"],
        message: json["message"],
        dataRender: List<JobModel2>.from(
            json["data_render"].map((x) => JobModel2.fromJson(x))),
        record: json["record"],
      );
}

class JobModel2 {
  JobModel2({
    required this.id,
    required this.userId,
    required this.titleJob,
    required this.alias,
    required this.categoryId,
    required this.skillId,
    required this.workType,
    required this.workCity,
    required this.workExp,
    required this.workDes,
    this.workFileDes,
    this.orders,
    required this.salaryType,
    required this.salaryPermanentNumber,
    required this.salaryEstimateNumber1,
    required this.salarySalaryEstimateNumber2,
    required this.salaryPermanentDate,
    required this.salaryEstimatesDate,
    required this.dateBidStart,
    required this.dateBidEnd,
    required this.dateWorkStart,
    required this.workingTerm,
    required this.jobType,
    this.companyLogo,
    required this.createdAt,
    required this.updatedAt,
    required this.seoIndex,
    required this.empName,
    required this.cityName,
    required this.listSkill,
    this.srcLogo,
    required this.savedJob,
    required this.isOrdered,
  });

  final String id;
  final String userId;
  final String titleJob;
  final String alias;
  final String categoryId;
  final String skillId;
  final String workType;
  final String workCity;
  final String workExp;
  final String workDes;
  final String? workFileDes;
  final String? salaryType;
  final String? salaryPermanentNumber;
  final String? salaryEstimateNumber1;
  final String? salarySalaryEstimateNumber2;
  final String? salaryPermanentDate;
  final String? salaryEstimatesDate;
  final String dateBidStart;
  final String dateBidEnd;
  final String dateWorkStart;
  final String workingTerm;
  final String jobType;
  final String? companyLogo;
  final DateTime createdAt;
  final String updatedAt;
  final String seoIndex;
  final String? empName;
  final String cityName;
  final List<JobCate> listSkill;
  final String? srcLogo;
  final bool savedJob;
  final String? orders;
  final bool isOrdered;

  factory JobModel2.fromJson(Map<String, dynamic> json) => JobModel2(
        id: json["id"],
        userId: json["user_id"],
        titleJob: json["title_job"],
        alias: json["alias"],
        categoryId: json["category_id"],
        skillId: json["skill_id"],
        workType: json["work_type"],
        workCity: json["work_city"],
        workExp: json["work_exp"],
        workDes: json["work_des"],
        workFileDes: json["work_file_des"],
        salaryType: json["salary_type"],
        salaryPermanentNumber: json["salary_permanent_number"],
        salaryEstimateNumber1: json["salary_estimate_number_1"],
        salarySalaryEstimateNumber2: json["salary_salary_estimate_number_2"],
        salaryPermanentDate: json["salary_permanent_date"],
        salaryEstimatesDate: json["salary_estimates_date"],
        dateBidStart: json["date_bid_start"],
        dateBidEnd: json["date_bid_end"],
        dateWorkStart: json["date_work_start"],
        workingTerm: json["working_term"],
        jobType: json["job_type"],
        companyLogo: json["company_logo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        seoIndex: json["seo_index"],
        empName: json["emp_name"],
        cityName: json["city_name"],
        listSkill: List<JobCate>.from(
            json["list_skill"].map((x) => JobCate.fromListSkill(x))),
        srcLogo: json["src_logo"],
        savedJob: json["saved_job"],
        orders: json['soLuongDatGia'],
        isOrdered: json['datgia'] ?? false,
      );
}
