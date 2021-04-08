// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sn/domain/user.dart';

// class AuthService {
//   final FirebaseAuth _fAuth = FirebaseAuth.instance;

//   Future signInWithEmailAndPassword(String email, String password) async {
//     try {
//       // AuthResult result = await _fAuth.signInWithEmailAndPassword(
//       //     email: email, password: password);
//       // FirebaseUser user = result.user;
//       // return InitialUser.fromFB(user);
//     } catch (e) {
//       return null;
//     }
//   }

//   Future registerWithEmailAndPassword(String email, String password) async {
//     try {
//       // AuthResult result = await _fAuth.createUserWithEmailAndPassword(
//       // email: email, password: password);
//       // FirebaseUser user = result.user;
//       // return InitialUser.fromFB(user);
//     } catch (e) {
//       return null;
//     }
//   }

//   Stream<InitialUser> get currentUser {
//     // return _fAuth.onAuthStateChanged.map((FirebaseUser user) {
//     //   print(user);
//     //   if (user != null) {
//     //     print('sssssssssssss');
//     //     return InitialUser.fromFB(user);
//     //   } else {
//     //     print('noen');
//     //     return null;
//     //   }
//     // });
//   }

//   Future logOut() async {
//     await _fAuth.signOut();
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _fAuth;
  AuthService(this._fAuth);

  Stream<User> get authStateChanges => _fAuth.authStateChanges();

  Future<String> signIn({String email, String password}) async {
    try {
      await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      return 'Sign in';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Sign up';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
