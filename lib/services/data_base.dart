import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  CollectionReference users = FirebaseFirestore.instance.collection('usuarios');

    Future<DocumentSnapshot> readUser(String uid) async {
    return await users
        .doc(uid)
        .get();
  }
}