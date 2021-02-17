import 'package:ecommerce_user/helpers/common.dart';
import 'package:ecommerce_user/helpers/style.dart';
import 'package:ecommerce_user/models/today_deals.dart';
import 'package:ecommerce_user/new_screens/deals_product_details.dart';
import 'package:ecommerce_user/provider/app.dart';
import 'package:ecommerce_user/provider/user.dart';
import 'package:ecommerce_user/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';


class DealsSearch extends StatelessWidget {
  final TodayDealsModel dealsProduct;

  const DealsSearch({Key key, this.dealsProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          changeScreen(
              context,
              DealsProductDetails(
                dealsProduct: dealsProduct,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 5),
              ]),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 65, top: 4),
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
                      text: '${dealsProduct.name} \n',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: '₹${dealsProduct.oldPrice}\n',
                      style: TextStyle(fontSize: 16, color: Colors.black, decoration: TextDecoration.lineThrough, decorationThickness: 2.5),
                    ),
                    TextSpan(
                      text: '₹${dealsProduct.newPrice} \t',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ], style: TextStyle(color: Colors.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: MaterialButton(
                  child: Text(
                    'Add',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.blue,
                  onPressed: () async {
                    appProvider.changeIsLoading();
                      bool success = await userProvider.addDealsCart(
                        dealsProduct: dealsProduct,
                    );
                    if (success) {
                      Fluttertoast.showToast(msg: "Added to Cart!",
                          textColor: Colors.white,
                          backgroundColor: Colors.black);
                      userProvider.reloadUserModel();
                      appProvider.changeIsLoading();
                      return;
                    } else {
                      Fluttertoast.showToast(msg: "Not added to Cart!",
                          textColor: Colors.white,
                          backgroundColor: Colors.black);
                      appProvider.changeIsLoading();
                      return;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
