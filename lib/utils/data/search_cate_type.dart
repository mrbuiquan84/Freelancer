class SearchCateType {
  final int id;
  final String jsonKey;

  const SearchCateType({
    required this.id,
    required this.jsonKey,
  });

  static const minId = 0;

  static const jobCate = SearchCateType(
    id: minId,
    jsonKey: 'category_id',
  );
  static const city = SearchCateType(
    id: minId + 1,
    jsonKey: 'city',
  );
  static const skill = SearchCateType(
    id: minId + 2,
    jsonKey: 'skill_id',
  );
  static const type = SearchCateType(
    id: minId + 3,
    jsonKey: 'type',
  );

  static const values = [
    jobCate,
    city,
    skill,
    type,
  ];

  factory SearchCateType.fromId(int id) =>
      values.singleWhere((e) => e.id == id);
}
