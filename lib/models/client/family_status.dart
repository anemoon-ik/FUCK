class FamilyStatus {
  int id;
  String name;
  static String modelName = 'FamilyStatus';

  FamilyStatus({
    required this.id,
    required this.name,
  });

  factory FamilyStatus.fromJson(Map<String, dynamic> json) {
    return FamilyStatus(
      id: json['id'],
      name: json['name'],
    );
  }
}
