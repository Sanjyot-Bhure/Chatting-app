// ignore_for_file: use_build_context_synchronously

import 'package:chatapplication/src/features/screens/auth/signupscreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../widgets/container.dart';
import '../../../widgets/textformfield.dart';
import '../../controller/authcontroller.dart';
// import 'package:get/get.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 1, end: -1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final login = ref.watch(authControllerProvider);
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  // image: const DecorationImage(
                  //     image: AssetImage(
                  //       'assets/images/bg.jpg',
                  //     ),
                  //     fit: BoxFit.cover),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.teal.withOpacity(0.9),
                      const Color.fromARGB(25, 5, 40, 68).withOpacity(0.9),
                      const Color.fromARGB(255, 31, 136, 222).withOpacity(0.9),
                    ],
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                  ),
                  boxShadow: const [
                    BoxShadow(color: Colors.black),
                    BoxShadow(color: Colors.teal),
                  ],
                ),
              ),
              Center(
                child: GlobalContainer(
                  height: MediaQuery.of(context).size.height * 0.50,
                  // height: 40,
                  width: MediaQuery.of(context).size.width * 0.97,

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 9,
                          ),
                          TextFormInput(
                            hintText: 'email',
                            labelText: 'Enter your email address',
                            controller: emailController,
                            obscureText: false,
                            onSaved: (String? value) {},
                            maxLines: 1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your email  .";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          TextFormInput(
                            hintText: 'password',
                            labelText: 'Enter your password',
                            controller: passwordController,
                            obscureText: false,
                            onSaved: (val) {},
                            maxLines: 1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Your Password.";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Forgot password ',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(
                                      255,
                                      9,
                                      203,
                                      115,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: InkWell(
                              onTap: () {
                                login.login(
                                  context: context,
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(9)),
                                height: 50,
                                child: const Text(
                                  'Log in',
                                  style: TextStyle(
                                    // color: Color.fromARGB(255, 238, 241, 242),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.95,
                          //   child: Consumer(
                          //     builder: (context, ref, child) {
                          //       final authState = ref.watch(authProviders);
                          //       final authNotifier =
                          //           ref.watch(authProviders.notifier);
                          //       return InkWell(
                          //         // onTap: () {
                          //         //   // authController.signInWithGoogle();
                          //         //   // authController.handleGoogleBtnClick();
                          //         //   if (key.currentState!.validate()) {}
                          //         // },
                          //         onTap: () {
                          //           authState.isLoading
                          //               ? null
                          //               : authNotifier.login(
                          //                   context: context,
                          //                   email: emailController.text.trim(),
                          //                   password:
                          //                       passwordController.text.trim(),
                          //                 );
                          //         },
                          //         child: authState.isLoading
                          //             ? const CircularProgressIndicator()
                          //             : Container(
                          //                 alignment: Alignment.center,
                          //                 color: Colors.green,
                          //                 height: 50,
                          //                 child: const Text(
                          //                   'Log in',
                          //                   style: TextStyle(
                          //                     // color: Color.fromARGB(255, 238, 241, 242),
                          //                     fontSize: 20,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ),
                          //       );
                          //     },
                          //   ),
                          // ),
                          // const SizedBox(height: 10),
                          const Text(
                            'OR',
                            style: TextStyle(
                              color: Color.fromARGB(255, 242, 238, 238),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: InkWell(
                              onTap: () {
                                // authController.signInWithGoogle();
                                login.signInWithGoogle(context: context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(9)),
                                height: 50,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.google,
                                    ),
                                    SizedBox(
                                      width: 9,
                                    ),
                                    Text(
                                      'Continue with Google',
                                      style: TextStyle(
                                        // color: Color.fromARGB(255, 238, 241, 242),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account?",
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color:
                                          Color.fromARGB(255, 242, 238, 238)),
                                  children: [
                                    TextSpan(
                                      text: ' Sign Up',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Get.to(SignUpScreen());
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpScreen(),
                                            ),
                                          );
                                        },
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Color.fromARGB(
                                          255,
                                          9,
                                          203,
                                          115,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// 