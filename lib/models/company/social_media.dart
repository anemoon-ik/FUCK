class SocialMedia {
  int id;
  final String type;
  final String url;
  final bool isPrimarySource;

  SocialMedia({
    required this.id,
    required this.type,
    required this.url,
    required this.isPrimarySource,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
        id: json['id'],
        type: json['type'],
        url: json['url'],
        isPrimarySource: json['is_primary_source']);
  }
}
