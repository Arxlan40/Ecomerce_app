import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataRetrive {
  // Firestore firestore = Firestore.instance;
  String collections = "users";
  //static const ID = name;
  String uname;

  getUserData() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    final DocumentReference documentReference =
        Firestore.instance.collection(collections).document(firebaseUser.uid);
  }
}
