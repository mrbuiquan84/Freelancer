import 'dart:math';

import 'package:freelancer/common/models/empler.dart';

class Job {
  Job({
    required this.jobName,
    required this.emplerName,
    required this.location,
    required this.salary,
    required this.skills,
    required this.expiredDate,
    required this.jobCates,
    required this.type,
    required this.jobId,
    required this.empler,
    this.orders = 0,
    this.createdDate,
    this.startDate,
    this.description = '',
    this.duration,
    this.exp,
  });

  final String jobName;
  final String emplerName;
  final String location;
  final String salary;
  final List<String> skills;
  final List<String> jobCates;
  final DateTime expiredDate;
  final String type;
  final DateTime? createdDate;
  final DateTime? startDate;
  final String description;
  final String jobId;
  final String? duration;
  final String? exp;
  final Empler empler;
  final int orders;

  static final listJobs = [
    Job(
      jobId: Random().nextInt(9999).toString(),
      empler: Empler.empler,
      jobName: 'Tìm coder thiết kế website chủ yếu là...',
      emplerName: 'Công ty TNHH Cỏ May',
      location: 'Thanh Xuân, Hà Nội',
      salary: '500.000đ - 1.000.000đ',
      skills: ['Hỗ trợ', 'Tổng đài', 'Khách hàng', 'Tổng đài'],
      expiredDate: DateTime.now(),
      jobCates: ['IT & Lập trình'],
      type: 'Dự án',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
    ),
    Job(
      jobId: Random().nextInt(9999).toString(),
      empler: Empler.empler,
      jobName: 'Tìm coder thiết kế website chủ yếu là...',
      emplerName: 'Công ty TNHH Cỏ May',
      location: 'Thanh Xuân, Hà Nội',
      salary: '500.000đ - 1.000.000đ',
      skills: ['Hỗ trợ khách hàng', 'Tổng đài'],
      expiredDate: DateTime.now(),
      jobCates: ['IT & Lập trình'],
      type: 'Bán thời gian',
    ),
  ];
}
