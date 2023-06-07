import '../../models/client/client.dart';
import '../../models/user/User.dart';
import '../../models/user/token.dart';

class SetToken {
  final Token token;

  SetToken({required this.token});
}

class SetUser {
  final User user;

  SetUser({required this.user});
}

class SetClient {
  final Client client;

  SetClient({required this.client});
}

class Logout {}
