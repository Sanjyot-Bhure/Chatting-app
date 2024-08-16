import 'package:flutter/material.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
            itemCount: 9,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return const ListTile(
                title: Text('Name'),
                subtitle: Text('Last call 17:12'),
                leading: CircleAvatar(
                  maxRadius: 25,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
 
 