import 'package:ecommerce_user/provider/app.dart';
import 'package:ecommerce_user/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final razorpay = Razorpay();
  double finalValue;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paySuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, payError);
    super.initState();
  }

  void paySuccess(PaymentSuccessResponse response) {
    print('successfully paid');
    print(response.paymentId.toString());
  }

  void payError(PaymentFailureResponse response) {
    print('failed');
    print(response.message + response.code.toString());
  }

  void externalWallet(ExternalWalletResponse response) {
    print('externalwallet');
    print(response.walletName);
  }

  getPayment() {
    final userProvider = Provider.of<UserProvider>(context);
    double total = userProvider.userModel.totalCartPrice / 100;
    var option = {
      'key': 'rzp_test_q6393U5x52Qfbn',
      'amount': total,
      'name': 'sample',
      //'order_id': '${controller.text.trim()}',
      'prefill': {'contact': '1234567890', 'email': 'sample@gmail.com'},
    };

    try {
      razorpay.open(option);
    } catch (e) {
      print('error is $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    double finalValue = userProvider.userModel.totalCartPrice / 100;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("$finalValue"),
          RaisedButton(child: Text('pay'), onPressed: () => getPayment()),
        ],
      ),
    );
  }
}
