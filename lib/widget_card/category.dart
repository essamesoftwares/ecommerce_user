import 'package:ecommerce_user/provider/category.dart';
import 'package:ecommerce_user/widget_card/category_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Container(
        height: 160,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: ScrollPhysics(),
            itemCount: categoryProvider.category.length,
            itemBuilder: (_, index) {
              return CategoryCard(
                category: categoryProvider.category[index],
              );
            }));
  }
}
