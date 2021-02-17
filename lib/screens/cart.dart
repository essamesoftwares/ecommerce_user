import 'package:ecommerce_user/helpers/style.dart';
import 'package:ecommerce_user/models/cart_item.dart';
import 'package:ecommerce_user/provider/app.dart';
import 'package:ecommerce_user/provider/user.dart';
import 'package:ecommerce_user/screens/address.dart';
import 'package:ecommerce_user/services/order.dart';
import 'package:ecommerce_user/widgets/custom_text.dart';
import 'package:ecommerce_user/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);


    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Shopping Cart"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: appProvider.isLoading
          ? Loading()
          : ListView.builder(
              itemCount: userProvider.userModel.cart.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: red.withOpacity(0.2),
                              offset: Offset(3, 2),
                              blurRadius: 30)
                        ]),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          child: Image.network(
                            userProvider.userModel.cart[index].image,
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: userProvider
                                              .userModel.cart[index].name +
                                          "\n",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 17)),
                                  TextSpan(
                                      text:
                                          "₹${userProvider.userModel.cart[index].price}\n",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 15)),
                                  TextSpan(
                                      text:
                                      "Total: ₹${userProvider.userModel.cart[index].qtyPrice}",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ]),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(icon: Icon(Icons.remove_circle_outline, color: userProvider.userModel.cart[index].quantity > 1 ? Colors.red : Colors.grey,), onPressed: () async {
                                        if(userProvider.userModel.cart[index].quantity > 1){
                                          appProvider.changeIsLoading();
                                          bool success = await userProvider.removeQuantity(
                                              item: userProvider.userModel.cart[index]) && await userProvider.removeFromCart(
                                              cartItem: userProvider
                                                  .userModel.cart[index]);
                                          _onLoading();
                                          if (success) {
                                            userProvider.reloadUserModel();
                                            print("Item removed from cart");
                                            appProvider.changeIsLoading();
                                            return;
                                          } else {
                                            appProvider.changeIsLoading();
                                          }
                                        }
                                      },),
                                      Text('${userProvider.userModel.cart[index].quantity}', style: TextStyle(fontWeight: FontWeight.bold),),
                                      IconButton(icon: Icon(Icons.add_circle_outline, color: Colors.blue,), onPressed: () async {
                                        appProvider.changeIsLoading();
                                        bool success = await userProvider.addQuantity(
                                            item: userProvider.userModel.cart[index]) && await userProvider.removeFromCart(
                                            cartItem: userProvider
                                                .userModel.cart[index]);
                                        _onLoading();
                                        if (success) {
                                          userProvider.reloadUserModel();
                                          print("Item added to cart");
                                          appProvider.changeIsLoading();
                                          return;
                                        } else {
                                          appProvider.changeIsLoading();
                                        }
                                      },),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.only(right: 10),
                                          icon: Icon(
                                            Icons.restore_outlined,
                                            color: userProvider.userModel.cart[index].quantity > 1 ? Colors.grey : Colors.white,
                                          ),
                                          onPressed: () async {
                                            if(userProvider.userModel.cart[index].quantity > 1){
                                              appProvider.changeIsLoading();
                                              bool success = await userProvider.resetQuantity(
                                                  item: userProvider.userModel.cart[index]) && await userProvider.removeFromCart(
                                                  cartItem: userProvider
                                                      .userModel.cart[index]);
                                              _onLoading();
                                              if (success) {
                                                userProvider.reloadUserModel();
                                                print("Item removed from cart");
                                                appProvider.changeIsLoading();
                                                return;
                                              } else {
                                                appProvider.changeIsLoading();
                                              }
                                            }
                                          }),
                                      IconButton(
                                        padding: EdgeInsets.only(left: 10),
                                          icon: Icon(
                                            Icons.delete,
                                            color: red,
                                          ),
                                          onPressed: () async {
                                            appProvider.changeIsLoading();
                                            bool success =
                                                await userProvider.removeFromCart(
                                                    cartItem: userProvider
                                                        .userModel.cart[index]);
                                            _onLoading();
                                            if (success) {
                                              userProvider.reloadUserModel();
                                              print("Item added to cart");
                                              _key.currentState.showSnackBar(SnackBar(
                                                  content: Text("Removed from Cart!")));
                                              appProvider.changeIsLoading();
                                              return;
                                            } else {
                                              appProvider.changeIsLoading();
                                            }
                                          }),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Total: ",
                      style: TextStyle(
                          color: grey,
                          fontSize: 22,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: "₹${userProvider.userModel.totalCartPrice}",
                      style: TextStyle(
                          color: black,
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: black),
                child: FlatButton(
                    onPressed: () {
                      if (userProvider.userModel.totalCartPrice == 0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Your cart is empty',
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        return;
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Address()));


                    },
                    child: CustomText(
                      text: "Check out",
                      size: 20,
                      color: white,
                      weight: FontWeight.normal,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Loading...", style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(milliseconds: 1400), () {
      Navigator.pop(context);
    });
  }
}
