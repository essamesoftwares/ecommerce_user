import 'package:ecommerce_user/models/category.dart';
import 'package:ecommerce_user/services/category.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> category = [];
  List<CategoryModel> productsSearched = [];

  CategoryProvider.initialize() {
    loadCategory();
  }

  loadCategory() async {
    category = await _categoryServices.getCategory();
    notifyListeners();
  }

  // Future search({String productName}) async {
  //   productsSearched =
  //   await _productServices.searchProducts(productName: productName);
  //   notifyListeners();
  // }
}
