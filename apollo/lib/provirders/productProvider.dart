import 'package:apollo/entity/productModel.dart';
import 'package:apollo/services/productService.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final _service = Productservice();
  bool isLoading = false;
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> getProducts(int? page, int? pageSize, String? searchValue,
      int? categoryID, String? sortType) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getProducts(
        page, pageSize, searchValue, categoryID, sortType);
    _products = response;
    isLoading = false;
    notifyListeners();
  }
}
