import 'package:firebase_auth/firebase_auth.dart';

Future<void> registerToFirebase(String? Email,String? Paswword) async {
  var auth = FirebaseAuth.instance;

  UserCredential user = await auth.createUserWithEmailAndPassword(
    email: Email!,
    password: Paswword!,
  );
}

Future<void> loginToFirebase(String? emaill,String? passwordd) async {
  var auth = FirebaseAuth.instance;
  UserCredential user = await auth.signInWithEmailAndPassword(
    email: emaill!,
    password: passwordd!,
  );
}
