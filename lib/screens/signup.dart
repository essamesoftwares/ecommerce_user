import 'dart:io';

import 'package:ecommerce_user/helpers/common.dart';
import 'package:ecommerce_user/helpers/style.dart';
import 'package:ecommerce_user/provider/user.dart';
import 'package:ecommerce_user/widgets/loading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  bool hidePass = true;
  File _image1;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[350],
                          blurRadius:
                              20.0, // has the effect of softening the shadow
                        )
                      ],
                    ),
                    child: Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    'images/logo.png',
                                    width: 260.0,
                                  )),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.3),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Container(
                                    width: 120,
                                    child: OutlineButton(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 2.5),
                                        onPressed: () {
                                          _selectImage(
                                            ImagePicker.pickImage(
                                                source: ImageSource.gallery),
                                          );
                                        },
                                        child: _displayChild1()),
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.3),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _name,
                                      decoration: InputDecoration(
                                          hintText: "Full name",
                                          icon: Icon(Icons.person_outline),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The name field cannot be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.2),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _email,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          hintText: "Email",
                                          icon: Icon(Icons.alternate_email),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (EmailValidator.validate("${_email.text}")){
                                          return null;
                                        }else if(value.isEmpty){
                                          return "The email field cannot be empty";
                                        }
                                        return "Please enter your valid email address";
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.3),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _password,
                                      obscureText: hidePass,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          icon: Icon(Icons.lock_outline),
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The password field cannot be empty";
                                        } else if (value.length < 6) {
                                          return "the password has to be at least 6 characters long";
                                        }
                                        return null;
                                      },
                                    ),
                                    trailing: IconButton(
                                        icon: Icon(Icons.remove_red_eye),
                                        onPressed: () {
                                          setState(() {
                                            hidePass = !hidePass;
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.black,
                                  elevation: 0.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        if (_image1 != null) {
                                          String imageUrl1;

                                          final FirebaseStorage storage = FirebaseStorage.instance;
                                          final String picture1 =
                                              "Profile${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
                                          StorageUploadTask task1 =
                                          storage.ref().child(picture1).putFile(_image1);

                                          StorageTaskSnapshot snapshot1 =
                                          await task1.onComplete.then((snapshot) => snapshot);

                                          task1.onComplete.then((snapshot3) async {
                                            imageUrl1 = await snapshot1.ref.getDownloadURL();
                                            if (!await user.signUp(_name.text,
                                                _email.text, _password.text, imageUrl1)) {
                                              _key.currentState.showSnackBar(
                                                  SnackBar(
                                                      content:
                                                      Text("Sign up failed")));
                                              return;
                                            }
                                          });

                                        }else if(_image1 == null){
                                          String imageUrl1 = "https://firebasestorage.googleapis.com/v0/b/e-commerce-6ac87.appspot.com/o/Deafult-Profile.png?alt=media&token=9caa25cf-0276-498a-a16e-230dce57dcf2";
                                          if (!await user.signUp(_name.text,
                                              _email.text, _password.text, imageUrl1)) {
                                            _key.currentState.showSnackBar(
                                                SnackBar(
                                                    content:
                                                    Text("Sign up failed")));
                                            return;
                                          }
                                        }
                                        changeScreenReplacement(
                                            context, HomePage());
                                      }
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "Sign up",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "I already have an account",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ))),
                          ],
                        )),
                  ),
                ),
              ],
            ),
    );
  }
  void _selectImage(Future<File> pickImage) async {
    File tempImg = await pickImage;
    setState(() => _image1 = tempImg);
  }
  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }
}
