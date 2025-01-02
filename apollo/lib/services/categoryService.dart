import 'dart:convert';

import 'package:apollo/entity/categoryModel.dart';
import 'package:apollo/configdata/api_address.dart';
import 'package:http/http.dart' as http;

class Categoryservice {
  Future<List<CategoryModel>> getAll() async {
    String apiURL = '$hostAddress/api/CategoryAPI/GetAll';
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    if (jsonString.statusCode == 200) {
      var jsonObject = jsonDecode(jsonString.body);
      var categoriesListObject = jsonObject['categories'] as List;
      final categories = categoriesListObject.map((e) {
        return CategoryModel.fromJson(e);
      }).toList();
      client.close();
      return categories;
    }
    client.close();
    return [];
    //throw "Something went wrong";
  }
}
