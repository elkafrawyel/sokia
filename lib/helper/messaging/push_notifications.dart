import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/helper/get_binding.dart';
import 'package:sokia_app/helper/local_storage.dart';
import 'package:sokia_app/screens/chat/chat_screen.dart';
import 'package:sokia_app/screens/notifications/notifications_screen.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init() async {
    _firebaseMessaging.getToken().then((token) {
      String fireToken = LocalStorage().getString(LocalStorage.firebaseToken);
      if (fireToken == null) {
        fireToken = token;
        LocalStorage().setString(LocalStorage.firebaseToken, fireToken);
        print("FirebaseMessaging token: $token");
        ApiService().sendFirebaseToken(firebaseToken: token);
      } else {
        if (fireToken != token) {
          fireToken = token;
          LocalStorage().setString(LocalStorage.firebaseToken, fireToken);
          print("FirebaseMessaging token: $token");
          ApiService().sendFirebaseToken(firebaseToken: token);
        }
      }
    });
    if (!_initialized) {
      var initializationSettingsAndroid =
          new AndroidInitializationSettings('@mipmap/ic_launcher');

      var initializationSettingsIOS = IOSInitializationSettings();
      var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      _localNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: onSelectNotification);

      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('--onMessage--');

        if (message.notification != null) {
          print('Message Notification: ${message.notification.body}');
        }

        if (message.data != null) {
          print('Message Data: ${message.data}');
        }

        showNotification(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('--onMessageOpenedApp--');

        if (message.notification != null) {
          print('Message Notification: ${message.notification.title}');
        }
        if (message.data != null) {
          print('Message Data: ${message.data}');
        }
        showNotification(message);
      });

      _initialized = true;
    }
  }

  handleBackGroundMessage(RemoteMessage message) async {
    print('--on Background Message--');

    if (message.notification != null) {
      print('Message Notification: ${message.notification.title}');
    }

    if (message.data != null) {
      print('Message Data: ${message.data}');
    }

    // showNotification(message);
  }

  Future onSelectNotification(String payload) async {
    print('Message clicked : $payload');
    Map<String, dynamic> data = json.decode(payload);
    print('Message payload : ${data['formId']}');
    if (data['type'] == 'chat') {
      Get.to(() => ChatScreen(), binding: GetBinding());
    } else {
      Get.to(() => NotificationsScreen(), binding: GetBinding());
    }
  }

  void showNotification(RemoteMessage message) async {
    //if chat no notifications allowed
    String title = message.notification.title;
    String body = message.notification.body;
    String payload = json.encode(message.data);
    await _demoNotification(title, body, payload);
  }

  Future<void> _demoNotification(
      String title, String body, String payload) async {
    String _channelId = "com.sokia.app";
    String _channelName = "Sokia";
    String _channelDesc = "Charity App";

    var androidChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDesc,
        importance: Importance.max,
        playSound: true,
        priority: Priority.high,
        showWhen: true,
        autoCancel: true,
        enableVibration: true,
        visibility: NotificationVisibility.public);

    var iOSChannelSpecifics = IOSNotificationDetails();
    var channelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iOSChannelSpecifics);
    await _localNotificationsPlugin.show(
      1995,
      title,
      body,
      channelSpecifics,
      payload: payload,
    );

  }
}
