import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference groupsCollection = FirebaseFirestore.instance.collection("groups");

  Future savingUserData(String name, String email) async {
    return await userCollection.doc(uid).set({
      "name": name,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
    await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}