import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> createUser(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return 'true';
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return 'true';
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<void> logoutUser() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {}
  }
}
