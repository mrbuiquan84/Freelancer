class Gender {
  final int id;
  final String gender;

  const Gender({
    required this.id,
    required this.gender,
  });

  static const male = Gender(id: 1, gender: 'Nam');
  static const female = Gender(id: 2, gender: 'Nữ');

  static const values = [
    male,
    female,
  ];

  factory Gender.fromStringId(String strId) {
    var id = values.indexWhere(
      (e) => e.id.toString() == strId,
    );
    return id != -1 ? values[id] : values[0];
  }
  factory Gender.fromGender(String gender) {
    var id = values.indexWhere(
      (e) => e.gender.toString() == gender,
    );
    return id != -1 ? values[id] : values[0];
  }

  @override
  String toString() => gender;
}
