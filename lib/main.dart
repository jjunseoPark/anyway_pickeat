import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pickeat/analytic_config.dart';
import 'package:pickeat/const/analytics_config.dart';
import 'package:pickeat/const/color.dart';
import 'package:pickeat/firebase_options.dart';
import 'package:pickeat/home/home_screen.dart';
import 'package:pickeat/login/login_screen.dart';
import 'package:pickeat/login/sign_up_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Analytics_config().init();

  runApp(PickeatApp());
}

class PickeatApp extends StatefulWidget {
  PickeatApp({super.key});

  @override
  State<PickeatApp> createState() => _PickeatAppState();
}

class _PickeatAppState extends State<PickeatApp> {

  @override

  final router = GoRouter(
    initialLocation: "/login",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => HomeScreen(),
        routes: []
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: "/sign_up",
        builder: (context, state) => SignUpScreen(),
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
