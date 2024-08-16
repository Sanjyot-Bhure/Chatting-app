// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/snackbar.dart';
import '../../../../utils/time_change.dart';
import '../../../controller/authcontroller.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final authState = ref.watch(userDataAuthProvider);
    TextEditingController aboutController = TextEditingController();
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: authState.when(data: (data) {
            return Column(
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 250,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          scale: 0.1,
                          image: AssetImage(
                            'assets/images/bg.jpg',
                          ),
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 14,
                            ),
                            Center(
                              child: Row(
                                children: [
                                  // Container(
                                  //   height: 46,
                                  //   width: 46,
                                  //   alignment: Alignment.center,
                                  //   decoration: const BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //     color: Color.fromARGB(255, 42, 60, 64),
                                  //   ),
                                  //   child: IconButton(
                                  //     onPressed: () {
                                  //       Navigator.of(context).pop();
                                  //     },
                                  //     icon: const Icon(
                                  //       CupertinoIcons.back,
                                  //       color: Colors.white,
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    height: 46,
                                    width: 46,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 42, 60, 64),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 110.0,
                                  height: 110.0,
                                  decoration: BoxDecoration(
                                    // color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 79, 219, 237),
                                      width: 2.3,
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    //   height: 120,
                                    // width: 120,
                                    imageUrl:
                                        auth.currentUser!.photoURL.toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 90.0,
                                      height: 90.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                const Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Icon(
                                    Icons.photo_camera_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              data!.name.toString(),
                              style: GoogleFonts.acme(
                                  fontSize: 22, color: Colors.green),
                            ),
                            Text(
                              data.email.toString(),
                              style: const TextStyle(
                                  color: Colors.amber, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    ListTileData(
                      onTap: () {
                        // print('something');
                        showDia(
                          context: context,
                          controller: aboutController,
                          hintText: 'Type something',
                          onTapC: () {},
                          onTapD: () {},
                        );
                      },
                      title: data.about.toString(),
                      content: convertTimestampToRealTime(
                        int.parse(data.createdAt.toString()),
                      ),
                      icon: Icons.info_outline,
                      trailing: Container(
                          height: 36,
                          width: 36,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 28, 44, 45),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    ),
                    // const Text('Setting'),

                    const SizedBox(
                      height: 2.6,
                    ),
                    ListTileData(
                      onTap: () {},
                      title: 'Privacy ',
                      content: 'Block contact,profile info',
                      icon: Icons.privacy_tip_outlined,
                    ),

                    const SizedBox(
                      height: 2.6,
                    ),
                    ListTileData(
                      onTap: () {},
                      title: 'Notifications',
                      content: 'Message, group & call tones',
                      icon: Icons.notifications_none_outlined,
                    ),
                    const SizedBox(
                      height: 2.6,
                    ),
                    ListTileData(
                      onTap: () {},
                      title: 'Data and storage',
                      content: 'Network usage, auto download',
                      icon: Icons.data_usage,
                    ),
                    const SizedBox(
                      height: 2.6,
                    ),
                    ListTileData(
                      onTap: () {},
                      title: 'Help',
                      content: 'Help center, contact us, privacy policy',
                      icon: Icons.help_outline,
                    ),
                    const SizedBox(
                      height: 2.6,
                    ),
                    ListTileData(
                      onTap: () {},
                      title: 'Invite a friend ',
                      content: '',
                      icon: Icons.share,
                    ),
                    const SizedBox(
                      height: 2.6,
                    ),
                    ListTileData(
                      onTap: () {},
                      title: 'Logout',
                      content: '',
                      icon: Icons.logout_rounded,
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'Version 1.0.0 amo_64',
                  style: TextStyle(
                    color: Color(0x99FFFFFF),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                )
              ],
            );
          }, error: (e, t) {
            return null;
          }, loading: () {
            return null;
          })),
    );
  }
}

class ListTileData extends StatelessWidget {
  final String title;
  final String content;
  final IconData? icon;
  final Widget? trailing;
  final VoidCallback onTap;
  const ListTileData({
    Key? key,
    required this.title,
    required this.content,
    this.icon,
    this.trailing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        // color: const Color.fromARGB(255, 42, 60, 64),
      ),
      child: ListTile(
        minLeadingWidth: 9,
        onTap: onTap,
        visualDensity: const VisualDensity(vertical: -1.7),
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        trailing: trailing,
        subtitle: Text(
          content,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w300,
          ),
        ),
        leading: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final lowPoint = size.height - 20;
    final highPoint = size.height - 40;
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
