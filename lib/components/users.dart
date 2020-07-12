import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  Firestore firestore = Firestore.instance;
  String collection = "users";

  createUser(Map data) {
    firestore.collection(collection).document(data["userId"]).setData(data);
  }
}
