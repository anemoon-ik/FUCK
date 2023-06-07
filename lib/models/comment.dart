class CommentLocation {
  int id;
  String text;
  int client;
  int location;

  CommentLocation({
    required this.id,
    required this.text,
    required this.client,
    required this.location,
  });

  factory CommentLocation.fromJson(Map<String, dynamic> json) {
    return CommentLocation(
      id: json['id'],
      text: json['text'],
      client: json['client'],
      location: json['location'],
    );
  }
}

class CommentCompany {
  int id;
  String text;
  int client;
  int company;

  CommentCompany({
    required this.id,
    required this.text,
    required this.client,
    required this.company,
  });

  factory CommentCompany.fromJson(Map<String, dynamic> json) {
    return CommentCompany(
      id: json['id'],
      text: json['text'],
      client: json['client'],
      company: json['company'],
    );
  }
}

class CommentTrip {
  int id;
  String text;
  int client;
  int trip;

  CommentTrip({
    required this.id,
    required this.text,
    required this.client,
    required this.trip,
  });

  factory CommentTrip.fromJson(Map<String, dynamic> json) {
    return CommentTrip(
      id: json['id'],
      text: json['text'],
      client: json['client'],
      trip: json['trip'],
    );
  }
}
