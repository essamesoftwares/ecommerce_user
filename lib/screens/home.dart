import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerce_user/helpers/common.dart';
import 'package:ecommerce_user/helpers/style.dart';
import 'package:ecommerce_user/provider/product.dart';
import 'package:ecommerce_user/provider/user.dart';
import 'package:ecommerce_user/screens/product_search.dart';
import 'package:ecommerce_user/screens/profile.dart';
import 'package:ecommerce_user/services/product.dart';
import 'package:ecommerce_user/widgets/categories.dart';
import 'package:ecommerce_user/widgets/custom_text.dart';
import 'package:ecommerce_user/widgets/featured_products.dart';
import 'package:ecommerce_user/widgets/product_card.dart';
import 'package:ecommerce_user/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import 'cart.dart';
import 'order.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();
  ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "Grocery Shop",
          style: TextStyle(color: Colors.white),
        ),
      ),
      key: _key,
      backgroundColor: white,
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: black),
              accountName: CustomText(
                text: userProvider.userModel?.name ?? "username lading...",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: userProvider.userModel?.email ?? "email loading...",
                color: white,
              ),
            ),
            ListTile(
              onTap: () async {
                await userProvider.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My orders"),
            ),
            ListTile(
              onTap: () {
                userProvider.signOut();
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
//           Custom App bar
            Stack(
              children: <Widget>[
                // Positioned(
                //   top: 10,
                //   right: 20,
                //   child: Align(
                //       alignment: Alignment.topRight,
                //       child: GestureDetector(
                //           onTap: () {
                //             _key.currentState.openEndDrawer();
                //           },
                //           child: Icon(Icons.menu))),
                // ),
                Positioned(
                  top: 10,
                  right: 20,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            changeScreen(context, CartScreen());
                          },
                          child: Icon(Icons.shopping_cart))),
                ),
                Positioned(
                  top: 10,
                  right: 60,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()));
                          },
                          child: Icon(Icons.person))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'What are\nyou Shopping for?',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),

//          Search Text field
//            Search(),

            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.grey[100], Colors.white])),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 8, right: 8, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: black,
                    ),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern) async {
                        await productProvider.search(productName: pattern);
                        changeScreen(context, ProductSearchScreen());
                      },
                      decoration: InputDecoration(
                        hintText: "vegitable, Biscuit...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 150.0,
              width: 300.0,
              child: Carousel(
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 700),
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.bottomCenter,
                dotIncreasedColor: Colors.red,
                images: [
                  AssetImage('images/banner1.png'),
                  AssetImage('images/banner2.png'),
                ],
              ),
            ),
            //categories
            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Categories',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))),
                ),
              ],
            ),
            Categories(),

//            featured products
          SizedBox(height: 15,),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Featured products', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 17),)),
                ),
              ],
            ),
            FeaturedProducts(),

            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Discount products',style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 17),)),
                ),
              ],
            ),
            FeaturedProducts(),

            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Today Deals', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),)),
                ),
              ],
            ),
            FeaturedProducts(),

//          recent products
            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Recent products', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 17),)),
                ),
              ],
            ),

            Column(
              children: productProvider.products
                  .map((item) => GestureDetector(
                        child: Card(
                          color: Colors.blueAccent,
                          child: ProductCard(
                            product: item,
                          ),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
//Row(
//mainAxisAlignment: MainAxisAlignment.end,
//children: <Widget>[
//GestureDetector(
//onTap: (){
//key.currentState.openDrawer();
//},
//child: Icon(Icons.menu))
//],
//),
