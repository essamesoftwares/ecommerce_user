import 'dart:async';

import 'package:ecommerce_user/models/cart_item.dart';
import 'package:ecommerce_user/models/discount_product.dart';
import 'package:ecommerce_user/models/order.dart';
import 'package:ecommerce_user/models/product.dart';
import 'package:ecommerce_user/models/today_deals.dart';
import 'package:ecommerce_user/models/user.dart';
import 'package:ecommerce_user/services/order.dart';
import 'package:ecommerce_user/services/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();

  UserModel _userModel;

//  getter
  UserModel get userModel => _userModel;

  Status get status => _status;

  User get user => _user;

  // public variables
  List<OrderModel> orders = [];

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        _userModel = await _userServices.getUserById(value.user.uid);
        notifyListeners();
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password, String image) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        print("CREATE USER");
        _userServices.createUser({
          'name': name,
          'email': email,
          'image': image,
          'uid': user.user.uid,
          'stripeId': ''
        });
        _userModel = await _userServices.getUserById(user.user.uid);
        notifyListeners();
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(User user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user.uid);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<bool> addToCart(
      {ProductModel product, String size, String color}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartItemModel> cart = _userModel.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.picture,
        "productId": product.id,
        "price": product.price,
        "quantity":1,
        "qty price": product.price,
        "size": size,
        "color": color
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
//      if(!itemExists){
      print("CART ITEMS ARE: ${cart.toString()}");
      _userServices.addToCart(userId: _user.uid, cartItem: item);
//      }

      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> addDiscountCart(
      {String size, String color,DiscountProductModel discountProduct}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartItemModel> cart = _userModel.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": discountProduct.name,
        "image": discountProduct.picture,
        "productId": discountProduct.id,
        "price": discountProduct.newPrice,
        "quantity":1,
        "qty price": discountProduct.newPrice,
        "size": size,
        "color": color
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
//      if(!itemExists){
      print("CART ITEMS ARE: ${cart.toString()}");
      _userServices.addToCart(userId: _user.uid, cartItem: item);
//      }

      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> addDealsCart(
      {String size, String color,TodayDealsModel dealsProduct}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartItemModel> cart = _userModel.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": dealsProduct.name,
        "image": dealsProduct.picture,
        "productId": dealsProduct.id,
        "price": dealsProduct.newPrice,
        "quantity":1,
        "qty price": dealsProduct.newPrice,
        "size": size,
        "color": color
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
//      if(!itemExists){
      print("CART ITEMS ARE: ${cart.toString()}");
      _userServices.addToCart(userId: _user.uid, cartItem: item);
//      }

      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  //cart page add
  Future<bool> addQuantity({CartItemModel item}) async {
    print("THE PRODUCT IS: ${item.toString()}");

    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();

      Map cartItem = {
        "id": cartItemId,
        "name": item.name,
        "image": item.image,
        "productId":item.id,
        "price": item.price,
        "quantity": item.quantity + 1,
        "qty price": item.price * (item.quantity + 1),
      };
      CartItemModel items = CartItemModel.fromMap(cartItem);
      _userServices.addToCart(userId: _user.uid, cartItem: items);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> removeQuantity({CartItemModel item}) async {
    print("THE PRODUCT IS: ${item.toString()}");

    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();

      Map cartItem = {
        "id": cartItemId,
        "name": item.name,
        "image": item.image,
        "productId":item.id,
        "price": item.price,
        "quantity": item.quantity - 1,
        "qty price": item.price * (item.quantity - 1),
      };
      CartItemModel items = CartItemModel.fromMap(cartItem);
      _userServices.addToCart(userId: _user.uid, cartItem: items);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> resetQuantity({CartItemModel item}) async {
    print("THE PRODUCT IS: ${item.toString()}");

    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();

      Map cartItem = {
        "id": cartItemId,
        "name": item.name,
        "image": item.image,
        "productId":item.id,
        "price": item.price,
        "quantity": 1,
        "qty price": item.price,
      };
      CartItemModel items = CartItemModel.fromMap(cartItem);
      _userServices.addToCart(userId: _user.uid, cartItem: items);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> removeFromCart({CartItemModel cartItem}) async {
    print("THE PRODUCT IS: ${cartItem.toString()}");

    try {
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  Future<bool> completeFromCart({CartItemModel cartItem}) async {
    print("THE PRODUCT IS: ${cartItem.toString()}");

    try {
      //_userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }
}
