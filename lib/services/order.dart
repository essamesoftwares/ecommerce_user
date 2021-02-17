import 'package:ecommerce_user/models/cart_item.dart';
import 'package:ecommerce_user/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderServices {
  String collection = "orders";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createOrder(
      {String userId,
      String id,
      String buyerName,
      String mobile,
      String fullAddress,
      String landmark,
      String pinCode,
      String paymentMethod,
      String description,
      String status,
      List<CartItemModel> cart,
      int totalPrice}) {
    List<Map> convertedCart = [];

    for (CartItemModel item in cart) {
      convertedCart.add(item.toMap());
    }

    _firestore.collection(collection).doc(id).set({
      "userId": userId,
      "id": id,
      "buyer name": buyerName,
      "mobile": mobile,
      "full address": fullAddress,
      "landmark": landmark,
      "pin code": pinCode,
      "payment method": paymentMethod,
      "cart": convertedCart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId}) async => _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .get()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.docs) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });
}
