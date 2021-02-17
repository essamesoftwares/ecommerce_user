import 'package:cloud_firestore/cloud_firestore.dart';

class TodayDealsModel {
  static const ID = "id";
  static const NAME = "name";
  static const PICTURE = "picture";
  static const OLD_PRICE = "old_price";
  static const NEW_PRICE = "new_price";
  static const DISCOUNT = "discount";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const QUANTITY = "quantity";
  static const BRAND = "brand";

  String _id;
  String _name;
  String _picture;
  String _description;
  String _category;
  String _brand;
  int _quantity;
  int _oldprice;
  int _newprice;
  int _discount;

  String get id => _id;

  String get name => _name;

  String get picture => _picture;

  String get brand => _brand;

  String get category => _category;

  String get description => _description;

  int get quantity => _quantity;

  int get oldPrice => _oldprice;

  int get newPrice => _newprice;

  int get discount => _discount;


  TodayDealsModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _brand = snapshot.data()[BRAND];
    _description = snapshot.data()[DESCRIPTION] ?? " ";
    _oldprice = snapshot.data()[OLD_PRICE].floor();
    _newprice = snapshot.data()[NEW_PRICE].floor();
    _discount = snapshot.data()[DISCOUNT].floor();
    _category = snapshot.data()[CATEGORY];
    _name = snapshot.data()[NAME];
    _picture = snapshot.data()[PICTURE];
  }
}
