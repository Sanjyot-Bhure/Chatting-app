import 'package:chatapplication/src/features/screens/home/pages/add_user_page.dart';
import 'package:chatapplication/src/features/screens/home/pages/call_page.dart';
import 'package:chatapplication/src/features/screens/home/pages/group_page.dart';
import 'package:chatapplication/src/features/screens/home/pages/profile_page.dart';
import 'package:chatapplication/src/utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../helpers/page_index.dart';
import '../../../widgets/textformfield.dart';
import '../../services/user_services.dart';
import 'pages/home_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = 'home-screen';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var currentIndex = 0;
  final TextEditingController emailController = TextEditingController();
  void onItemTapped(int index) {
    setState(
      () {
        currentIndex = index; //
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final changeBottomIndex = ref.watch(changeIndexNotifier);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          useLegacyColorScheme: false,
          currentIndex: changeBottomIndex.currentIndex,
          selectedItemColor:
              changeBottomIndex.currentIndex == 2 ? Colors.orange : Colors.blue,
          unselectedItemColor: Colors.white,
          iconSize: 30,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
          backgroundColor: const Color.fromARGB(115, 43, 18, 18),
          onTap: (int index) {
            ref.read(changeIndexNotifier).changeIndex(index);
            setState(() {
              currentIndex = index;
              if (currentIndex == 2) {
                showModalSheet();
              }
            });
          },
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              label: 'Chat',
              backgroundColor: Colors.black,
              icon: Icon(CupertinoIcons.chat_bubble_text_fill),
            ),
            const BottomNavigationBarItem(
                label: 'Group', icon: Icon(Icons.group)
                // backgroundColor: Colors.lightBlue,
                ),
            BottomNavigationBarItem(
              label: 'Add One',
              icon: Container(
                height: 35,
                width: 54,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  CupertinoIcons.add,
                ),
              ),
              // backgroundColor: Colors.transparent,d
            ),
            const BottomNavigationBarItem(
              label: 'Call',
              icon: Icon(CupertinoIcons.phone),
              // backgroundColor: Colors.lightBlue,
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: CircleAvatar(
                maxRadius: 19,
                backgroundImage:
                    NetworkImage(auth.currentUser!.photoURL.toString()),
              ),
              // backgroundColor: Colors.lightBlue,
            ),
          ],
        ),
        body: IndexedStack(
          index: changeBottomIndex.currentIndex,
          children: const [
            HomePage(),
            GroupPage(),
            AddPage(),
            CallPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }

  void showModalSheet() {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        enableDrag: false,
        builder: (builder) {
          return Container(
            height: 800.0,
            color: Colors.green,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 19,
                  ),
                  TextFormInput(
                    hintText: 'Enter the user Email',
                    labelText: 'Add user',
                    controller: emailController,
                    obscureText: false,
                    onSaved: (val) {},
                    maxLines: 1,
                    validator: (String? value) {
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (emailController.text.isNotEmpty) {
                        Services.addUser(emailController.text.trim())
                            .then((value) {
                          if (!value) {
                            showSnackBar(
                              context,
                              'User does not found in the database please send the link to join ',
                            );
                          } else {
                            showSnackBar(
                              context,
                              'Added successfully',
                            );
                          }
                        });
                      }
                    },
                    child: const Text('Add user'),
                  )
                ],
              ),
            ),
          );
        });
  }
}
/* */
// StreamBuilder(
//   stream: userStream,
//   builder: (BuildContext context, AsyncSnapshot userSnapshot) {
//     if (userSnapshot.hasData) {
//       return Column(
//         children: [
//           StreamBuilder(
//             stream: myUsersStream,
//             builder: (BuildContext context,
//                 AsyncSnapshot<List<UserModel>> myUsersSnapshot) {
//               if (myUsersSnapshot.hasData) {
//                 final myUsers = myUsersSnapshot.data!
//                     .map((doc) => UserModel.fromMap(doc.toMap()))
//                     .toList();
//                 return SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 7, vertical: 7),
//                         child: Text(
//                           'RECENT UPDATE',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 7,
//                       ),
//                       Row(
//                         children: [
//                           Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 4),
//                                 child: Stack(
//                                   children: [
//                                     Container(
//                                       height: 60,
//                                       width: 60,
//                                       decoration: const BoxDecoration(
//                                         color: Colors.red,
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                     Positioned(
//                                       bottom: 0,
//                                       right: 0,
//                                       child: Container(
//                                         padding:
//                                             const EdgeInsets.all(5),
//                                         decoration: const BoxDecoration(
//                                             color: Colors.blue,
//                                             shape: BoxShape.circle),
//                                         child: const Text(
//                                           "+",
//                                           style: TextStyle(
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Text(
//                                 'jack',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               const SizedBox(
//                                 height: 7,
//                               ),
//                             ],
//                           ),
//                           Expanded(
//                             child: SizedBox(
//                               // color: Colors.orangeAccent,/
//                               height: 79,
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: 10,
//                                 scrollDirection: Axis.horizontal,
//                                 itemBuilder:
//                                     (BuildContext context, int index) {
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 1.7),
//                                     child: SizedBox(
//                                       height: 70,
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                             height: 60,
//                                             width: 60,
//                                             decoration:
//                                                 const BoxDecoration(
//                                               color: Colors.blue,
//                                               shape: BoxShape.circle,
//                                             ),
//                                           ),
//                                           const Text(
//                                             'jack',
//                                             style: TextStyle(
//                                                 color: Colors.white),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 2,
//                       ),
//                       ListView.builder(
//                         itemCount: myUsers.length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         scrollDirection: Axis.vertical,
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           final user = myUsers[index];
//                           return Padding(
//                             padding: const EdgeInsets.all(3),
//                             child: Container(
//                               // height: 50,
//                               width: 50,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: const Color.fromARGB(
//                                     255, 30, 48, 51),
//                               ),
//                               child: ListTile(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (_) =>
//                                           ChatScreen(user: user),
//                                     ),
//                                   );
//                                 },
//                                 minVerticalPadding: 9,
//                                 horizontalTitleGap: 4,
//                                 minLeadingWidth: 9,
//                                 visualDensity:
//                                     const VisualDensity(vertical: -0.2),
//                                 contentPadding:
//                                     const EdgeInsets.symmetric(
//                                         horizontal: 4),
//                                 title: Text(
//                                   user.name.toString(),
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                                 leading: InkWell(
//                                     onTap: () {
//                                       showDialog(
//                                         context: context,
//                                         builder:
//                                             (BuildContext context) {
//                                           return Center(
//                                               child: Material(
//                                             type: MaterialType
//                                                 .transparency,
//                                             child: Container(
//                                                 decoration:
//                                                     BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius
//                                                           .circular(10),
//                                                   color: Colors.white,
//                                                 ),
//                                                 padding:
//                                                     const EdgeInsets
//                                                         .all(15),
//                                                 height: 320,
//                                                 width: MediaQuery.of(
//                                                             context)
//                                                         .size
//                                                         .width *
//                                                     0.7,
//                                                 child: Column(
//                                                   children: [
//                                                     GlobalContainer(
//                                                       width:
//                                                           MediaQuery.of(
//                                                                   context)
//                                                               .size
//                                                               .width,
//                                                       height: 40,
//                                                       child: Center(
//                                                         child: Text(
//                                                           user.name
//                                                               .toString(),
//                                                           style: const TextStyle(
//                                                               color: Colors
//                                                                   .amber,
//                                                               fontSize:
//                                                                   22,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w700),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Hero(
//                                                       tag: 'person1',
//                                                       child: Container(
//                                                         width: MediaQuery.of(
//                                                                 context)
//                                                             .size
//                                                             .width,
//                                                         color: Colors
//                                                             .black,
//                                                         child: Image
//                                                             .network(
//                                                           user.image
//                                                               .toString(),
//                                                           // width: MediaQuery.of(context).size.width,
//                                                           // height: 200,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     // CircleAvatar(
//                                                     //   maxRadius: 120,
//                                                     //   backgroundColor:
//                                                     //       Colors.amber,
//                                                     //   foregroundImage:
//                                                     //       NetworkImage(
//                                                     //     user.image
//                                                     //         .toString(),
//                                                     //   ),
//                                                     // ),
//                                                   ],
//                                                 )),
//                                           ));
//                                         },
//                                       );
//                                     },
//                                     child: Hero(
//                                       tag: 'person1',
//                                       child: CircleAvatar(
//                                         maxRadius: 39,
//                                         backgroundImage: NetworkImage(
//                                           user.image.toString(),
//                                         ),
//                                       ),
//                                     )),
//                                 subtitle: Text(
//                                   user.about.toString(),
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(
//                                           255, 182, 177, 177)),
//                                 ),
//                                 trailing: Container(
//                                   height: 9,
//                                   width: 9,
//                                   margin: const EdgeInsets.all(7),
//                                   color: Colors.green,
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       )
//                     ],
//                   ),
//                 );
//                 // return ListView.builder(
//                 //   itemCount: myUsers.length,
//                 //   shrinkWrap: true,
//                 //   scrollDirection: Axis.vertical,
//                 //   itemBuilder: (context, index) {
//                 //     final user = myUsers[index];
//                 //     print(user.name);
//                 //     return ListTile(
//                 //       title: Text(
//                 //         user.name.toString(),
//                 //         style: const TextStyle(color: Colors.amber),
//                 //       ),
//                 //       subtitle: Text(
//                 //         user.email.toString(),
//                 //         style: const TextStyle(color: Colors.amber),
//                 //       ),
//                 //     );
//                 //   },
//                 // );
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             },
//           ),
//         ],
//       );
//     } else {
//       return const Center(
//         child: Text('No Users FOUND'),
//       );
//     }
//   },
// ),

 