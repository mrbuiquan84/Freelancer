class OngoingProjectStatus {
  final int id;
  final String status;

  const OngoingProjectStatus({
    required this.id,
    required this.status,
  });

  factory OngoingProjectStatus.fromId(int id) {
    return statuses.firstWhere((element) => element.id == id);
  }

  static const statuses = [
    OngoingProjectStatus(
      id: 0,
      status: 'Đang thực hiện',
    ),
    OngoingProjectStatus(
      id: 1,
      status: 'Không hoàn thành',
    ),
    OngoingProjectStatus(
      id: 2,
      status: 'Hoàn thành',
    ),
  ];

  @override
  String toString() => status;
}
