import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../../models/client/client.dart';
import '../../models/client/family_status.dart';
import '../../models/client/work_status.dart';
import '../../models/pagination.dart';
import '../../models/user/token.dart';
import '../methods.dart';
import '../urls.dart';

class ApiClient {
  static Future<Client> getClientInfo(Token? token) async {
    var body = await httpGet(Urls.baseApiUrl + Urls.clientProfile, token);
    return Client.fromJson(body);
  }

  static disableProfile(Token token) async {
    var response = await http.delete(
      Uri.parse(Urls.baseApiUrl + Urls.clientProfile),
      headers: {'Authorization': 'Bearer ${token.access}'},
    );

    if (response.statusCode == 200) {
      final body = json.decode(utf8.decode(response.bodyBytes));
      return body.containsKey('status') ? body['status'] == 'deleted' : 'Error';
    }
  }

  static removeProfileImage(Token token) async {
    var response = await http.delete(
      Uri.parse(Urls.baseApiUrl + Urls.profileImage),
      headers: {'Authorization': 'Bearer ${token.access}'},
    );

    if (response.statusCode == 200) {
      final body = json.decode(utf8.decode(response.bodyBytes));
      return body.containsKey('profile_image')
          ? body['profile_image']
          : 'Error';
    }
  }

  static Future<String> changeProfileImage(
      PlatformFile platformFile, String accessToken) async {
    final request = http.MultipartRequest(
      'PUT',
      Uri.parse(Urls.baseApiUrl + Urls.profileImage),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $accessToken',
    });

    List<int> fileBytes = await File(platformFile.path!).readAsBytes();

    request.files.add(
      http.MultipartFile.fromBytes(
        'profile_image',
        fileBytes,
        filename: platformFile.name,
      ),
    );

    final response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      final responseString = await response.stream.bytesToString();
      final body = jsonDecode(responseString);
      if (body.containsKey('profile_image') &&
          body['profile_image'] is String) {
        return body['profile_image'];
      }

      if (body.containsKey('profile_image') && body['profile_image'] is List) {
        return body['profile_image'][0];
      }
    }

    return 'Error';
  }

  static Future<dynamic> registerPhone(Map values) async {
    var response = await httpPost(
      Urls.baseApiUrl + Urls.registerPhone,
      values,
    );
    return response;
  }

  static Future<dynamic> verifyPhone(Map values) async {
    var response = await httpPost(
      Urls.baseApiUrl + Urls.verifyPhone,
      values,
    );
    return response;
  }

  static Future<Pagination> getWorkStatus() async {
    var body = await httpGet(Urls.baseApiUrl + Urls.workStatus);
    return body == null
        ? Pagination(count: 0, results: [])
        : Pagination.fromJson(body, (json) => WorkStatus.fromJson(json));
  }

  static Future<Pagination> getFamilyStatus() async {
    var body = await httpGet(Urls.baseApiUrl + Urls.familyStatus);
    return body == null
        ? Pagination(count: 0, results: [])
        : Pagination.fromJson(body, (json) => FamilyStatus.fromJson(json));
  }

  static Future<Pagination?> getProfileImage(Token? token) async {
    var body = await httpGet(Urls.baseApiUrl + Urls.profileImage);
    return body;
  }
}
