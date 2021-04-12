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
import 'package:sn/services/database.dart';

class AuthService {
  final FirebaseAuth _fAuth;
  AuthService(this._fAuth);

  Stream<User> get authStateChanges => _fAuth.authStateChanges();

  Future<String> signOut() async {
    _fAuth.signOut();
    return 'SignOut';
  }

  Future<User> signIn({String email, String password}) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  Future<User> signUp({String email, String password, String name}) async {
    try {
      User user;
      await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = await _fAuth.currentUser;
      await user.reload();
      user = await _fAuth.currentUser;
      await user.updateProfile(displayName: name);
      await user.reload();
      print('HERE HERE HERE HERE HERE HERE ');
      print(user);

      DataBase.addUser(user: user, name: name);
      return user;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }
}
