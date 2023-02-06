import 'package:freelancer/common/models/job_model.dart';

class GetHomeDataLoadResult {
  GetHomeDataLoadResult({
    required this.result,
    required this.message,
    required this.dataRender,
  });

  final bool result;
  final String message;
  final DataRender dataRender;

  factory GetHomeDataLoadResult.fromJson(Map<String, dynamic> json) =>
      GetHomeDataLoadResult(
        result: json["result"],
        message: json["message"],
        dataRender: DataRender.fromJson(json["data_render"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "result": result,
  //       "message": message,
  //       "data_render": dataRender.toJson(),
  //     };
}

class DataRender {
  DataRender({
    required this.jobByProject,
    required this.countJobByProject,
    required this.jobPartTime,
    required this.countJobPartTime,
  });

  final List<JobModel> jobByProject;
  final int countJobByProject;
  final List<JobModel> jobPartTime;
  final int countJobPartTime;

  factory DataRender.fromJson(Map<String, dynamic> json) => DataRender(
        jobByProject: List<JobModel>.from(
            json["job_by_project"].map((x) => JobModel.fromJson(x))),
        countJobByProject: json["count_job_by_project"],
        jobPartTime: List<JobModel>.from(
            json["job_part_time"].map((x) => JobModel.fromJson(x))),
        countJobPartTime: json["count_job_part_time"],
      );

  // Map<String, dynamic> toJson() => {
  //       "job_by_project":
  //           List<dynamic>.from(jobByProject.map((x) => x.toJson())),
  //       "count_job_by_project": countJobByProject,
  //       "job_part_time": List<dynamic>.from(jobPartTime.map((x) => x.toJson())),
  //       "count_job_part_time": countJobPartTime,
  //     };
}
