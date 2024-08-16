import 'package:flutter/material.dart';

class MyMessageCard extends StatelessWidget {
  const MyMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width -49,
        ),
        child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    20,
                  ),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What is going on everything is fine my self pawan i am currently working on a  firebase project i have knowledge about ',
                  style: TextStyle(color: Colors.teal),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '11.23 pm',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white60,
                      ),
                    ),
                     SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.done_all, size: 14, color: Colors.white),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
