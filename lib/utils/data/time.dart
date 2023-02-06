import 'package:freelancer/utils/helpers/object_extension.dart';
import 'package:freelancer/utils/helpers/string_extension.dart';

class Time {
  const Time({
    required this.id,
    required this.time,
  });

  final int id;
  final String time;

  static const day = Time(id: 1, time: 'Ngày');
  static const week = Time(id: 2, time: 'Tuần');
  static const month = Time(id: 3, time: 'Tháng');
  static const year = Time(id: 4, time: 'Năm');

  static const values = [
    day,
    week,
    month,
    year,
  ];

  factory Time.fromId(id) =>
      values.singleWhere((e) => e.id.stringCompareWith(id), orElse: () {
        print('ERROR NOT FOUND Time.id = $id');
        return values[0];
      });

  @override
  String toString() => time.toTitleCase();
}
