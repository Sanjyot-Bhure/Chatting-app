// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:io';

import 'package:chatapplication/src/components/components.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chatapplication/src/features/controller/authcontroller.dart';
import 'package:chatapplication/src/features/screens/auth/loginscreen.dart';
import 'package:chatapplication/src/utils/imagepicker.dart';
import 'package:chatapplication/src/widgets/container.dart';

import '../../../widgets/textformfield.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({
    super.key,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final fromKEY = GlobalKey<FormState>();

  final imageProvider = StateNotifierProvider((ref) => ImageProviders());
  File? image;
  void selectImage() async {
    image = await imageFromGallery();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUp = ref.watch(authControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.9),
                    Colors.white38.withOpacity(0.5),
                    // Colors.black.withOpacity(0.9),
                    // Colors.teal.withOpacity(0.9),
                    // const Color.fromARGB(255, 5, 40, 68).withOpacity(0.9),
                    // const Color.fromARGB(255, 31, 136, 222).withOpacity(0.2),
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
                height: MediaQuery.of(context).size.height * 0.70,
                width: MediaQuery.of(context).size.width * 0.97,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: fromKEY,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              image == null
                                  ? const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
                                      ),
                                      radius: 64,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: FileImage(
                                        image!,
                                      ),
                                      radius: 64,
                                    ),
                              Positioned(
                                bottom: -7,
                                left: 80,
                                child: IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormInput(
                            hintText: 'Name',
                            labelText: 'Enter your name',
                            controller: nameController,
                            obscureText: false,
                            onSaved: (val) {},
                            maxLines: 1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          TextFormInput(
                            hintText: 'email',
                            labelText: 'Enter your email address',
                            controller: emailController,
                            obscureText: false,
                            onSaved: (val) {},
                            maxLines: 1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
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
                            validator: (String? value) {
                              List<String> validation = [];
                              if (value == null || value.isEmpty) {
                                return 'This field can not be empty';
                              } else {
                                if (!value.isValidPasswordHasNumber) {
                                  validation.add('Must contain 1 Number');
                                }
                                if (!value.isValidPasswordHasCapitalLetter) {
                                  validation
                                      .add("Must contain 1 capital letter");
                                }
                                if (!value.isValidPasswordHasLowerCaseLetter) {
                                  validation
                                      .add("Must contain 1 simple letter");
                                }
                                if (!value.isValidPasswordHasSpecialCharacter) {
                                  validation.add(
                                      "Must contain 1 special character[! @ # \$ %]");
                                }
                              }
                              String msg = '';
                              if (validation.isNotEmpty) {
                                for (var i = 0; i < validation.length; i++) {
                                  msg = msg + validation[i];
                                  if ((i + 1) != validation.length) {
                                    msg = "$msg\n";
                                  }
                                }
                              }
                              if (msg.length < 8) {
                                return 'Password length should be 8 characters';
                              }
                              return msg.isNotEmpty ? msg : null;
                            },
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          TextFormInput(
                            hintText: 'confirm-password',
                            labelText: 'Enter your confirm password',
                            controller: confirmPasswordController,
                            obscureText: false,
                            onSaved: (val) {},
                            maxLines: 1,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Your confirm password';
                              }
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                return 'Provided password does not match ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'By selecting Agree and continue below',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 241, 235, 235),
                                  fontSize: 17,
                                ),
                              )),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'I agree ',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color:
                                            Color.fromARGB(255, 241, 235, 235)),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Terms & Services and Privacy Policy',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Color.fromARGB(
                                            255,
                                            9,
                                            203,
                                            115,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 224,
                            child: ElevatedButton(
                              onPressed: () {
                                if (image == null) {
                                  return;
                                }
                                if (fromKEY.currentState!.validate()) {}
                                signUp.signUp(
                                  name: nameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  image: image!,
                                  context: context,
                                );
                              },
                              child: const Text(
                                'Agree and Continue',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Already have an account?",
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color:
                                          Color.fromARGB(255, 242, 238, 238)),
                                  children: [
                                    TextSpan(
                                      text: ' Sign in',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Get.to(const LoginScreen());
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (c_) =>
                                                  const LoginScreen(),
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
            ),
          ],
        ),
      ),
    );
  }
}

