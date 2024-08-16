//  static Stream removeUser() async* {
//     CollectionReference collectionRef =
//         FirebaseFirestore.instance.collection('parentCollection');

//     QuerySnapshot parentCollectionSnapshot = await collectionRef.get();
//     for (DocumentSnapshot parentDocument in parentCollectionSnapshot.docs) {
//       CollectionReference nestedCollectionRef = FirebaseFirestore.instance
//           .collection('parentCollection/${parentDocument.id}/nestedCollection');

//       QuerySnapshot nestedCollectionSnapshot = await nestedCollectionRef.get();

//       // Add the data to your model
//     }
//     yield collectionRef.snapshots();
//   }

// StreamBuilder(
//           stream:,
//           builder: (BuildContext context, snapshot) {
//               final user = snapshot.data!.id;
//               print(user);
//             switch (snapshot.connectionState) {

//               case ConnectionState.waiting:
//               case ConnectionState.none:
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );

//               default:
//                 if (snapshot.hasData) {
//                   print(snapshot.data!.docs.length);
//                   if (snapshot.data!.docs.isEmpty) {
//                     return const Center(
//                       child: Text('No record Available'),
//                     );
//                   } else {
//                     // print(snapshot.data!.docs.length);
//                     ListView.builder(
//                         scrollDirection: Axis.vertical,
//                         itemCount: snapshot.data!.docs.length,
//                         itemBuilder: (context, index) {
//                           final id = snapshot.data!.docs[index].id;
//                           print(id);
//                           return StreamBuilder<QuerySnapshot>(
//                             stream: FirebaseFirestore.instance
//                                 .collection('USERS')
//                                 .doc(id)
//                                 .collection('my-user')
//                                 .snapshots(),
//                             builder:
//                                 (context, AsyncSnapshot<QuerySnapshot> snap) {
//                               switch (snap.connectionState) {
//                                 //               //if data is loading
//                                 case ConnectionState.waiting:
//                                 case ConnectionState.none:
//                                   return const Center(
//                                       child: CircularProgressIndicator());

//                                 case ConnectionState.active:
//                                 case ConnectionState.done:
//                                   print(id);
//                                   if (list.isNotEmpty) {
//                                     return ListView.builder(
//                                         itemCount: list.length,
//                                         itemBuilder: (context, index) {
//                                           print("${list[index].email} kac ");
//                                           return const ListTile(
//                                             title: Text(
//                                               'jack',
//                                               style: TextStyle(
//                                                   color: Colors.green),
//                                             ),
//                                           );
//                                         });
//                                   } else {
//                                     return const Center(
//                                       child: Text(
//                                         'no data',
//                                         style: TextStyle(color: Colors.green),
//                                       ),
//                                     );
//                                   }
//                               }
//                             },
//                           );
//                         });
//                   }
//                 } else {
//                   return const Center(
//                     child: Text(
//                       'Something wrong',
//                       style: TextStyle(color: Colors.green),
//                     ),
//                   );
//                 }
//             }
//             return const Text('something wrong');
//           },
//         )

// // /
// // if (snapshot.hasData) {
// //                       return ListView(
// //                         children: snapshot.data!.docs.map(
// //                           (DocumentSnapshot documents) {
// //                             Map<String, dynamic> data =
// //                                 documents.data() as Map<String, dynamic>;

// //                             return ListTile(
// //                               title: Text(
// //                                 data['email'],
// //                                 style: const TextStyle(color: Colors.green),
// //                               ),
// //                             );
// //                           },
// //                         ).toList(),
// //                       );
// //                     }

// //                     if (!snapshot.hasData) {
// //                       return const Center(
// //                         child: CircularProgressIndicator(),
// //                       );
// //                     }

// //                     return const Center(
// //                       child: CircularProgressIndicator(),
// //                     );
// //                   },

//    // body: StreamBuilder(
//           //   stream: Services.getMyUserID(),
//           //   // stream: Services.getUserStream(auth.currentUser!.uid),
//           //   // the particular user will show which exit in my database
//           //   builder: (context, snapshot) {
//           //     // final data = snapshot.data!.docs;
//           //     // print(data.length);
//           //     switch (snapshot.connectionState) {
//           //       case ConnectionState.waiting:
//           //       case ConnectionState.none:
//           //         return const Center(
//           //           child: CircularProgressIndicator(),
//           //         );
//           //       case ConnectionState.active:
//           //       case ConnectionState.done:
//           //         return StreamBuilder<QuerySnapshot<Object>>(
//           //           stream: Services.getAllUsers(

//           //           ),
//           //           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           //             switch (snapshot.connectionState) {
//           //               //if data is loading
//           //               case ConnectionState.waiting:
//           //               case ConnectionState.none:
//           //               // return const Center(
//           //               //     child: CircularProgressIndicator());

//           //               //if some or all data is loaded then show it
//           //               case ConnectionState.active:
//           //               case ConnectionState.done:
//           //                 final data = snapshot.data!.docs;
//           //                 // print(data.length);
//           //                 // list = data
//           //                 //         .map((e) => UserModel.fromJson(
//           //                 //             e.data() as Map<String, dynamic>))
//           //                 //         .toList() ??
//           //                 //     [];
//           //                 print(data.length);
//           //                 if (list.isNotEmpty) {
//           //                   return ListView.builder(
//           //                       itemCount: list.length,
//           //                       itemBuilder: (context, index) {
//           //                         print("${list[index].email} kac ");
//           //                         return const ListTile(
//           //                           title: Text(
//           //                             'jack',
//           //                             style: TextStyle(color: Colors.green),
//           //                           ),
//           //                         );
//           //                       });
//           //                 } else {
//           //                   return const Center(
//           //                     child: Text(
//           //                       'no data',
//           //                       style: TextStyle(color: Colors.green),
//           //                     ),
//           //                   );
//           //                 }
//           //             }
//           //           },
//           //         );
//           //     }
//           //   },
//           // ),
// //           ),
// //     );
// //   }
// // }

// /*
// body: StreamBuilder(
//           stream: Services
//               .getMyUserID(), // the particular user will show which exit in my database
//           builder: (context, snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.waiting:
//               case ConnectionState.none:
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               case ConnectionState.active:
//               case ConnectionState.done:
//                 return StreamBuilder<QuerySnapshot>(
//                   stream: Services.getAllUser(
//                     snapshot.data?.docs.map((e) => e.id).toList() ?? [],
//                   ),
//                   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.hasError) {
//                       return const Text('Something went wrong');
//                     }
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Text('Waiting');
//                     }

//                     return ListView(
//                       children: snapshot.data!.docs.map(
//                         (DocumentSnapshot documents) {
//                           Map<String, dynamic> data =
//                               documents.data() as Map<String, dynamic>;
//                           return ListTile(
//                             title: Text(
//                               data['email'],
//                             ),
//                           );
//                         },
//                       ).toList(),
//                     );
