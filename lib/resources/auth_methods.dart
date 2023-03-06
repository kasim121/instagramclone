import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty
         
          ) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        debugPrint(cred.user!.uid);
        //add user to database
        //  await  _firestore.collection("users").doc(cred.user!.uid).set({
        //     'username': username,
        //     'uid': cred.user!.uid,
        //     'email': email,
        //     'bio': bio,
        //     'followers': [],
        //     'following': [],
        //   });

        await _firestore.collection('users').add({
          //here firebae generate random doc id own its own in firebase database
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
        });
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}