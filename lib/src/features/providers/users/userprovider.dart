import 'package:chatapplication/src/features/services/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/auth/authontication_repo.dart';
// state n

final sharedPreferences = FutureProvider((ref) async {
  return await SharedPreferences.getInstance();
});
final userStreamProvider = StreamProvider((ref) => userStream);
final myUserProvider = StreamProvider((ref) => myUsersStream);
final nameProvider = StateProvider<String>((ref) => '');
final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final authProvider = Provider((ref) {
  return AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

