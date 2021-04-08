import 'package:firebase_auth/firebase_auth.dart';

class InitialUser {
  String id;

  InitialUser.fromFB(FirebaseUser user) {
    id = user.uid;
  }
}
