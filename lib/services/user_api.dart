import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rest_api_app/models/users.dart';

class UserApi {
  static Future<List<Users>> fetchApi() async {
    const url = 'https://randomuser.me/api/?results=50';
    final uri = Uri.parse(url);
    final reponse = await http.get(uri);
    final json = jsonDecode(reponse.body);
    final res = json['results'] as List<dynamic>;
    final users = res.map((e) {
      return Users.formJson(e);
    }).toList();
    return users;
  }
}
