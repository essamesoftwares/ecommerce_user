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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    int amt = userProvider.userModel.totalCartPrice;
    var option = {
      'key': 'rzp_test_q6393U5x52Qfbn',
      'amount': amt * 100,
      // 'name': 'sample',
      // //'order_id': '${controller.text.trim()}',
      // 'prefill': {'contact': '1234567890', 'email': 'sample@gmail.com'},
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Colors.grey, Colors.blue],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                "₹${userProvider.userModel.totalCartPrice}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 100,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => getPayment(),
                child: Container(
                  //margin: EdgeInsets.only(bottom: 350),
                  height: 70,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Icon(
                                Icons.payment_outlined,
                                color: Colors.white60,
                              )),
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black26,
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Proceed to pay",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
