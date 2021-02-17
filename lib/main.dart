import 'package:ecommerce_user/provider/app.dart';
import 'package:ecommerce_user/provider/category.dart';
import 'package:ecommerce_user/provider/deals_product.dart';
import 'package:ecommerce_user/provider/discount_product.dart';
import 'package:ecommerce_user/provider/product.dart';
import 'package:ecommerce_user/provider/user.dart';
import 'package:ecommerce_user/screens/home.dart';
import 'package:ecommerce_user/screens/login.dart';
import 'package:ecommerce_user/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
      ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ChangeNotifierProvider.value(value: DiscountProductProvider.initialize()),
      ChangeNotifierProvider.value(value: DealsProductProvider.initialize()),
      ChangeNotifierProvider.value(value: AppProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: ScreensController(),
    ),
  ));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default:
        return Login();
    }
  }
}
