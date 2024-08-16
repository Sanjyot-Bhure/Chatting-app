import 'package:chatapplication/src/features/repository/auth/authontication_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProvider = StateProvider<bool>((ref) => false);

final authProviders = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState(isLoading: true));
  AuthRepository repository = AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = AuthState.loading();
    try {
      repository.loginUser(
        email: email,
        password: password,
        context: context,
      );

      // after login we can locally store the data in shredPreferences
      // first perform the action  change the state for  loading
      state = AuthState.loading();

      state = AuthState.authenticated();

      // Get.to(const HomePage());
    } catch (e) {
      state = AuthState.error(Exception(e));
    }
  }

  void logout() async {
    // await _firebaseAuthentication.logout();
    state = AuthState.unauthenticated();
  }
}

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final Exception? error;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
  });

  factory AuthState.loading() => AuthState(isLoading: true);

  factory AuthState.authenticated() => AuthState(isAuthenticated: true);

  factory AuthState.error(Exception error) => AuthState(error: error);

  factory AuthState.unauthenticated() => AuthState(isAuthenticated: false);
}

// bloc data domain layer from the server that will
// BlocProvider BlocProvider BlocListener BlocConsumer RepositoryProvider

// flutter firebase nodejs MONGODB DSA(C++) AI/ML => we have
@immutable // we cant create the instance of the abstract class
abstract class AuthStateCheck {}

class IsLoadingState extends AuthStateCheck {}
class LoadedDataState extends AuthStateCheck{}
 