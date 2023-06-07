import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user/token.dart';

dynamic httpGet(String endpoint, [Token? token]) async {
  Map<String, String> headers = {};

  if (token is Token) {
    headers['Authorization'] = 'Bearer ${token.access}';
  }

  try {
    var response = await http.get(Uri.parse(endpoint), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    }
  } catch (error) {
    // print(error);
  }
}

Future<Map> httpPost(String endpoint, dynamic values, [Token? token]) async {
  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  };

  if (token is Token) {
    headers['Authorization'] = 'Bearer ${token.access}';
  }

  try {
    var response = await http.post(
      Uri.parse(endpoint),
      headers: headers,
      body: values,
    );
    return json.decode(utf8.decode(response.bodyBytes));
  } catch (error) {
    // print(error);
    return {};
  }
}


Future<Map> httpPut(String endpoint, dynamic values, [Token? token]) async {
  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  };

  if (token is Token) {
    headers['Authorization'] = 'Bearer ${token.access}';
  }

  try {
    var response = await http.put(
      Uri.parse(endpoint),
      headers: headers,
      body: values,
    );
    return json.decode(utf8.decode(response.bodyBytes));
  } catch (error) {
    // print(error);
    return {};
  }
}
