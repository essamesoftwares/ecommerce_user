import 'package:ecommerce_user/models/discount_product.dart';
import 'package:ecommerce_user/services/discount_product.dart';
import 'package:flutter/material.dart';

class DiscountProductProvider with ChangeNotifier {
  DiscountProductServices _productServices = DiscountProductServices();
  List<DiscountProductModel> discountProducts = [];
  List<DiscountProductModel> productsSearched = [];

  DiscountProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    discountProducts = await _productServices.getProducts();
    notifyListeners();
  }

  Future search({String productName}) async {
    productsSearched =
    await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }
}
