import 'package:equatable/equatable.dart';

class SelectableItem extends Equatable {
  final String id;
  final String name;

  const SelectableItem({
    required this.id,
    required this.name,
  });

  factory SelectableItem.fromJsonCity(Map<String, dynamic> json) => SelectableItem(
        id: json["cit_id"],
        name: json["cit_name"],
      );

  @override
  List<Object?> get props => [
        id,
      ];

// @override
// bool get stringify => true;

// @override
// String toString() => "$runtimeType(id: $id, name: $name})";
}

extension SelectableItemExt on List<SelectableItem> {
  String get names => map((e) => e.name).join(', ');
}
