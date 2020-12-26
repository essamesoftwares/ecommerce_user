import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final CollectionReference profileList =
  Firestore.instance.collection('users');


  Future updateUserProfile(String name, String email, String uid) async {
    return await profileList.document(uid).updateData({
      'name': name,
      'email': email,
    });
  }

  Future updateUserImage(String image, String uid) async {
    return await profileList.document(uid).updateData({
      'image': image,
    });
  }
}
