class SocialMediaType {
  int id;
  final String name;

  SocialMediaType({
    required this.id,
    required this.name,
  });

  factory SocialMediaType.fromJson(Map<String, dynamic> json) {
    return SocialMediaType(
      id: json['id'],
      name: json['name'],
    );
  }
}