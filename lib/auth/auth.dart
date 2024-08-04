import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
    Future<void> regis(String email, String password, String nama, String posyandu, String level) async {
      final user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    var uid = user.user!.uid;

    FirebaseFirestore db = FirebaseFirestore.instance;
    db
      .collection("user")
      .doc(uid)
      .set({"nama" : nama, "posyandu" : posyandu, "level" : level, "avatar" : 0});
  }
  Future<void> login(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}