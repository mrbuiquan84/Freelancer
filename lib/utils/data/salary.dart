import 'package:freelancer/core/constants/string_constants.dart';
import 'package:freelancer/utils/data/salary_type.dart';
import 'package:freelancer/utils/data/time.dart';

class Salary {
  final SalaryType salaryType;
  final int? staticSalary;
  final int? estimateMinSalary;
  final int? estimateMaxSalary;
  final Time? salaryTime;

  Salary({
    required this.salaryType,
    this.salaryTime,
    this.staticSalary,
    this.estimateMinSalary,
    this.estimateMaxSalary,
  });
  static const times = ["Ngày", "Tuần", "Tháng", "Năm"];
  factory Salary.fromJob(dynamic job) {
    try {
      String? salaryPermanentDate2;
      String? salaryEstimatesDate2;
      String? salaryPermanentNumber2;
      String? salaryEstimateNumber12;
      String? salarySalaryEstimateNumber2;
      try {
        salaryPermanentDate2 = job.salaryPermanentDate;
      } catch (_) {}
      try {
        salaryEstimatesDate2 = job.salaryEstimatesDate;
      } catch (_) {}
      try {
        salaryPermanentNumber2 = job.salaryPermanentNumber;
      } catch (_) {}
      try {
        salaryEstimateNumber12 = job.salaryEstimateNumber1;
      } catch (_) {}
      try {
        salarySalaryEstimateNumber2 = job.salarySalaryEstimateNumber2;
      } catch (_) {}
      return Salary.fromProperties(
        salaryType: job.salaryType,
        salaryPermanentNumber: salaryPermanentNumber2,
        salaryEstimateNumber1: salaryEstimateNumber12,
        salaryEstimateNumber2: salarySalaryEstimateNumber2,
        salaryPermanentDate: salaryPermanentDate2,
        salaryEstimatesDate: salaryEstimatesDate2,
      );
    } catch (e, s) {
      print(e);
      print(s);
      return Salary(salaryType: SalaryType.values[0]);
    }
  }

  factory Salary.fromProperties({
    required String salaryType,
    String? salaryPermanentNumber,
    String? salaryEstimateNumber1,
    String? salaryEstimateNumber2,
    String? salaryPermanentDate,
    String? salaryEstimatesDate,
  }) {
    int? salary1;
    int? salary2;
    Time? time;

    var typeId = int.tryParse(salaryType) ?? SalaryType.minSalaryTypeId;
    var type = SalaryType.values.singleWhere((e) => e.id == typeId);
    switch (type) {
      case SalaryType.staticSalaryType:
        salary1 = int.parse(salaryPermanentNumber!);
        if (salaryPermanentDate != null) {
          time = Time.values
              .singleWhere((e) => e.id == int.parse(salaryPermanentDate));
        }
        break;
      case SalaryType.estimateSalaryType:
        salary1 = int.parse(salaryEstimateNumber1!);
        salary2 = int.parse(salaryEstimateNumber2!);
        if (salaryEstimatesDate != null) {
          time = Time.values
              .singleWhere((e) => e.id == int.parse(salaryEstimatesDate));
        }
        break;
    }
    return Salary(
      salaryType: type,
      salaryTime: time,
      staticSalary: salary1,
      estimateMinSalary: salary1,
      estimateMaxSalary: salary2,
    );
  }

  factory Salary.fromJson(Map<String, dynamic> json) => Salary.fromProperties(
        salaryType: json["salary_type"],
        salaryPermanentDate: json["salary_permanent_date"],
        salaryPermanentNumber: json["salary_permanent_number"],
        salaryEstimatesDate: json["salary_estimates_date"],
        salaryEstimateNumber1: json["salary_estimate_number_1"],
        salaryEstimateNumber2: json["salary_salary_estimate_number_2"],
      );

  toSalaryString() {
    String? salary;
    if (salaryType == SalaryType.staticSalaryType) {
      if (staticSalary != null) {
        salary = staticSalary.toString();
      }
    } else if (salaryType == SalaryType.estimateSalaryType) {
      if (estimateMinSalary != null && estimateMaxSalary != null) {
        salary =
            estimateMinSalary.toString() + ' - ' + estimateMaxSalary.toString();
      }
    } else {
      print(StringConst.notFoundError + salaryType.id.toString());
      return StringConst.error;
    }
    if (salary == null) {
      return StringConst.error;
    }
    final String? time = salaryTime?.toString();
    return salary + ' ${StringConst.vnd}' + (time != null ? ' /$time' : '');
  }
}
