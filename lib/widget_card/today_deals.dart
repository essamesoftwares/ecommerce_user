import 'package:ecommerce_user/provider/deals_product.dart';
import 'package:ecommerce_user/widget_card/deals_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayDeals extends StatefulWidget {
  @override
  _TodayDealsState createState() => _TodayDealsState();
}

class _TodayDealsState extends State<TodayDeals> {
  @override
  Widget build(BuildContext context) {
    final dealsProductProvider = Provider.of<DealsProductProvider>(context);

    return Container(
        height: 120,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dealsProductProvider.dealsProducts.length,
            itemBuilder: (_, index) {
              return DealsCard(
                dealsProduct: dealsProductProvider.dealsProducts[index],
              );
            }));
  }
}
