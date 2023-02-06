import 'package:freelancer/utils/helpers/object_extension.dart';

class JobCate {
  final int id;
  final String jobCate;
  int? parentId;

  JobCate({
    required this.id,
    required this.jobCate,
    this.parentId,
  });

  factory JobCate.fromJobCate(Map<String, dynamic> json) => JobCate(
        id: int.parse(json['id']),
        jobCate: json['category_name'],
        // parentId: json['category_id'] != null
        //     ? int.tryParse(json['category_id'])
        //     : null,
      );
  // factory JobCate.fromJson(Map<String, dynamic> json) => JobCate(
  //       id: int.parse(json['category_id']),
  //       jobCate: json['category_name'],
  //     );
  factory JobCate.fromListSkill(Map<String, dynamic> json) => JobCate(
        id: int.parse(json['id']),
        jobCate: json['skill_name'],
        parentId: json['category_id'] != null
            ? int.tryParse(json['category_id'])
            : null,
      );

  factory JobCate.fromId(
    dynamic id, {
    required List<JobCate> list,
  }) =>
      list.singleWhere(
        (e) => e.id.stringCompareWith(id),
        orElse: () => list[0],
      );

  @override
  String toString() => jobCate;
}

class Skill {
  final int id;
  final String skillName;
  final int cateId;

  Skill({required this.id, required this.skillName, required this.cateId});
  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: int.parse(json['id']),
        skillName: json['skill_name'],
        cateId: int.parse(json['category_id']),
      );
  factory Skill.fromId(
    dynamic id, {
    required List<Skill> list,
  }) =>
      list.singleWhere(
        (e) => e.id.stringCompareWith(id),
        orElse: () => list[0],
      );
  factory Skill.fromName(dynamic name, {required List<Skill> list}) =>
      list.singleWhere((element) => element.skillName.stringCompareWith(name),
          orElse: () => list[0]);
  @override
  String toString() => skillName;
}
