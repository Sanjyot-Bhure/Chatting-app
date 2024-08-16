// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:chatapplication/src/errors/firebaseauthexception.dart';
import 'package:chatapplication/src/features/screens/home/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/auth/authmodel.dart';
import '../../services/firebase_storage.dart';

final authProvider = Provider((ref) {
  return AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });
  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('USERS').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!, userData.id);
    }
    return user;
  }

  User? get user => auth.currentUser;
  Future<bool> userExist() async {
    firestore.settings;
    return (await firestore.collection('USERS').doc(user!.uid).get()).exists;
  }

  Future<void> createUser() async {
    // String photoURL = await StorageMethod()
    //     .uploadImageToStorage('profilePic', user!.photoURL as Uint8List);
    final UserModel userModel = UserModel(
      name: user!.displayName,
      email: user!.email,
      image: 'photoURL',
      about: 'Hey, ',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      isOnline: false,
      lastActive: '',
      pushToken: '',
      // groupId: [],
    );
    firestore.collection('USERS').doc(user!.uid).set(userModel.toMap());
  }

  void resisterUser({
    required String name,
    required String email,
    required String password,
    required File file,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String photoURL =
          await StorageMethod().uploadImageToStorage('profilePic', file);
      final UserModel userModel = UserModel(
        name: name,
        email: email,
        image: photoURL,
        about: 'Hey, this is awesome ',
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        isOnline: true,
        lastActive: '',
        pushToken: '',
        // groupId: [],
      );
      firestore
          .collection('USERS')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
          (route) => false);
      // send the link for verification
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      SignUpWithEmailAndPasswordFailure.code(e.message.toString());
    }
  }

  void loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      SignUpWithEmailAndPasswordFailure.code(e.message.toString());
    }
  }

  void phoneAuthontication({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        codeSent: (String verificationId, int? resendToken) {
          // verificationID = verificationId;
          Navigator.pushNamed(
            context,
            ' OTPScreen.routeName',
            arguments: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // verificationID = verificationId;
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            debugPrint('The provided phone number is invalid');
          }
          throw Exception(e.message);
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  void verifyOTP({
    required String phoneOTP,
    required verificationId,
    required BuildContext context,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: phoneOTP,
      );
      await auth.signInWithCredential(credential).then(
        (value) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '', // userInformation screen
            (route) => false,
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  // google sign with credentials
  Future<UserCredential?> googleSign() async {
    try {
      await InternetAddress.lookup('google.com');
      // first create the instance of google sing with
      //

      GoogleSignIn googleSignIn = GoogleSignIn();
      //trigger the authontication flow
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      // obtain the auth details from the request
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      // create the credentials
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      // once signed in, return the userCredentials to firebase for auth
      final result = await auth.signInWithCredential(credential);
      return result;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
