// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:chatapplication/src/features/repository/auth/authontication_repo.dart';
import 'package:chatapplication/src/features/screens/home/homescreen.dart';
import 'package:chatapplication/src/features/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth/authmodel.dart';

// i want access this provider outside the scope
final authControllerProvider = Provider<AuthController>((ref) {
  final authRepository = ref.watch(authProvider);
  return AuthController(
    authRepository: authRepository,
    ref: ref,
  );
});
final userDataAuthProvider = FutureProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider);
    return authController.getUserData();
  },
);

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get authChanges => auth.authStateChanges();
  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithGoogle({
    required BuildContext context,
  }) {
    authRepository.googleSign().then(
      (user) async {
        if (user != null) {
          if ((await authRepository.userExist())) {
            // Get.offAll(const HomePage());
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          } else {
            authRepository.createUser().then(
              (value) {
                // Get.offAll(const HomePage());
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
            ).catchError(
              (e) {
                Navigator.of(context).pop();
                // Get.showSnackbar(
                //   GetSnackBar(
                //     message: e.toString(),
                //   ),
                // );
              },
            );
          }
        }
      },
    );
  }

  void signInWithPhone({
    required String phoneNumber,
    required BuildContext context,
  }) {
    authRepository.phoneAuthontication(
      phoneNumber: phoneNumber,
      context: context,
    );
  }

  void verifyOtp({
    required String verificationId,
    required String otp,
    required BuildContext context,
  }) {
    authRepository.verifyOTP(
      context: context,
      phoneOTP: otp,
      verificationId: verificationId,
    );
  }

  static TextEditingController nameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required File image,
    required BuildContext context,
  }) async {
    // if(image =='')return please select image before proceeding further
    authRepository.resisterUser(
      name: name,
      email: email,
      password: password,
      file: image,
      context: context,
    );
    // after successful sign Up store the in firebase storage
    // Api.createUser();
  }

  UserModel? userModel;
  // UserModel? _user;
  // final AuthMethods _authMethods = AuthMethods();

  // UserModel get getUser => _userModel!;
  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    authRepository.loginUser(
      email: email,
      password: password,
      context: context,
    );
    var userData =
        await firestore.collection('USERS').doc(auth.currentUser?.uid).get();
    if (userData.data() != null) {
      userModel = UserModel.fromMap(userData.data()!, userData.id);
    }
    // after login we can locally store the data in shredPreferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
      'userId',
      authRepository.auth.currentUser!.uid.toString(),
    );
    preferences.setString(
      'name',
      authRepository.auth.currentUser!.displayName.toString(),
    );
    preferences.setString(
      'email',
      authRepository.auth.currentUser!.email.toString(),
    );
    preferences.setString(
      'photoURL',
      authRepository.auth.currentUser!.photoURL.toString(),
    );
    // Get.offAll(const HomePage());
  }

  Future<void> logout() async {
    authRepository.auth.signOut();
    GoogleSignIn().signOut();
    // Get.to(const LoginScreen());
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.clear();//
  }
}

// class AuthController extends GetxController {
//   static AuthController get instance => Get.find();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   final api = Get.put(ApiServices());
//   signInWithGoogle() {
//     api.signInWithGoogle().then(
//       (user) async {
//         if (user != null) {
//           if ((await Api.userExist())) {
//             Get.offAll(const HomePage());
//           } else {
//             Api.createUser().then((value) {
//               Get.offAll(const HomePage());
//             }).catchError((e) {
//               Get.showSnackbar(
//                 GetSnackBar(
//                   message: e.toString(),
//                 ),
//               );
//             });
//           }
//         }
//       },
//     );
//   }

//   // handle signUp
//   void resisterUser({
//     required String email,
//     required String password,
//     required String name,
//     required String image,
//   }) {
//     api
//         .signUp(
//       email: email,
//       password: password,
//       name: name,
//       image: image,
//     )
//         .catchError(
//       (e) {
//         Get.showSnackbar(
//           GetSnackBar(
//             message: e.toString(),
//           ),
//         );
//       },
//     );
//   }

//   void loginUser({required String email, required String password}) {
//     api.signIn(email: email, password: password).catchError(
//       (error) {
//         Get.showSnackbar(
//           GetSnackBar(
//             message: error.toString(),
//           ),
//         );
//       },
//     );
//   }

//   // login with phone
//   Future loginWithPhone() async {
//     try {} catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }
// // ui => controller => repository => state =>UI
