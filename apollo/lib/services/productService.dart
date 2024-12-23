import 'dart:convert';

import 'package:apollo/configdata/api_address.dart';
import 'package:apollo/entity/productModel.dart';
import 'package:http/http.dart' as http;

class Productservice {
  Future<List<ProductModel>> getProducts(
    int? page,
    int? pageSize,
    String? searchValue,
    int? categoryID,
    String? sortType,
  ) async {
    String apiURL;
    if (categoryID == null) {
      apiURL =
          '$hostAddress/api/ProductAPI/GetProduct?page=$page&pageSize=$pageSize&searchValue=$searchValue&categoryID=$categoryID&sortType=$sortType';
    }
    apiURL = apiURL =
        '$hostAddress/api/ProductAPI/GetProduct?page=$page&pageSize=$pageSize&searchValue=$searchValue&sortType=$sortType';

    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    if (jsonString.statusCode == 200) {
      var jsonObject = jsonDecode(jsonString.body);
      var productsListObject = jsonObject['products'] as List;
      final products = productsListObject.map((e) {
        return ProductModel.fromJson(e);
      }).toList();
      return products;
    }
    return [];
  }
}
