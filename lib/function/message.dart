import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> getFcmToken() async {
  String? _fcmToken = await FirebaseMessaging.instance.getToken();
  print("_fcmToken: ${_fcmToken}");
}

Future<void> permission() async {
  final Permission = FirebaseMessaging.instance.requestPermission(
    badge: true,
    alert: true,
    sound: true,
  );

  // if (await Permission.notification.isDenied) {
  //   await Permission.notification.request();
  // }
}


Future<void> initFCM() async {
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );
  // iOS foreground notification 권한
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

// backgroundHandler must be a top-level function
// (e.g. not a class method which requires initialization).
Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint('fcm backgroundHandler, message');

  debugPrint(message.notification?.title ?? '');
  debugPrint(message.notification?.body ?? '');
}

Future<void> setFCM() async {

  //백그라운드 메세지 핸들링(수신처리)
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
}

Future<void> terminateFCM() async {

  ///gives you the messsage on which user taps
  ///and it opened the app from temminated state
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    debugPrint('fcm getInitialMessage, message : ${message?.data ?? ''}');
    if (message != null) {
      return;
    }

  });
}
