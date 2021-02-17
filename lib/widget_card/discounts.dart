import 'package:ecommerce_user/provider/discount_product.dart';
import 'package:ecommerce_user/widget_card/discount_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscountProducts extends StatefulWidget {
  @override
  _DiscountProductsState createState() => _DiscountProductsState();
}

class _DiscountProductsState extends State<DiscountProducts> {
  @override
  Widget build(BuildContext context) {
    final discountProductProvider = Provider.of<DiscountProductProvider>(context);

    return Container(
        height: 120,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: discountProductProvider.discountProducts.length,
            itemBuilder: (_, index) {
              return DiscountCard(
                discountProduct: discountProductProvider.discountProducts[index],
              );
            }));
  }
}
