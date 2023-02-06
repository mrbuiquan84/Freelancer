class Empler {
  const Empler({
    this.avatar,
    required this.location,
    required this.createdDate,
    required this.numOfPostedJob,
    required this.name,
    required this.point,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.email,
  });

  final String? avatar;
  final String location;
  final DateTime createdDate;
  final DateTime dob;
  final String numOfPostedJob;
  final String name;
  final int point;
  final String gender;
  final String phone;
  final String email;

  static final empler = Empler(
    location: 'Hà Nội',
    createdDate: DateTime.utc(2021, 2, 12),
    numOfPostedJob: '12',
    name: 'Nguyễn Thị Phương',
    point: 10,
    dob: DateTime.utc(1999),
    gender: 'Nam',
    phone: '123456123',
    email: 'email@gmail.com.vn',
  );
}
