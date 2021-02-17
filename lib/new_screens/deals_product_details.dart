import 'package:ecommerce_user/helpers/common.dart';
import 'package:ecommerce_user/helpers/style.dart';
import 'package:ecommerce_user/models/today_deals.dart';
import 'package:ecommerce_user/provider/app.dart';
import 'package:ecommerce_user/provider/user.dart';
import 'package:ecommerce_user/screens/cart.dart';
import 'package:ecommerce_user/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class DealsProductDetails extends StatefulWidget {
  final TodayDealsModel dealsProduct;

  const DealsProductDetails({Key key, this.dealsProduct}) : super(key: key);

  @override
  _DealsProductDetailsState createState() => _DealsProductDetailsState();
}

class _DealsProductDetailsState extends State<DealsProductDetails> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      body: SafeArea(
          child: Container(
            color: Colors.black.withOpacity(0.9),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Loading(),
                        )),
                    Center(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.dealsProduct.picture,
                        fit: BoxFit.fill,
                        height: 400,
                        width: double.infinity,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            // Box decoration takes a gradient
                            gradient: LinearGradient(
                              // Where the linear gradient begins and ends
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              // Add one stop for each color. Stops should increase from 0 to 1
                              colors: [
                                // Colors are easy thanks to Flutter's Colors class.
                                Colors.black.withOpacity(0.7),
                                Colors.black.withOpacity(0.5),
                                Colors.black.withOpacity(0.07),
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
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                            // Box decoration takes a gradient
                            gradient: LinearGradient(
                              // Where the linear gradient begins and ends
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              // Add one stop for each color. Stops should increase from 0 to 1
                              colors: [
                                // Colors are easy thanks to Flutter's Colors class.
                                Colors.black.withOpacity(0.8),
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.4),
                                Colors.black.withOpacity(0.07),
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
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 260),
                        child: Stack(children: [Image.asset('images/offer.png', height: 100,fit: BoxFit.cover,),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 18),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Today Only\n',
                                      style: TextStyle(
                                          fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white)),
                                  TextSpan(
                                      text: '${((widget.dealsProduct.oldPrice-widget.dealsProduct.newPrice)*100~/widget.dealsProduct.oldPrice).toInt()}%\n',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                  TextSpan(
                                      text: 'offer',
                                      style: TextStyle(
                                          fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),

                                ])),
                          )
                        ]),
                      ),
                    ),

                    Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  widget.dealsProduct.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '₹${widget.dealsProduct.oldPrice}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.white,fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          decoration: TextDecoration.lineThrough, decorationThickness: 3, decorationColor: Colors.red),
                                    ),
                                    Text(
                                      '₹${widget.dealsProduct.newPrice}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                      right: 0,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            changeScreen(context, CartScreen());
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.shopping_cart),
                                ),
                              )),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            print("CLICKED");
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: red,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(35))),
                            child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(2, 5),
                              blurRadius: 10)
                        ]),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text(
                                'Description:\nAll kinds of goods are available in such a store. A customer coming to a departmental store can buy all that he wants and need not go to any other shop. ',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9),
                          child: Material(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: () async {
                                  appProvider.changeIsLoading();
                                  bool success = await userProvider.addDealsCart(
                                    dealsProduct: widget.dealsProduct,
                                    // color: _color,
                                    // size: _size,
                                  );
                                  if (success) {
                                    _key.currentState.showSnackBar(
                                        SnackBar(content: Text("Added to Cart!")));
                                    userProvider.reloadUserModel();
                                    appProvider.changeIsLoading();
                                    return;
                                  } else {
                                    _key.currentState.showSnackBar(SnackBar(
                                        content: Text("Not added to Cart!")));
                                    appProvider.changeIsLoading();
                                    return;
                                  }
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: appProvider.isLoading
                                    ? Loading()
                                    : Text(
                                  "Add to cart",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
