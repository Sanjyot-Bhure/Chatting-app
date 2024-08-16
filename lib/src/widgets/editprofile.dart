import 'dart:io';

import 'package:chatapplication/src/features/services/user_services.dart';
import 'package:flutter/material.dart';

import '../features/models/auth/authmodel.dart';
import 'cachednetworkimage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(),
      body: StreamBuilder(
        stream: userStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            UserModel myUsers = snapshot.data;

            TextEditingController nameController =
                TextEditingController(text: myUsers.name);
            TextEditingController emailController =
                TextEditingController(text: myUsers.email);
            TextEditingController aboutController =
                TextEditingController(text: myUsers.about);
            return Center(
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        myUsers.image != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                  myUsers.image.toString(),
                                ),
                                radius: 64,
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                  File('file'),
                                ),
                                radius: 64,
                                child: Positioned(
                                  bottom: -7,
                                  left: 80,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    // if (myUsers.image != null)
                    //   CachedNetworkIm(
                    //     height: 90,
                    //     width: 90,
                    //     imageUrl: myUsers.image.toString(),
                    //   ),
                    // Container(
                    //   height: 90,
                    //   width: 90,
                    //   decoration: const BoxDecoration(
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: const Stack(
                    //     children: [
                    //       Positioned(
                    //         bottom: 0,
                    //         right: 1,
                    //         child: Icon(
                    //           Icons.image,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const CachedNetworkIm(
                      height: 90,
                      width: 90,
                      imageUrl: '',
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.blue),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'eg. Happy Singh',
                        label: const Text(
                          'Name',
                          style: TextStyle(color: Colors.amber),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                      decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.blue),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'eg. Happy Singh',
                          label: const Text(
                            'Name',
                            style: TextStyle(color: Colors.amber),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: aboutController,
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                      decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.blue),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'eg. Happy Singh',
                          label: const Text(
                            'Name',
                            style: TextStyle(color: Colors.amber),
                          )),
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Update Profile'))
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("ERROR: ${snapshot.error}");
          } else {
            return const Text('None');
          }
        },
      ),
    );
  }
}
// flutter firebase node js mongoDB data DSA DART EXPRESS  
//