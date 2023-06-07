import 'package:hive/hive.dart';
import 'package:besmart_traveler/api_service/services/user_service.dart';

class Token {
  String access;
  String refresh;

  Token({required this.access, required this.refresh});

  static Future<Token?> isAuth() async {
    final box = await Hive.openBox('user');
    var access = await box.get('access');
    var refresh = await box.get('refresh');
    if (access is String && refresh is String) {
      return await ApiUser.refreshToken(refresh);
    }
    return null;
  }

  static Future<Token> setToken(String refresh, String access) async {
    final box = await Hive.openBox('user');
    await box.put("access", access);
    await box.put("refresh", refresh);
    await box.close();
    return Token(access: access, refresh: refresh);
  }

  static Future<bool> removeToken() async {
    final box = await Hive.openBox('user');
    await box.delete("access");
    await box.delete("refresh");
    await box.close();
    return true;
  }
}
