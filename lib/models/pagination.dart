class Pagination {
  int count;
  String? next;
  String? previous;
  List<dynamic> results;

  Pagination({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  factory Pagination.fromJson(Map json, dynamic model) {

    return Pagination(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: json['results'].map((json) {
        return model(json);
      }).toList(),
    );
  }
}
