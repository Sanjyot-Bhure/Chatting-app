// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../utils/time_change.dart';
import '../../../widgets/list_tile_widget.dart';
import '../../models/auth/authmodel.dart';

class Profile extends StatefulWidget {
  final UserModel userModel;
  const Profile({super.key, required this.userModel});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 13, right: 0, left: 0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: <Widget>[
                   
                      PopupMenuButton(
                          icon: const Icon(Icons.more_vert,color: Colors.white,),
                        color: const Color.fromARGB(255, 42, 60, 64),
                          itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 1,
                                  child: Text('Edit Name'),
                                ),
                                const PopupMenuItem(
                                  value: 2,
                                  child: Text('Block Contact'),
                                ),
                                const PopupMenuItem(
                                  value: 3,
                                  child: Text('Share'),
                                ),
                              ],)
                      // Services().updateUserName(id: widget.userModel.id.toString(), name: 'Jacknd1');
                   
                  //IconButton
                ],
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Do something
                    Navigator.of(context).pop();
                  },
                ),
                expandedHeight: 170.0,
                floating: true,
                pinned: true,
                centerTitle: true,
                snap: true,
                // elevation: 50,
                backgroundColor: Colors.black,

                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: true,
                  title: CircleAvatar(
                    maxRadius: 35,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.userModel.name.toString(),
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      widget.userModel.email.toString(),
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 19,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        l.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GlassmorphicContainer(
                              width: 60,
                              height: 60,
                              borderRadius: 20,
                              blur: 20,
                              alignment: Alignment.center,
                              border: 2,
                              linearGradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.9),
                                  Colors.white38.withOpacity(0.5),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderGradient: LinearGradient(
                                colors: [
                                  Colors.white24.withOpacity(0.2),
                                  Colors.white70.withOpacity(0.2),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              child: Icon(l[index].icon),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 42, 60, 64),
                      ),
                      constraints: const BoxConstraints(
                        minHeight: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userModel.about.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              wordSpacing: 0.0,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            convertTimestampToRealTime(
                              int.parse(widget.userModel.createdAt.toString()),
                            ),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 137, 130, 130),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListTileData(
                      title: 'Custom Privacy',
                      content: '',
                      icon: Icons.privacy_tip_outlined,
                      trailing: Switch(
                        onChanged: (v) {},
                        value: true,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ListTileData(
                      title: 'Hide Contact name',
                      content: '',
                      icon: Icons.hide_source,
                      trailing: Switch(
                        onChanged: (v) {},
                        value: true,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ListTileData(
                      title: 'Hide Contact name',
                      content: '',
                      icon: Icons.security,
                      trailing: Switch(
                        onChanged: (v) {},
                        value: true,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ListTileData(
                      title: 'Hide Contact name',
                      content: '',
                      icon: Icons.message,
                      trailing: Switch(
                        onChanged: (v) {},
                        value: true,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ListTileData(
                      title: 'Mute notifications',
                      content: '',
                      icon: Icons.notifications,
                      trailing: Switch(
                        onChanged: (v) {},
                        value: true,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Media links and docs',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        itemCount: 8,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 140,
                            width: 100,
                            margin: const EdgeInsets.all(3),
                            color: Colors.blueGrey,
                          );
                        },
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(255, 42, 60, 64),
                      child: const ListTile(
                        focusColor: Colors.amber,
                        selectedColor: Colors.amberAccent,
                        visualDensity: VisualDensity(vertical: 1.7),
                        title: Text(
                          'Block jack nd',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 19,
                          ),
                        ),
                        leading: Icon(
                          Icons.block,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfo {
  IconData icon;
  UserInfo({
    required this.icon,
  });
}

List<UserInfo> l = [
  UserInfo(icon: Icons.call),
  UserInfo(icon: Icons.video_call),
  UserInfo(icon: Icons.search),
];
