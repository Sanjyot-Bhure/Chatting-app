import 'package:chatapplication/src/errors/error_screen.dart';
import 'package:chatapplication/src/features/controller/authcontroller.dart';
import 'package:chatapplication/src/features/screens/auth/loginscreen.dart';
import 'package:chatapplication/src/features/screens/home/homescreen.dart';
import 'package:chatapplication/src/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// check whether the firebase is initialized or not
final firebaseInitializedProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch the firebase property for access value
    final initializeApp = ref.watch(firebaseInitializedProvider);
    // final goRouter = ref.watch(goRouterProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // routerConfig: goRouter,

      onGenerateRoute: (settings) => onGeneratesRoutes(settings),
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(115, 43, 18, 18),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: initializeApp.when(
        data: (data) {
          return const AuthCheckerScreen();
        },
        error: (e, stackTrace) {
          return const ErrorScreen();
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 4,
      ),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceIn,
      ),
    );

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

final authenticationProvider = Provider<AuthController>((ref) {
  return ref.watch(authControllerProvider);
});
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authChanges;
});

class AuthCheckerScreen extends ConsumerWidget {
  static const String routeName = 'splash-screen';
  const AuthCheckerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authState = ref.watch(authStateProvider);
    final authState = ref.watch(userDataAuthProvider);

    // you can check auth
    return authState.when(
      data: (data) {
        if (data != null) {
          return const HomeScreen();
        }
        return const LoginScreen();
      },
      error: (error, stackTrace) {
        return const ErrorScreen();
      },
      // loading: () => const Text('loading...'),
      loading: () => const LendingScreen(),
    );
  }
}

class LendingScreen extends StatefulWidget {
  const LendingScreen({super.key});

  @override
  State<LendingScreen> createState() => _LendingScreenState();
}

class _LendingScreenState extends State<LendingScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayAnimation, muchDelayedAnimation;
  late AnimationController animationController;
  @override
  void initState() {
    //
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween(begin: -1.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));
    delayAnimation = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(-0.5, 0.8, curve: Cubic(-1, 0, 0, 0)),
      ),
    );
    muchDelayedAnimation = Tween(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.8, 1.0, curve: Cubic(-1, 0, 0, 0)),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'user.displayName.toString()',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
