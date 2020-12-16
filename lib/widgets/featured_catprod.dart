import 'package:ecommerce_user/provider/product.dart';
import 'package:ecommerce_user/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatFeatured extends StatefulWidget {
  @override
  _CatFeaturedState createState() => _CatFeaturedState();
}

class _CatFeaturedState extends State<CatFeatured> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Column(
      children: productProvider.products
          .map((item) => GestureDetector(
        child: ProductCard(
          product: item,
        ),
      ))
          .toList(),
    );
  }
}
