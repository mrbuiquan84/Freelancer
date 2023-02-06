class SetPriceProjectStatus {
  final int id;
  final String status;

  const SetPriceProjectStatus({
    required this.id,
    required this.status,
  });

  factory SetPriceProjectStatus.fromId(int id) {
    return statuses.firstWhere((element) => element.id == id);
  }

  static const statuses = [
    SetPriceProjectStatus(
      id: 0,
      status: "Chờ chấp nhận",
    ),
    SetPriceProjectStatus(
      id: 1,
      status: "Từ chối",
    ),
    SetPriceProjectStatus(
      id: 2,
      status: "Đã chấp nhận",
    ),
  ];

  @override
  String toString() => status;
}
