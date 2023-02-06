import 'package:freelancer/utils/helpers/string_extension.dart';

class City {
  final int citId;
  final String citName;

  City({
    required this.citId,
    required this.citName,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        citId: int.parse(json['cit_id']),
        citName: json['cit_name'],
      );

  factory City.fromId(id, {required List<City> list}) => list.singleWhere(
        (e) {
          if (id is int) {
            return e.citId == id;
          } else {
            return e.citId.toString().compareWith(id);
          }
        },
        orElse: () => list[0],
      );

  @override
  String toString() => citName;
}
