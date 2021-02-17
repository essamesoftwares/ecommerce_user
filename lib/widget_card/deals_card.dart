import 'package:ecommerce_user/helpers/common.dart';
import 'package:ecommerce_user/models/today_deals.dart';
import 'package:ecommerce_user/new_screens/deals_product_details.dart';
import 'package:ecommerce_user/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class DealsCard extends StatelessWidget {
  final TodayDealsModel dealsProduct;

  const DealsCard({Key key, this.dealsProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          changeScreen(
              context,
              DealsProductDetails(
                dealsProduct: dealsProduct,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(62, 168, 174, 201),
                offset: Offset(0, 9),
                blurRadius: 14,
              ),
            ],
          ),
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
                    image: dealsProduct.picture,
                    fit: BoxFit.fill,
                    height: 120,
                    width: 130,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 70,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container())),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 84, top: 4),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.yellow,
                          border: Border.all(color: Colors.black, width: 2)
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '${((dealsProduct.oldPrice-dealsProduct.newPrice)*100~/dealsProduct.oldPrice).toInt()}%\n',
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red)),
                                TextSpan(
                                    text: 'offer',
                                    style: TextStyle(
                                        fontSize: 10, fontWeight: FontWeight.bold, color: Colors.red)),

                              ]))),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${dealsProduct.name} \n',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '₹${dealsProduct.oldPrice}',
                                style: TextStyle(
                                    fontSize: 15,decoration: TextDecoration.lineThrough, decorationThickness: 3.5, decorationColor: Colors.red, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: '\t₹${dealsProduct.newPrice}',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold)),
                          ]))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
