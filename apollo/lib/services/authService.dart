import 'dart:convert';

import 'package:apollo/configdata/api_address.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    final String apiURL = "$hostAddress/api/User/Login";
    var client = http.Client();
    var jsonString = await client.post(
      Uri.parse(apiURL),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userName': username, 'password': password}),
    );

    if (jsonString.statusCode == 200) {
      var data = jsonDecode(jsonString.body);
      String token = data['data']['accessToken'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}
