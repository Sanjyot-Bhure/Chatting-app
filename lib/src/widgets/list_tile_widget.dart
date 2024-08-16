import 'package:flutter/material.dart';

class ListTileData extends StatelessWidget {
  final String title;
  final String content;
  final IconData? icon;
  final Widget? trailing;
  const ListTileData({
    Key? key,
    required this.title,
    required this.content,
    this.icon,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: const Color.fromARGB(255, 42, 60, 64),
      ),
      child: ListTile(
        minLeadingWidth: 9,
        trailing: trailing,
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
