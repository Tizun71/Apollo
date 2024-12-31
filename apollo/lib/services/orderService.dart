import 'dart:convert';

import 'package:apollo/configdata/api_address.dart';
import 'package:apollo/entity/Cart.dart';
import 'package:apollo/entity/OrderModel.dart';
import 'package:http/http.dart' as http;

class OrderService {
  ShoppingCart spc = ShoppingCart();
  Future<bool> invokeOrder(int userId, String note) async {
    final String apiURL =
        "$hostAddress/api/Order/InvokeOrder?userId=$userId&note=$note";

    final body = jsonEncode(spc.getCart().map((item) => item.toMap()).toList());
    print(body);
    var client = http.Client();
    var jsonString = await client.post(Uri.parse(apiURL),
        headers: {'Content-Type': 'application/json'}, body: body);

    if (jsonString.statusCode == 200) {
      spc.delete();
      return true;
    } else {
      return false;
    }
  }

  Future<List<OrderModel>> getAll(int userId) async {
    print(userId);
    String apiURL = '$hostAddress/api/Order/GetAllOrders?userId=$userId';
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    if (jsonString.statusCode == 200) {
      var jsonObject = jsonDecode(jsonString.body);
      var ordersListObject = jsonObject['orders'] as List;
      final orders = ordersListObject.map((e) {
        return OrderModel.fromJson(e);
      }).toList();
      return orders;
    }
    return [];
    //throw "Something went wrong";
  }
}
