import 'package:ecommerce_user/provider/user.dart';
import 'package:ecommerce_user/screens/edit_image.dart';
import 'package:ecommerce_user/screens/forgot_password.dart';
import 'package:ecommerce_user/screens/profile_image.dart';
import 'package:ecommerce_user/screens/reset_password.dart';
import 'package:ecommerce_user/services/profile.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();


  updateData(String name, String email, String userID) async {
    await ProfileService().updateUserProfile(name, email, userID);
  }


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          child: GestureDetector(
                              onTap: (){
                                return showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      actions: [
                                        FlatButton(onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullScreenImage()));
                                        }, child: Text("View Image")),
                                        FlatButton(onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditImage()));
                                        }, child: Text("Edit Image"))
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Image.network(userProvider.userModel.image)),
                        ),
                        ListTile(
                          title: Text(userProvider.userModel.name),
                          trailing: IconButton(icon: Icon(Icons.edit), color: Colors.red,onPressed: (){
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Edit Username'),
                                    content: Container(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: _nameController,
                                            decoration: InputDecoration(hintText: 'Name'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          if(_nameController.text.isEmpty){
                                            Fluttertoast.showToast(msg: 'Please enter valid name');
                                          }else {
                                            updateData(_nameController.text, userProvider.userModel.email, userProvider.userModel.id);
                                            _nameController.clear();
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(msg: 'You can see the change you have made by restarting your application');
                                          }
                                        },
                                        child: Text('Submit'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      )
                                    ],
                                  );
                                });
                          },),
                        ),
                        ListTile(
                          title: Text(userProvider.userModel.email),
                          trailing: IconButton(icon: Icon(Icons.edit), color: Colors.red,onPressed: (){
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Edit email'),
                                    content: Container(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: _emailController,
                                            decoration: InputDecoration(hintText: 'email'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          if(EmailValidator.validate('${_emailController.text}')){
                                            updateData(userProvider.userModel.name, _emailController.text, userProvider.userModel.id);
                                            _emailController.clear();
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(msg: 'You can see the change you have made by restarting your application');
                                          }else{
                                            Fluttertoast.showToast(msg: 'Please enter valid email');
                                          }
                                        },
                                        child: Text('Submit'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      )
                                    ],
                                  );
                                });
                          },),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black,
                              elevation: 0.0,
                              child: MaterialButton(
                                  onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => ResetPassword())),
                                minWidth:
                                MediaQuery.of(context).size.width,
                                child: Text(
                                  "Edit/Reset Password",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              )),
                        ),
                      ],
                    ),
                  );
                })));
  }
}
