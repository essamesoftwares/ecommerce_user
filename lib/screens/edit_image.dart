import 'dart:io';

import 'package:ecommerce_user/provider/user.dart';
import 'package:ecommerce_user/services/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditImage extends StatefulWidget {
  @override
  _EditImageState createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  File _image1;

  updateData(String image, String userID) async {
    await ProfileService().updateUserImage(image, userID);
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
          "Edit Profile Image",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Container(
                      width: 120,
                      child: OutlineButton(
                          borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 2.5),
                          onPressed: () {
                            _selectImage(
                              ImagePicker.pickImage(source: ImageSource.gallery),
                            );
                          },
                          child: _displayChild1()),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () async {
                    if (_image1 != null) {
                      String imageUrl1;

                      final FirebaseStorage storage = FirebaseStorage.instance;
                      final String picture1 =
                          "ProfileEdit${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
                      StorageUploadTask task1 =
                          storage.ref().child(picture1).putFile(_image1);

                      StorageTaskSnapshot snapshot1 =
                          await task1.onComplete.then((snapshot) => snapshot);

                      task1.onComplete.then((snapshot3) async {
                        imageUrl1 = await snapshot1.ref.getDownloadURL();
                        updateData(imageUrl1, userProvider.userModel.id);
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg:
                            'You can see the change you have made by restarting your application');
                      });
                    }
                    else{
                      return Fluttertoast.showToast(
                          msg:
                          'Please select your profile image');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
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
