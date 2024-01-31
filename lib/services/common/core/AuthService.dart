import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

abstract class IAuthService {
  Future<bool> isUserLoggedIn();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> signInWithGoogle();
  Future<User?> signInWithFacebook();
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<UserCredential?> register(String email, String password);
}

class AuthService implements IAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<bool> isUserLoggedIn() async {
    User? user = _auth.currentUser;
    return user != null;
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential? userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return userCredential.user;
      } else {
        return null;
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-credential') {
          return null;
        } else {
          throw 'Giriş yapılırken bir hata oluştu: ${e.message}';
        }
      }
      throw e;
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        return userCredential.user;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        return userCredential.user;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<UserCredential?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        return userCredential;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }
}
