import 'dart:ui';

import 'package:flutter/material.dart';

class GlobalContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  const GlobalContainer({
    super.key,
    required this.child,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.65,
          // width: MediaQuery.of(context).size.width * 0.97,
          width: width,
          height: height,
          decoration: BoxDecoration(
            // color: Colors.black.withOpacity(0.2),
            gradient: LinearGradient(
              colors: [
                // const Color.fromARGB(255, 57, 47, 47).withOpacity(0.0),
                // const Color.fromARGB(255, 21, 16, 16).withOpacity(0.1),
                Colors.white.withOpacity(0.6),
                Colors.white.withOpacity(0.3),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              width: 2.5,
              style: BorderStyle.solid,
              // color: const Color.fromARGB(255, 241, 241, 241).withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
