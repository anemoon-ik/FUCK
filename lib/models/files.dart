class FileType {
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  FileType(
      {required this.name, required this.createdAt, required this.updatedAt});

  factory FileType.fromJson(Map<String, dynamic> json) {
    return FileType(
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class FileLocation {
  int id;
  int locationId;
  String url;
  DateTime createdAt;
  DateTime updatedAt;

  FileLocation(
      {required this.id,
      required this.locationId,
      required this.url,
      required this.createdAt,
      required this.updatedAt});

  factory FileLocation.fromJson(Map<String, dynamic> json) {
    return FileLocation(
      id: json['id'],
      locationId: json['location_id'],
      url: json['url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class FileTrip {
  int id;
  int tripId;
  String url;
  DateTime createdAt;
  DateTime updatedAt;

  FileTrip(
      {required this.id,
      required this.tripId,
      required this.url,
      required this.createdAt,
      required this.updatedAt});

  factory FileTrip.fromJson(Map<String, dynamic> json) {
    return FileTrip(
      id: json['id'],
      tripId: json['trip_id'],
      url: json['url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class FileCompany {
  int id;
  int companyId;
  String url;
  DateTime createdAt;
  DateTime updatedAt;

  FileCompany(
      {required this.id,
      required this.companyId,
      required this.url,
      required this.createdAt,
      required this.updatedAt});

  factory FileCompany.fromJson(Map<String, dynamic> json) {
    return FileCompany(
      id: json['id'],
      companyId: json['company_id'],
      url: json['url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class CommentImageLocation {
  int id;
  int commentId;
  String url;
  DateTime createdAt;
  DateTime updatedAt;

  CommentImageLocation(
      {required this.id,
      required this.commentId,
      required this.url,
      required this.createdAt,
      required this.updatedAt});

  factory CommentImageLocation.fromJson(Map<String, dynamic> json) {
    return CommentImageLocation(
      id: json['id'],
      commentId: json['comment_id'],
      url: json['url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class CommentImageTrip {
  int id;
  int commentId;
  String url;
  DateTime createdAt;
  DateTime updatedAt;

  CommentImageTrip(
      {required this.id,
      required this.commentId,
      required this.url,
      required this.createdAt,
      required this.updatedAt});

  factory CommentImageTrip.fromJson(Map<String, dynamic> json) {
    return CommentImageTrip(
      id: json['id'],
      commentId: json['comment_id'],
      url: json['url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class CommentImageCompany {
  int id;
  int commentId;
  String url;
  DateTime createdAt;
  DateTime updatedAt;

  CommentImageCompany(
      {required this.id,
      required this.commentId,
      required this.url,
      required this.createdAt,
      required this.updatedAt});

  factory CommentImageCompany.fromJson(Map<String, dynamic> json) {
    return CommentImageCompany(
      id: json['id'],
      commentId: json['commentId'],
      url: json['url'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
