import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_goals/config.dart';
import 'package:my_goals/model/user.dart';
import 'package:my_goals/service/secure_storage.dart';

class AuthenticationService {

  Future<void> register(String email, String username, String password) async {
    Uri url = Uri.http(Config.apiUrl, "api/auth/register");
    final body = {"email": email, "username": username, "password": password};
    final header = {"Content-Type": "application/json"};
    var response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  Future<User> login(String username, String password) async {
    Uri url = Uri.http(Config.apiUrl, "/api/auth/login");
    final body = {"username": username, "password": password};
    final header = {"Content-Type": "application/json"};
    var response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    final data = jsonDecode(response.body);
    String jwtToken = data["accessToken"];
    String name = data["username"];
    int userId = data["userId"];
    User user = User(userId: userId, username: name, token: jwtToken);
    await storeUserCredentials(username, password);
    return user;
  }

  Future<User> reLogin(User user) async {
    final credentials = await getUserCredentials();
    final username = credentials['username'];
    final password = credentials['password'];

    Uri url = Uri.http(Config.apiUrl, "/api/auth/login");
    final body = {"username": username, "password": password};
    final header = {"Content-Type": "application/json"};
    var response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception();
    }
    final data = jsonDecode(response.body);
    String jwtToken = data["accessToken"];
    user.token = jwtToken;
    return user;
  }

}
