import 'package:ecommerce_user/helpers/common.dart';
import 'package:ecommerce_user/helpers/style.dart';
import 'package:ecommerce_user/provider/user.dart';
import 'package:ecommerce_user/widgets/featured_catprod.dart';
import 'package:ecommerce_user/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_user/screens/order.dart';

class CatProducts extends StatefulWidget {
  @override
  _CatProductsState createState() => _CatProductsState();
}

class _CatProductsState extends State<CatProducts> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Products",
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
        child: Card(
          color: Colors.deepPurple,
          child: ListView(
            children: <Widget>[
              CatFeatured(),
            ],
          ),
        ),
      ),
    );
  }
}
