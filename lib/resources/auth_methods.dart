import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagramclone/models/user_model.dart' as model;
import 'package:instagramclone/resources/storage_merthods.dart';

import '../models/user_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.UserModel> getUserDetails() async {
    //Firebase User not Model
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.UserModel.fromSnap(documentSnapshot);
  }

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
          bio.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        debugPrint(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);
        //add user to database
        model.UserModel user = model.UserModel(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );
        await _firestore.collection("users").doc(cred.user!.uid).set(
              user.toJson(),
            );
        // 'username': username,
        // 'uid': cred.user!.uid,
        // 'email': email,
        // 'bio': bio,
        // 'followers': [],
        // 'following': [],
        // 'photoUrl': photoUrl,
        //}
        //);

        // await _firestore.collection('users').add({
        //here firebae generate random doc id own its own in firebase database
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });
        res = "success";
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = 'The email is badly foratted.';
    //   }else if(err.code == 'weak-password'){
    //     res = 'Password should be at least 6 characters.';
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  //loging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    }
    //  on FirebaseAuthException catch (err) {
    //   if (err.code == 'wrong-password') {

    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }
}
