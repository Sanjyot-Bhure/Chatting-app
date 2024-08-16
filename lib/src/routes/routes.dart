import 'package:chatapplication/src/features/screens/home/homescreen.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGeneratesRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}

// final goRouterProvider = Provider<GoRouter>(
//   (ref) {
//     return GoRouter(
//       initialLocation: '/',
//       routes: [
//         GoRoute(
//           path: HomePage.routeName,
//           builder: (context, state) => HomePage(
//             key: state.pageKey,
//           ),
//         ),
//         GoRoute(
//           path: '',
//           builder: ((context, state) => const HomePage()),
//         ),
//       ],
//     );
//   },
// );
