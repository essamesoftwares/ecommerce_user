import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerce_user/helpers/common.dart';
import 'package:ecommerce_user/helpers/style.dart';
import 'package:ecommerce_user/provider/product.dart';
import 'package:ecommerce_user/provider/user.dart';
import 'package:ecommerce_user/screens/product_search.dart';
import 'package:ecommerce_user/screens/profile.dart';
import 'package:ecommerce_user/services/product.dart';
import 'package:ecommerce_user/widget_card/discounts.dart';
import 'package:ecommerce_user/widget_card/today_deals.dart';
import 'package:ecommerce_user/widgets/categories.dart';
import 'package:ecommerce_user/widgets/custom_text.dart';
import 'package:ecommerce_user/widgets/featured_products.dart';
import 'package:ecommerce_user/widgets/product_card.dart';
import 'package:ecommerce_user/widgets/recent_card.dart';
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

  List<String> suggestion = [
    "Boost",
    "Tomato",
    "Carrot",
    "Good Day",
    "Horlicks",
    "Lemon",
    "Potato",
    "Oreo",
    "Tinda",
    "Cabbage",
    "Pumbkin",
    "Marie gold",
    "Parle-G",
    "Bournvita",
    "Beetroot",
    "Cucumber",
    "Garlic",
    "50-50",];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

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
                        fontSize: 20,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),


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
                    title: SimpleAutoCompleteTextField(
                      key: key,
                      suggestions: suggestion,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.search,
                      textSubmitted: (pattern) async {
                        await productProvider.search(productName: pattern);
                        changeScreen(context, ProductSearchScreen());
                      },
                      decoration: InputDecoration(
                        hintText: "Vegitable, Biscuit...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 180.0,
              width: 300.0,
              child: Carousel(
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 700),
                indicatorBgPadding: 1.0,
                dotSize: 3,
                dotBgColor: Colors.grey[400],
                dotPosition: DotPosition.bottomCenter,
                dotIncreasedColor: Colors.black,
                images: [
                  AssetImage('images/banner1.png'),
                  AssetImage('images/banner3.jpg'),
                  AssetImage('images/banner2.png'),
                  AssetImage('images/banner4.png'),
                  AssetImage('images/banner5.jpg'),
                  AssetImage('images/banner6.png'),
                ],
              ),
            ),
            //categories
            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
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
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
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
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Discount products',style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 17),)),
                ),
              ],
            ),
            DiscountProducts(),

            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Today Deals', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),)),
                ),
              ],
            ),
            TodayDeals(),

//          recent products
            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Recent products', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 17),)),
                ),
              ],
            ),

            Container(
              height: 240,
              child: GridView.count(
                crossAxisCount: 3,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: productProvider.products
                    .map((item) => GestureDetector(
                          child: Card(
                            color: Colors.cyan,
                            child: RecentCard(
                              product: item,
                            ),
                          ),
                        ))
                    .toList(),
              ),
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
