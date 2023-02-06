import 'package:freelancer/core/constants/string_constants.dart';

class Flcer {
  final String id;
  final String? avatar;
  final String cates;
  final double rating;
  final List<String> skills;
  final String name;
  final String location;
  final DateTime createdDate;
  final DateTime dob;
  final String gender;
  final String phone;
  final String email;
  final String exps;
  final String intro;
  final String job;

  Flcer({
    required this.id,
    this.avatar,
    this.skills = const [],
    this.gender = 'Nam',
    required this.email,
    required this.phone,
    required this.dob,
    required this.createdDate,
    required this.name,
    required this.cates,
    required this.rating,
    required this.location,
    required this.job,
    this.exps = StringConst.notHadYet,
    this.intro = '',
  });

  static final flcer = Flcer(
    id: "1",
    cates: 'IT & Lập trình',
    job: 'Designer',
    email: '123456@gmail.com',
    rating: 4.0,
    phone: '0123456789',
    name: 'Mipan Zu Zu',
    dob: DateTime.now(),
    location: 'Hà Nội',
    intro:
        '- Cử nhân khoa mỹ thuật công nghiệp Đại học Kiến trúc TP.HCM \n- Fashion designer - công ty KOMBAT SPORTSWEAR...  ',
    createdDate: DateTime.now(),
    skills: [
      'PHP',
      'Tổng đài',
      'Tổng đài',
      'Tổng đài',
      'Quảng cáo Facebook',
      'Bán hàng',
    ],
  );
}
