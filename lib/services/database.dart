import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBase {
  DataBase();
  DataBase.addUser({User user, String name}) {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      // Call the user's CollectionReference to add a new user
      users
          .doc(user.uid)
          .set({
            'username': name, // John Doe
            'id': user.uid, // Stokes and Sons
            'email': user.email, // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      print(e);
    }
  }
}
