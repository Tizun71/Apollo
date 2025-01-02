import 'dart:convert';

import 'package:apollo/configdata/api_address.dart';
import 'package:apollo/entity/userModel.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    final String apiURL = "$hostAddress/api/User/Vaildate/Login";
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
      client.close();
      return true;
    } else {
      client.close();
      return false;
    }
  }

  Future<bool> register(UserModel user, String password) async {
    final String apiURL =
        "$hostAddress/api/User/Register/RegisterAccount?username=${user.username}&fullname=${user.fullName}&password=${password}&email=${user.email}&phone=${user.phone}&address=${user.address}";
    var client = http.Client();
    var jsonString = await client.post(
      Uri.parse(apiURL),
      headers: {'Content-Type': 'application/json'},
    );

    if (jsonString.statusCode == 200) {
      client.close();
      return true;
    } else {
      client.close();
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

  Future<int?> getUserIdFromToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (token == null || JwtDecoder.isExpired(token)) {
      return null;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    int? userId = decodedToken['Id'] != null
        ? int.tryParse(decodedToken['Id'].toString())
        : null;
    return userId;
  }
}
