import 'dart:convert';

import 'package:apollo/configdata/api_address.dart';
import 'package:apollo/entity/userModel.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<UserModel?> getUser(int userId) async {
    String apiURL = '$hostAddress/api/User/GetUser?userId=$userId';
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    if (jsonString.statusCode == 200) {
      var jsonObject = jsonDecode(jsonString.body);
      var userJson = jsonObject['user'];
      client.close();
      return UserModel.fromJson(userJson);
    }
    client.close();
    return null;
  }

  Future<bool> updateProfile(int userId, UserModel user) async {
    final String apiURL =
        "$hostAddress/api/User/ChangeUserProfile/ChangeUserProfile?userId=${userId}";
    var client = http.Client();
    var jsonString = await client.post(
      Uri.parse(apiURL),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': user.email,
        'fullName': user.fullName,
        'phone': user.phone,
        'address': user.address
      }),
    );
    client.close();

    if (jsonString.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
