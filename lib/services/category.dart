import 'package:ecommerce_user/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryServices {
  String collection = "categories";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategory() async =>
      _firestore.collection(collection).get().then((result) {
        List<CategoryModel> category = [];
        for (DocumentSnapshot product in result.docs) {
          category.add(CategoryModel.fromSnapshot(product));
        }
        return category;
      });

  // Future<List<ProductModel>> searchProducts({String productName}) {
  //   // code to convert the first character to uppercase
  //   String searchKey = productName[0].toUpperCase() + productName.substring(1);
  //   return _firestore
  //       .collection(collection)
  //       .orderBy("name")
  //       .startAt([searchKey])
  //       .endAt([searchKey + '\uf8ff'])
  //       .get()
  //       .then((result) {
  //     List<ProductModel> products = [];
  //     for (DocumentSnapshot product in result.docs) {
  //       products.add(ProductModel.fromSnapshot(product));
  //     }
  //     return products;
  //   });
  // }
}
