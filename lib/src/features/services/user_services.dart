import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth/authmodel.dart';

FirebaseAuth auth = FirebaseAuth.instance;

// for accessing cloud firestore database
FirebaseFirestore firestore = FirebaseFirestore.instance;

// for accessing firebase storage
FirebaseFirestore storage = FirebaseFirestore.instance;

User get user => auth.currentUser!;
final service = Provider((ref) => Services());

class Services {
  static User get user => auth.currentUser!;

  static Future<bool> addUser(String email) async {
    final QuerySnapshot<Map<String, dynamic>> data = await firestore
        .collection('USERS')
        .where('email', isEqualTo: email)
        .get();

    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      firestore
          .collection('USERS')
          .doc(user.uid)
          .collection('MY-USER')
          .doc(data.docs.first.id)
          .set(data.docs.first.data());

      return true;
    } else {
      return false;
    }
  }

  static Future delete(String email) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> data = await firestore
          .collection('USERS')
          .where('email', isEqualTo: email)
          .get();

      if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
        firestore
            .collection('USERS')
            .doc(user.uid)
            .collection('MY-USER')
            .doc(data.docs.first.id)
            .set(data.docs.first.data());

        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static late UserModel me;

  // for sending messages
  static Future updateUserProfile(UserModel userModel) async {
    try {
      await firestore
          .collection('USERS')
          .doc(user.uid)
          .update(userModel.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future deleteUserById({
    required String id,
  }) async {
    // print(id);
    return await firestore
        .collection('USERS')
        .doc(user.uid)
        .collection('MY-USER')
        .doc(id)
        .delete();
  }

  Future updateUserName({required String name, required String id}) async {
    return firestore
        .collection('USERS')
        .doc(user.uid)
        .collection('MY-USER')
        .doc(id)
        .update({'name': name});
  }
}

Stream<UserModel?> get userStream {
  final DocumentReference<Map<String, dynamic>> userDocRef =
      FirebaseFirestore.instance.collection('USERS').doc(user.uid);

  return userDocRef.snapshots().map((snapshot) =>
      UserModel.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id));
}

Stream<List<UserModel>> get myUsersStream {
  final CollectionReference<Map<String, dynamic>> myUsersCollectionRef =
      FirebaseFirestore.instance
          .collection('USERS')
          .doc(user.uid)
          .collection('MY-USER');

  return myUsersCollectionRef.snapshots().map((snapshot) => snapshot.docs
      .map((doc) => UserModel.fromMap(doc.data(), doc.id))
      .toList());
}
