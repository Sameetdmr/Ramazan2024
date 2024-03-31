import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';

abstract class IAuthService {
  Future<bool> isUserLoggedIn();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> signInWithGoogle();
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<UserCredential?> register(String email, String password);
}

final class AuthService implements IAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<bool> isUserLoggedIn() async {
    final user = _auth.currentUser;
    return user != null;
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
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
        if (e.code == StringCommonConstant.firebaseLoginErrorCode) {
          return null;
        } else {
          throw CustomException(StringCommonConstant.firebaseLoginError);
        }
      }
      throw CustomException(StringCommonConstant.firebaseLoginError);
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final googleSignInAccount = await GoogleSignIn().signIn();
      final googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        return userCredential.user;
      } else {
        return null;
      }
    } catch (e) {
      throw CustomException(StringCommonConstant.googleLoginError);
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
      throw CustomException(StringCommonConstant.resetPasswordError);
    }
  }

  @override
  Future<UserCredential?> register(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        return userCredential;
      } else {
        return null;
      }
    } catch (e) {
      throw CustomException(StringCommonConstant.registerError);
    }
  }
}
