import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> registerToFirebase(String? emaill,String? passwordd) async {
  var auth = FirebaseAuth.instance;

  UserCredential user = await auth.createUserWithEmailAndPassword(
    email: emaill!,
    password: passwordd!,
  );
}

Future<void> loginToFirebase(String? emaill,String? passwordd) async {
  var auth = FirebaseAuth.instance;
  UserCredential user = await auth.signInWithEmailAndPassword(
    email: emaill!,
    password: passwordd!,
  );
}
