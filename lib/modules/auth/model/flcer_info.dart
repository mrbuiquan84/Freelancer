import 'package:freelancer/modules/auth/model/post_flcer_info_result.dart';

class FlcerInfo {
  final Info info;
  final Basic basic;
  final Intro intro;
  final Work work;
  final Skill skill;
  final Proficency2 proficiency;

  FlcerInfo({
    required this.info,
    required this.basic,
    required this.intro,
    required this.work,
    required this.skill,
    required this.proficiency,
  });
}
