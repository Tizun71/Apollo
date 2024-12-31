import 'package:apollo/entity/categoryModel.dart';
import 'package:apollo/services/categoryService.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final _service = Categoryservice();
  bool isLoading = false;
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  Future<void> getAllCategories() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAll();
    _categories = response;
    isLoading = false;
    notifyListeners();
  }
}
