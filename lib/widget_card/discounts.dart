import 'package:ecommerce_user/provider/product.dart';
import 'package:ecommerce_user/widgets/featured_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscountProducts extends StatefulWidget {
  @override
  _DiscountProductsState createState() => _DiscountProductsState();
}

class _DiscountProductsState extends State<DiscountProducts> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
        height: 150,
        child: Card(
          color: Colors.green,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productProvider.products.length,
              itemBuilder: (_, index) {
                return FeaturedCard(
                  product: productProvider.products[index],
                );
              }),
        ));
  }
}
