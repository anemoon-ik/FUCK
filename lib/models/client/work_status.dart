class WorkStatus {
  int id;
  String name;
  static String modelName = 'WorkStatus';

  WorkStatus({
    required this.id,
    required this.name,
  });

  factory WorkStatus.fromJson(Map<String, dynamic> json) {
    return WorkStatus(
      id: json['id'],
      name: json['name'],
    );
  }
}