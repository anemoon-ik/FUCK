import '../../models/pagination.dart';

class SetPgn {
  final String name;
  final Pagination pgn;

  SetPgn({
    required this.name,
    required this.pgn,
  });
}


class UpdatePgn {
  final String name;
  final Pagination pgn;

  UpdatePgn({
    required this.name,
    required this.pgn,
  });
}
