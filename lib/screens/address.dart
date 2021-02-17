import 'package:ecommerce_user/models/cart_item.dart';
import 'package:ecommerce_user/provider/user.dart';
import 'package:ecommerce_user/screens/home.dart';
import 'package:ecommerce_user/screens/payment.dart';
import 'package:ecommerce_user/services/addressService.dart';
import 'package:ecommerce_user/services/order.dart';
import 'package:ecommerce_user/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController _name = TextEditingController();
  TextEditingController _mobileNo = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _landmark = TextEditingController();
  TextEditingController _pinCode = TextEditingController();
  bool isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  AddressService addressService = AddressService();
  OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Address Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Fill your address details'),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _name,
                  decoration: InputDecoration(hintText: 'Buyer name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the buyer name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _mobileNo,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the mobile number';
                    } else if (value.length > 10) {
                      return 'Please enter valid mobile number';
                    } else if (value.length < 10) {
                      return 'Please enter valid mobile number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _address,
                  decoration: InputDecoration(
                    hintText: 'Full Address',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the complete address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _landmark,
                  decoration: InputDecoration(
                    hintText: 'Landmark',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the Landmark';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _pinCode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Pin code',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the pin code';
                    } else if (value.length > 6) {
                      return 'Please enter valid pin code';
                    } else if (value.length < 6) {
                      return 'Please enter valid pin code';
                    }
                    return null;
                  },
                ),
              ),
              Text("Choose your payment option"),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 50),
                    child: FlatButton(
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      child: Text('COD / Offline Pay'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
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
                                          Text(
                                            'You will be charged ₹${userProvider.userModel.totalCartPrice} upon delivery!',
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            width: 320.0,
                                            child: RaisedButton(
                                              onPressed: () async {
                                                  setState(
                                                      () => isLoading = true);
                                                  var uuid = Uuid();
                                                  String id = uuid.v4();
                                                  _orderServices.createOrder(
                                                      userId:
                                                          userProvider.user.uid,
                                                      id: id,
                                                      buyerName: _name.text,
                                                      mobile: _mobileNo.text,
                                                      fullAddress: _address.text,
                                                      landmark: _landmark.text,
                                                      pinCode: _pinCode.text,
                                                      paymentMethod:
                                                          "COD / Offline",
                                                      description:
                                                          "Your order is created",
                                                      status: "Pending",
                                                      totalPrice: userProvider
                                                          .userModel
                                                          .totalCartPrice,
                                                      cart: userProvider
                                                          .userModel.cart);
                                                  for (CartItemModel cartItem
                                                      in userProvider
                                                          .userModel.cart) {
                                                    bool value =
                                                        await userProvider
                                                            .removeFromCart(
                                                                cartItem:
                                                                    cartItem);
                                                    if (value) {
                                                      userProvider
                                                          .reloadUserModel();
                                                      print("Item added to cart");
                                                      _key.currentState
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "Removed from Cart!")));
                                                    } else {
                                                      print(
                                                          "ITEM WAS NOT REMOVED");
                                                    }
                                                  }
                                                  _key.currentState.showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              "Order created!")));
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => HomePage()));
                                              },
                                              child: Text(
                                                "Accept",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              color: const Color(0xFF1BC0C5),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 320.0,
                                            child: RaisedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Reject",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: Colors.red),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 8),
                    child: FlatButton(
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      child: Text('Online Pay'),
                      onPressed: () {
                        validateAndUpload();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (_name != null &&
          _mobileNo != null &&
          _address != null &&
          _landmark != null &&
          _pinCode != null) {
        addressService.uploadProduct({
          "name": _name.text,
          "doorNo": _mobileNo.text,
          "address": _address.text,
          "landmark": _landmark.text,
          "pinCode": _pinCode.text,
        });
        _formKey.currentState.reset();
        setState(() => isLoading = false);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Payment()));
      } else {
        setState(() => isLoading = false);
      }
    } else {
      setState(() => isLoading = false);
    }
  }
}
