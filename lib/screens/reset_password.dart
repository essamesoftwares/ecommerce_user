import 'package:ecommerce_user/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // String _email;
  // TextEditingController _email = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    String _email = userProvider.userModel.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.withOpacity(0.3),
                  elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(_email, style: TextStyle(fontSize: 18),)),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                  child: Text(
                    'Instructions:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 14),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Text(
                    '1. Before clicking the "Reset Password" button, please read the instructions and tap the checkbox. \n\n2. A sms will be sent to your email address upon pressing the "Reset Password" button. \n\n3. You can reset your password by clicking on the website link in the SMS.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                  child: Row(
                    children: [
                      Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              this._isChecked = value;
                            });
                          }),
                      Text(
                        'I have read the instructions.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    child: Text('Reset Password', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                    onPressed: () {
                        if(_isChecked == true) {
                          auth.sendPasswordResetEmail(email: _email);
                          Navigator.of(context).pop();
                        }
                        else{
                          return Fluttertoast.showToast(msg: "Please see the first instruction");
                        }
                    },
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
