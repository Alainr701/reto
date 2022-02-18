import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reto_flutter_app/screens/home_screen.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login(context,
      {required String email, required String password}) async {
    try {
       UserCredential  userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.user!.uid);
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen(uid: userCredential.user!.uid)));

      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
  
  Future<String> register (context,
      {required String name,  required String email, required String password}) async {
    try {
     UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    //  print(userCredential.user!.uid);
      DocumentReference document = _firestore.collection('usuarios').doc(userCredential.user!.uid);
       await document.set({
        'name': name,
        'email': email,
        'password': password,
      }).then((value) => print("Documento a sido creado"));
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen(uid: userCredential.user!.uid)));
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}