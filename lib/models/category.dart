import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  static const ID = "id";
  static const CATEGORY = "category";
  static const IMAGE = "image";

  String _id;
  String _category;
  String _image;

  String get id => _id;
  String get category => _category;
  String get image => _image;

  CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _category = snapshot.data()[CATEGORY];
    _image = snapshot.data()[IMAGE];
  }
}
