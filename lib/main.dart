import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:testfebruary/google_maps_screen.dart';
import 'package:testfebruary/service/notification_service.dart';
import 'package:testfebruary/service/push_notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

GlobalKey<NavigatorState> KeyTest = GlobalKey<NavigatorState>();

void main() async{

  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBKUyOpOCA7ONYWLf8-azYnBZWeOp88VIs",
          appId: "1:1022307443008:android:8e622e511efe70972c1aa5",
          messagingSenderId: "1022307443008",
          projectId: "test-c5003"));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService().init();
  await NotificationService().isAndroidPermissionGranted();
  await NotificationService().requestPermissions();
  await NotificationService().configureDidReceiveLocalNotificationSubject();
  await NotificationService().configureSelectNotificationSubject();
  await PushNotificationService().setupInteractedMessage();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      navigatorKey: KeyTest,

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GoogleMapsScreen()
    );
  }
}