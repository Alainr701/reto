import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reto_flutter_app/screens/auth/login_screen.dart';
import 'package:reto_flutter_app/services/data_base.dart';

class HomeScreen extends StatelessWidget {
  final String? uid ;

  const HomeScreen({Key? key,  this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
      body:  FutureBuilder<DocumentSnapshot>(
      future: Database().readUser(uid ?? ''),
      builder:
          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {   
        if (snapshot.hasError) {
          return const Text("Hubo un error");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Center(child: Text("Hola ${data['name']} ",style: const TextStyle(color: Colors.indigo,fontSize: 25),));
        }

        return const Center(child: CircularProgressIndicator());
      },
    )
    );
  }
}