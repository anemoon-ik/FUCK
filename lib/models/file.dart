class File {
  int id;
  String file;

  File({required this.id, required this.file});

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      id: json['id'],
      file: json['file'],
    );
  }
}
