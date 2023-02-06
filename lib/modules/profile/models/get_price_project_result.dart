import 'package:intl/intl.dart';

class GetPriceProjectResult {
  GetPriceProjectResult({
    required this.result,
    required this.message,
    required this.list,
  });

  final bool result;
  final String message;
  final List<PriceProject> list;

  factory GetPriceProjectResult.fromJson(Map<String, dynamic> json) =>
      GetPriceProjectResult(
        result: json['result'],
        message: json['message'],
        list: List<PriceProject>.from(
            json['list'].map((x) => PriceProject.fromJson(x))),
      );
}

class PriceProject {
  PriceProject({
    required this.id,
    required this.flcId,
    required this.jobId,
    required this.flcEmail,
    required this.titleJob,
    required this.salary,
    required this.salaryType,
    required this.salaryDf,
    required this.dateEnd,
    required this.status,
  });

  final String id;
  final String flcId;
  final String jobId;
  final String flcEmail;
  final String titleJob;
  final String salary;
  final String salaryType;
  final String salaryDf;
  final DateTime dateEnd;
  final String status;

  factory PriceProject.fromJson(Map<String, dynamic> json) => PriceProject(
        id: json['id'],
        flcId: json['flc_id'],
        jobId: json['job_id'],
        flcEmail: json['flc_email'],
        titleJob: json['title_job'],
        salary: json['salary'],
        salaryType: json['salary_type'],
        salaryDf: json['salary_df'],
        dateEnd: DateFormat('dd-MM-yyyy').parse(json["date_end"]),
        status: json['status_setting'],
      );
}
