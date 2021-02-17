import 'package:ecommerce_user/models/today_deals.dart';
import 'package:ecommerce_user/services/deals_product.dart';
import 'package:flutter/material.dart';

class DealsProductProvider with ChangeNotifier {
  DealsProductServices _productServices = DealsProductServices();
  List<TodayDealsModel> dealsProducts = [];
  List<TodayDealsModel> productsSearched = [];

  DealsProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    dealsProducts = await _productServices.getProducts();
    notifyListeners();
  }

  Future search({String productName}) async {
    productsSearched =
    await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }
}
