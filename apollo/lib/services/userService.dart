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
      return UserModel.fromJson(userJson);
    }
    return null;
  }
}
