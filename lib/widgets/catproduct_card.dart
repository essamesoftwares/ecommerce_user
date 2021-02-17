import 'package:ecommerce_user/helpers/common.dart';
import 'package:ecommerce_user/helpers/style.dart';
import 'package:ecommerce_user/models/product.dart';
import 'package:ecommerce_user/provider/app.dart';
import 'package:ecommerce_user/provider/user.dart';
import 'package:ecommerce_user/screens/product_details.dart';
import 'package:ecommerce_user/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'loading.dart';

class CategoryCard extends StatelessWidget {
  final ProductModel product;

  const CategoryCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
      child: GestureDetector(
        onTap: () {
          changeScreen(
              context,
              ProductDetails(
                product: product,
              ));
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        // offset: Offset(-2, -1),
                        blurRadius: 2),
                  ]),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 2, bottom: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: Loading(),
                          )),
                          Center(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: product.picture,
                              fit: BoxFit.cover,
                              height: 80,
                              width: 80,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: '${product.name} \n',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: '₹${product.price}',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ], style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child:
                        MaterialButton(
                          child: Text('Add', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      color: Colors.blue,
                      onPressed: () async {
                        appProvider.changeIsLoading();
                        bool success = await userProvider.addToCart(
                          product: product,
                        );
                        if (success) {
                          Fluttertoast.showToast(
                              msg: "Added to Cart!",
                              textColor: Colors.white,
                              backgroundColor: Colors.black);
                          userProvider.reloadUserModel();
                          appProvider.changeIsLoading();
                          return;
                        } else {
                          Fluttertoast.showToast(
                              msg: "Not added to Cart!",
                              textColor: Colors.white,
                              backgroundColor: Colors.black);
                          appProvider.changeIsLoading();
                          return;
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
