import 'package:chatapplication/src/errors/error_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/snackbar.dart';
import '../../../../widgets/container.dart';
import '../../../controller/authcontroller.dart';
import '../../../models/auth/authmodel.dart';
import '../../../providers/users/userprovider.dart';
import '../../../services/user_services.dart';
import '../../chat/chatscreen.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userStreamProvider);
    final myUserStream = ref.watch(myUserProvider);
    final authState = ref.watch(userDataAuthProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(115, 43, 18, 18),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 6, right: 20, top: 6),
          child: authState.when(
            data: (data) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data!.name!.length <= 8 ? data.name.toString() : "jack",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'NdChat',
                    style: GoogleFonts.dancingScript(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
            error: (error, t) {
              return const Text(
                'Something went wrong with during processing data',
              );
            },
            loading: () {
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
      body: userId.when(
        data: (dat) {
          return myUserStream.when(
            data: (da) {
              final List<UserModel> myUsers = da
                  .map((doc) =>
                      UserModel.fromMap(doc.toMap(), doc.id.toString()))
                  .toList();

              return Padding(
                padding: const EdgeInsets.only(top: 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CupertinoTextField(
                          autofocus: false,
                          enableSuggestions: false,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 13),
                          prefix: const Padding(
                            padding: EdgeInsets.only(left: 13),
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.5),
                            color: const Color.fromARGB(31, 55, 39, 39),
                            border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 30, 48, 51),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Text(
                          'Active Status',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Container(
                                    height: 61,
                                    width: 61,
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          auth.currentUser!.photoURL.toString(),
                                        ),
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: 0,
                                          right: 3,
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 21, 79, 127),
                                                shape: BoxShape.circle),
                                            child: const Text(
                                              "+",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    'My Status',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            da.isEmpty
                                ? const SizedBox.shrink()
                                : SizedBox(
                                    height: 90,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 10,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.5, vertical: 0),
                                          child: SizedBox(
                                            width: 61,
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 61,
                                                  width: 61,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.blue,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                const Text(
                                                  'jack nd ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1.2,
                        color: Color.fromARGB(255, 30, 48, 51),
                      ),
                      da.isEmpty
                          ? const Center(
                              child: Text(
                                'No users found',
                                style: TextStyle(
                                    color: Colors.amber, fontSize: 19),
                              ),
                            )
                          : ListView.builder(
                              itemCount: myUsers.length,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final user = myUsers[index];

                                return Dismissible(
                                  background: Container(
                                    color: Colors.blue,
                                    child: const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.favorite,
                                              color: Colors.white),
                                          Text('Move to favorites',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onDismissed: (DismissDirection direction) {
                                    if (direction ==
                                        DismissDirection.startToEnd) {
                                      debugPrint("Add to favorite");
                                    } else {
                                      debugPrint('Remove item');
                                    }

                                    // setState(() {
                                    //   _values.removeAt(index);
                                    // });
                                  },
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    return showDeleteContactDialog(
                                        content: const Text(
                                          'Do you want to delete this contact \n User photo, message , video will be delete from this chat ',
                                        ),
                                        title:
                                            const Text('Delete this contact'),
                                        context: context,
                                        onTapC: () {
                                          Navigator.of(context).pop();
                                        },
                                        onTapD: () {
                                          Services().deleteUserById(
                                            id: user.id.toString(),
                                          );

                                          Navigator.of(context).pop();
                                        });
                                  },
                                  key: Key(myUsers[index].toString()),
                                  secondaryBackground: Container(
                                    color: Colors.red,
                                    child: const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(Icons.delete,
                                              color: Colors.white),
                                          Text('Move to trash',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              ChatScreen(user: user),
                                        ),
                                      );
                                    },
                                    minVerticalPadding: 9,
                                    horizontalTitleGap: 4,
                                    minLeadingWidth: 9,
                                    visualDensity:
                                        const VisualDensity(vertical: -0.2),
                                    contentPadding:
                                        const EdgeInsets.only(right: 7),
                                    title: Text(
                                      user.name.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    leading: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: Material(
                                                type: MaterialType.transparency,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  height: 320,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.7,
                                                  child: Column(
                                                    children: [
                                                      GlobalContainer(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 40,
                                                        child: Center(
                                                          child: Text(
                                                            user.name
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.amber,
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Hero(
                                                        tag: user.image
                                                            .toString(),
                                                        child: Container(
                                                          height: 243,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          // color: Colors.black,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                user.image
                                                                    .toString(),
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
                                          },
                                        );
                                      },
                                      child: Hero(
                                        tag: user.image.toString(),
                                        child: CircleAvatar(
                                          maxRadius: 39,
                                          backgroundImage: NetworkImage(
                                            user.image.toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      user.about.toString(),
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 182, 177, 177),
                                      ),
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '23 july',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 182, 177, 177),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          // height: 30,
                                          // alignment: Alignment.center,
                                          constraints: const BoxConstraints(
                                              minHeight: 23, minWidth: 23),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.blue),
                                          child: const Text(
                                            '2',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                      const SizedBox(
                        height: 15,
                      ),
                      // const Divider(
                      //   thickness: 0.4,
                      // ),

                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              );
            },
            error: (error, s) {
              return const ErrorScreen();
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
        error: (error, s) {
          return const ErrorScreen();
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
