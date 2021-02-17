import 'package:ecommerce_user/helpers/common.dart';
import 'package:ecommerce_user/helpers/style.dart';
import 'package:ecommerce_user/models/product.dart';
import 'package:ecommerce_user/screens/product_details.dart';
import 'package:ecommerce_user/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'loading.dart';

class RecentCard extends StatelessWidget {
  final ProductModel product;

  const RecentCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          changeScreen(
              context,
              ProductDetails(
                product: product,
              ));
        },
        child: Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(80),
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    // offset: Offset(-2, -1),
                    blurRadius: 2,
                ),
              ]),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80),
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
                      fit: BoxFit.fill,
                      height: 90,
                      width: 90,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
