import 'package:apollo/entity/product2.dart';
import 'package:dio/dio.dart';

class ApiService {
  static Future<List<Product2>> getAllProducts() async {
    var dio = Dio();
    var response = await dio.request(
      'https://fakestoreapi.com/products',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> rs = response.data;
      var lsProduct = rs.map((e) => Product2.fromJson(e)).toList();
      return lsProduct;
    } else {
      throw new Exception(
          "Lỗi lấy dữ liệu. Chi tiết: ${response.statusMessage}");
    }
  }
}
