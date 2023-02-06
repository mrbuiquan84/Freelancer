import 'package:freelancer/common/models/job_cate.dart';

class JobModel {
  JobModel({
    required this.id,
    required this.titleJob,
    required this.name,
    required this.workCity,
    required this.salaryType,
    this.salaryPermanentNumber,
    this.salaryEstimateNumber1,
    this.salarySalaryEstimateNumber2,
    this.salaryPermanentDate,
    this.salaryEstimatesDate,
    required this.skillId,
    required this.categoryId,
    this.companyLogo,
    required this.createdAt,
    required this.dateBidEnd,
    required this.jobType,
    required this.listSkill,
    required this.cityName,
    required this.categoryName,
    this.srcLogo,
    required this.savedJob,
    required this.userId,
  });

  final String id;
  final String userId;
  final String titleJob;
  final String name;
  final String workCity;
  final String salaryType;
  final String? salaryPermanentNumber;
  final String? salaryEstimateNumber1;
  final String? salarySalaryEstimateNumber2;
  final String? salaryPermanentDate;
  final String? salaryEstimatesDate;
  final String skillId;
  final String categoryId;
  final String? companyLogo;
  final DateTime createdAt;
  final DateTime dateBidEnd;
  final String jobType;
  final List<JobCate> listSkill;
  final String cityName;
  final String categoryName;
  final String? srcLogo;
  final bool savedJob;

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        id: json["id"],
        userId: json['user_id'],
        titleJob: json["title_job"],
        name: json["name"],
        workCity: json["work_city"],
        salaryType: json["salary_type"],
        salaryPermanentDate: json["salary_permanent_date"],
        salaryPermanentNumber: json["salary_permanent_number"],
        salaryEstimatesDate: json["salary_estimates_date"],
        salaryEstimateNumber1: json["salary_estimate_number_1"],
        salarySalaryEstimateNumber2: json["salary_salary_estimate_number_2"],
        skillId: json["skill_id"],
        categoryId: json["category_id"],
        companyLogo: json["company_logo"],
        createdAt: DateTime.parse(json["created_at"]),
        dateBidEnd: DateTime.parse(json["date_bid_end"]),
        jobType: json["job_type"],
        listSkill: List<JobCate>.from(
            json["list_skill"].map((x) => JobCate.fromListSkill(x))),
        cityName: json["city_name"],
        categoryName: json["category_name"],
        srcLogo: json["src_logo"],
        savedJob: json["saved_job"],
      );
}
