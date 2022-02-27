import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/users.dart';
import 'package:instagram_clone/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // For Getting Users Details
  Future<CustomUser> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    print('Current Id: ${currentUser.uid}\n');
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    print('SnapShot Data: ${snap.data()}');
    return CustomUser.fromSnap(snap);
  }

  //Sign Up User
  Future<String> signUpUser({
    required String email,
    required String password,
    required String bio,
    required String username,
    required Uint8List file,
  }) async {
    String res = 'Some Error Occured';
    try {
      // Checking User Not Empty Field
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          username.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //Getting & Uploading Url From Firebase Storage
        String imageUrl = await StorageMethods()
            .uploadImageToStorage('ProfilePics', file, false);
        // Adding rest data to firebase database
        CustomUser user = CustomUser(
          username: username,
          uid: cred.user!.uid,
          imageUrl: imageUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = 'Success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  } // Ending Of SignUp User

  //Log In User
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some Error Occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'Success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  } // Ending Of logIn User
}
