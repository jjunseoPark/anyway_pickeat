import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:app_version_update/app_version_update.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pickeat/analytic_config.dart';
import 'package:pickeat/const/color.dart';
import 'package:pickeat/firebase_options.dart';
import 'package:pickeat/home/home_screen.dart';
import 'package:pickeat/login/choose_location.dart';
import 'package:pickeat/login/login_screen.dart';
import 'package:pickeat/login/sign_up_screen.dart';

import 'enum/location.dart';
import 'function/message.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Analytics_config().init();

  initFCM();
  terminateFCM();

  runApp(PickeatApp());
}

class PickeatApp extends StatefulWidget {
  PickeatApp({super.key});

  @override
  State<PickeatApp> createState() => _PickeatAppState();
}

class _PickeatAppState extends State<PickeatApp> {
  //app tracking transparency

  @override
  final router = GoRouter(
    initialLocation: "/login",
    routes: [
      GoRoute(
          path: "/home/:location",
          builder: (context, state) =>
              HomeScreen(location: state.pathParameters["location"] ?? 'Gangnam'),
          routes: []),
      GoRoute(
        path: "/login",
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: "/sign_up",
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: "/choose_location",
        builder: (context, state) => ChooseLocation(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pickeat',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSeed(seedColor: picketColor),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

