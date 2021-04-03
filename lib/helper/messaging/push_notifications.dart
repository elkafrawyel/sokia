import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:sokia_app/api/api_service.dart';
import 'package:sokia_app/helper/local_storage.dart';
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

  Future<void> init(BuildContext context) async {
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
      var initializationSettingsMAC = MacOSInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
          macOS: initializationSettingsMAC);

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
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }

        showNotification(message.notification.title, message.notification.body);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('--onMessageOpenedApp--');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }

        showNotification(message.notification.title, message.notification.body);
      });

      // FirebaseMessaging.onBackgroundMessage(
      //     _firebaseMessagingBackgroundHandler);

      _initialized = true;
    }
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    print('--onBackgroundMessage--');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }

    showNotification(message.notification.title, message.notification.body);
  }

  Future onSelectNotification(String message) async {
    print('Message clicked : $message');
    Get.to(NotificationsScreen());
  }

  void showNotification(String title, String body) async {
    //if chat no notifications allowed
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
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
    await _localNotificationsPlugin.show(1995, title, body, channelSpecifics);

    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
    );
  }
}
