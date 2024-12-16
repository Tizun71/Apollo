import 'package:apollo/entity/category.dart';
import 'package:apollo/enums/api_address.dart';
import 'package:dio/dio.dart';

class CategoryService {
  static Future<List<Category2>> getAllCategories() async {
    var dio = Dio();
    var response = await dio.request(
      hostAddress + '/api/CategoryAPI',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> rs = response.data;
      var lsCategories = rs.map((e) => Category2.fromJson(e)).toList();
      return lsCategories;
    } else {
      throw new Exception(
          "Lỗi lấy dữ liệu. Chi tiết: ${response.statusMessage}");
    }
  }
}
