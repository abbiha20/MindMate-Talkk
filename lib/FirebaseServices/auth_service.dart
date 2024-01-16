import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User, UserCredential;
import 'package:flutter/foundation.dart';

class FirebaseServices{ //new class

  final FirebaseAuth _auth = FirebaseAuth.instance; //instance of firebase authentication

  Future<User?>signUpMethod(String email, String password) async{ // created new user

    try{
      UserCredential credential =
      await _auth.createUserWithEmailAndPassword( //created user with email and password
          email: email,
          password: password);

      return credential.user; //return the user.

  }catch(e){

      if (kDebugMode) {
        print("Failed to Signup user");
      }
    }
    return null;
}

  Future<User?>signInMethod(String email, String password) async{

    try{
      UserCredential credential =
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password);

      return credential.user;

    }catch(e){

      if (kDebugMode) {
        print("Failed to Signup user");
      }
    }
    return null;
  }
}