import 'package:equatable/equatable.dart';
import 'package:freelancer/utils/helpers/object_extension.dart';

class JobType extends Equatable {
  final int id;
  final String jobType;

  const JobType({
    required this.id,
    required this.jobType,
  });

  static const _minJobTypeId = 0;

  static int get minJobTypeId => _minJobTypeId;

  static const projectType = JobType(
    id: _minJobTypeId,
    jobType: 'Dự án',
  );
  static const parttimeType = JobType(
    id: _minJobTypeId + 1,
    jobType: 'Bán thời gian',
  );

  static const values = [
    projectType,
    parttimeType,
  ];

  factory JobType.fromId(id) {
    return values.singleWhere((e) => e.id.stringCompareWith(id), orElse: () {
      print('ERROR NOT FOUND JobType.id = $id');
      return values[0];
    });
  }

  @override
  String toString() => jobType;

  @override
  List<Object?> get props => [id];
}
