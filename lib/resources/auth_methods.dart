import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter_clone/models/user_model.dart' as user_model;
import 'package:instagram_flutter_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<user_model.User> getUserDetails() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(uid).get();

    user_model.User currentUser =
        user_model.User.fromJson(snapshot.data as Map<String, dynamic>);

    return currentUser;
  }

  // Sign Up User
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List imageFile}) async {
    String res = "Initialising";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          imageFile != null ||
          bio.isNotEmpty) {
        // Add Email and Password
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // User Generated Unique ID
        String uid = credential.user!.uid;
        print(uid);

        // Profile Pic URL from Storage to Firestore Database
        String profilePicUrl = await StorageMethods().uploadPicToStoarge(
            imageFile: imageFile, isPost: false, childName: 'ProfilePics');

        // User Model
        user_model.User user = user_model.User(
          username: username,
          bio: bio,
          profilePic: profilePicUrl,
          uid: credential.user!.uid,
          email: email,
          followers: [],
          following: [],
        );

        // Update Username
        _firestore.collection('users').doc(uid).set(user.toJson());

        res = "User Added Successfully";
      }
    } /* on FirebaseException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted';
      } else if (err.code == 'weak-password') {
        res = 'Password must be atleast 6 characters long';
      }
    } */
    catch (err) {
      res = err.toString();
    }

    return res;
  }

  // Login User
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Initialising Login";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = "Success";
      }
    } /*
    on FirebaseAuthException catch (err) {
      if (err.code == 'wrong-password') {
        res = "Invalid Password";
      }
      if (err.code == 'user-not-found') {
        res = "User Not Found";
      }
    } */
    catch (err) {
      res = err.toString();
    }

    return res;
  }

  // Logout User
  Future<void> logOutUser() async {
    await _auth.signOut();
  }
}
