import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_goals/config.dart';

class AuthenticatioService {
  void register(String email, String username, String password) async {
    Uri url = Uri.http(Config.apiUrl, "/register");
    final body = {"email": email, "username": username, "password": password};
    final header = {"Content-Type": "application/json"};
    var response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<String> login(String username, String password) async {
    Uri url = Uri.http(Config.apiUrl, "/login");
    final body = {"username": username, "password": password};
    final header = {"Content-Type": "application/json"};
    var response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception();
    }
    final data = jsonDecode(response.body);
    String jwtToken = data["accesstoken"];
    return jwtToken;
  }
}
