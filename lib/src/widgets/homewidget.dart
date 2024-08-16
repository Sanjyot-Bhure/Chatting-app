import 'package:chatapplication/src/features/models/auth/authmodel.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
 final UserModel user;
    const HomeWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
  return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: Text(
              'RECENT UPDATE',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Stack(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                color: Colors.blue, shape: BoxShape.circle),
                            child: const Text(
                              "+",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'jack',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  // color: Colors.orangeAccent,/
                  height: 79,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.7),
                        child: SizedBox(
                          height: 70,
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Text(
                                'jack',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          ListView.builder(
            itemCount: 18,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                  // height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 30, 48, 51),
                  ),
                  child: ListTile(
                    minVerticalPadding: 9,
                    horizontalTitleGap: 4,
                    minLeadingWidth: 9,
                    visualDensity: const VisualDensity(vertical: -1.7),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    title: const Text(
                      'Pawan',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    leading: const CircleAvatar(
                      maxRadius: 32,
                    ),
                    subtitle: const Text(
                      'Thanks you so much',
                      style:
                          TextStyle(color: Color.fromARGB(255, 182, 177, 177)),
                    ),
                    trailing: Container(
                      height: 9,
                      width: 9,
                      margin: const EdgeInsets.all(7),
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
