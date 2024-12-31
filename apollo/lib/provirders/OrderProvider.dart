import 'package:apollo/entity/OrderModel.dart';
import 'package:apollo/services/orderService.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  final _service = OrderService();
  bool isLoading = false;
  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

  Future<void> getOrders(int userId) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAll(userId);
    _orders = response;
    isLoading = false;
    notifyListeners();
  }
}
