import 'package:ecommerce_user/provider/product.dart';
import 'package:ecommerce_user/widgets/featured_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayDeals extends StatefulWidget {
  @override
  _TodayDealsState createState() => _TodayDealsState();
}

class _TodayDealsState extends State<TodayDeals> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
        height: 150,
        child: Card(
          color: Colors.pink,
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
