import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final CollectionReference profileList =
  FirebaseFirestore.instance.collection('users');


  Future updateUserProfile(String name, String email, String uid) async {
    return await profileList.doc(uid).update({
      'name': name,
      'email': email,
    });
  }

  Future updateUserImage(String image, String uid) async {
    return await profileList.doc(uid).update({
      'image': image,
    });
  }
}
