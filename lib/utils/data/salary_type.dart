class SalaryType {
  final int id;
  final String salaryType;

  const SalaryType({
    required this.id,
    required this.salaryType,
  });

  static const staticSalaryType = SalaryType(id: 1, salaryType: 'Cố định');
  static const estimateSalaryType = SalaryType(id: 2, salaryType: 'Ước lượng');

  static const values = [
    staticSalaryType,
    estimateSalaryType,
  ];

  @override
  String toString() => salaryType;

  static int get minSalaryTypeId => 1;
}
