import 'package:ecommerce_user/models/today_deals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DealsProductServices {
  String collection = "today deals";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TodayDealsModel>> getProducts() async =>
      _firestore.collection(collection).get().then((result) {
        List<TodayDealsModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(TodayDealsModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<TodayDealsModel>> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((result) {
      List<TodayDealsModel> products = [];
      for (DocumentSnapshot product in result.docs) {
        products.add(TodayDealsModel.fromSnapshot(product));
      }
      return products;
    });
  }
}
