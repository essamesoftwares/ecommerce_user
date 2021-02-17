import 'package:ecommerce_user/models/discount_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiscountProductServices {
  String collection = "discount products";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DiscountProductModel>> getProducts() async =>
      _firestore.collection(collection).get().then((result) {
        List<DiscountProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(DiscountProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<DiscountProductModel>> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
      List<DiscountProductModel> products = [];
      for (DocumentSnapshot product in result.docs) {
        products.add(DiscountProductModel.fromSnapshot(product));
      }
      return products;
    });
  }
}
