import 'package:ecommerce_user/helpers/common.dart';
import 'package:ecommerce_user/helpers/style.dart';
import 'package:ecommerce_user/new_screens/deals_product_details.dart';
import 'package:ecommerce_user/new_screens/discount_product_details.dart';
import 'package:ecommerce_user/provider/deals_product.dart';
import 'package:ecommerce_user/provider/discount_product.dart';
import 'package:ecommerce_user/provider/product.dart';
import 'package:ecommerce_user/screens/cart.dart';
import 'package:ecommerce_user/screens/product_details.dart';
import 'package:ecommerce_user/widget_card/deals_search.dart';
import 'package:ecommerce_user/widget_card/discount_search.dart';
import 'package:ecommerce_user/widgets/custom_text.dart';
import 'package:ecommerce_user/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final discountProductProvider = Provider.of<DiscountProductProvider>(context);
    final dealsProductProvider = Provider.of<DealsProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: CustomText(
          text: "Products",
          size: 20,
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
            changeScreen(context, CartScreen());
          })
        ],
      ),
      body: productProvider.productsSearched.length < 1
          ? discountProductProvider.productsSearched.length < 1 ?
          dealsProductProvider.productsSearched.length < 1 ?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: grey,
                    size: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                    text: "No products Found",
                    color: grey,
                    weight: FontWeight.w300,
                    size: 22,
                  ),
                ],
              )
            ],
          ) : ListView.builder(
              itemCount: dealsProductProvider.productsSearched.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async {
                      changeScreen(
                          context,
                          DealsProductDetails(
                              dealsProduct:
                              dealsProductProvider.productsSearched[index]));
                    },
                    child: DealsSearch(
                        dealsProduct: dealsProductProvider.productsSearched[index]));
              })
       : ListView.builder(
          itemCount: discountProductProvider.productsSearched.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () async {
                  changeScreen(
                      context,
                      DiscountProductDetails(
                          discountProduct:
                          discountProductProvider.productsSearched[index]));
                },
                child: DiscountSearch(
                    discountProduct: discountProductProvider.productsSearched[index]));
          })
          : ListView.builder(
              itemCount: productProvider.productsSearched.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async {
                      changeScreen(
                          context,
                          ProductDetails(
                              product:
                                  productProvider.productsSearched[index]));
                    },
                    child: ProductCard(
                        product: productProvider.productsSearched[index]));
              }),
    );
  }
}
