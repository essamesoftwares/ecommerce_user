
import 'package:ecommerce_user/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullScreenImage extends StatefulWidget {
  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return new Scaffold(
      body: new Image.network(
        userProvider.userModel.image,
        fit: BoxFit.fitWidth,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}



