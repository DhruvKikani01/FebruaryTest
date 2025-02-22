import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'notification_service.dart';

class PushNotificationService {
  Future<void> setupInteractedMessage() async {

    final messagingInstance = FirebaseMessaging.instance;

    NotificationSettings settings = await messagingInstance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {

      await messagingInstance.getToken().then((token){
        debugPrint('FCM token :: $token');
      });

      // messagingInstance.getInitialMessage().then((RemoteMessage? message) {
      //   print('getInitialMessage called');
      //   if (message != null) {
      //     if (message.notification == null) {
      //       NotificationService().showNotifications(
      //           title: message.data["title"],
      //           description: message.data["description"],
      //           messageData: message.data);
      //     } else {
      //       NotificationService().showNotifications(
      //           title: message.notification?.title,
      //           description: message.notification?.body,
      //           messageData: message.data);
      //     }
      //   }
      // });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          NotificationService().showNotifications(
            title: message.notification?.title,
            description: message.notification?.body,
            messageData: message.data,
          );
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        selectNotificationStream.add(jsonEncode(message.data));
      });
    }
  }
}