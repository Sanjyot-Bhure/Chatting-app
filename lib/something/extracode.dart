//  onLongPress: () {
//                                         showDeleteContactDialog(
//                                             content: const Text(
//                                                 'Do you want to delete this contact \n User photo, message , video will be delete from this chat '),
//                                             title: const Text(
//                                                 'Delete this contact'),
//                                             context: context,
//                                             onTapC: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             onTapD: () {
//                                               Services().deleteUserById(
//                                                 id: user.id.toString(),
//                                               );

                                              // Get a reference to the collection
                                              // CollectionReference documentsCollection =
                                              //     FirebaseFirestore.instance
                                              //         .collection('USERS')
                                              //         .doc(auth.currentUser!.uid)
                                              //         .collection('MY-USER');

                                              // // Query the documents collection
                                              // documentsCollection
                                              //     .get()
                                              //     .then((QuerySnapshot snapshot) {
                                              //   for (QueryDocumentSnapshot document
                                              //       in snapshot.docs) {
                                              //     String documentId = document.id;
                                              //     print('Document ID: $documentId');

                                              //     // Perform your desired action with the document ID
                                              //     // For example, you can delete the document:
                                              //     // document.reference.delete();
                                              //   }
                                              // }).catchError((error) {
                                              //   print(
                                              //       'Failed to retrieve documents: $error');
                                              // });
                                              // services
                                              //     .deleteUserById(
                                              //         id: user.id.toString())
                                              //     .then((value) => print('some'));
                                      //         Navigator.of(context).pop();
                                      //       });
                                      // },