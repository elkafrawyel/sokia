import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'MyApp.dart';
import 'api/api_service.dart';
import 'helper/local_storage.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.notification.body}");
}

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FCMConfig.instance.init(
    onBackgroundMessage: _firebaseMessagingBackgroundHandler,
    defaultAndroidChannel: AndroidNotificationChannel('com.sokia', 'sokia')
  );

  runApp(MyApp());

  // FCMConfig.messaging.getToken().then((token) {
  //   print('Firebase token : $token');
  //   String fireToken = LocalStorage().getString(LocalStorage.firebaseToken);
  //     if (fireToken == null) {
  //       fireToken = token;
  //       LocalStorage().setString(LocalStorage.firebaseToken, fireToken);
  //       ApiService().sendFirebaseToken(firebaseToken: token);
  //     } else {
  //       if (fireToken != token) {
  //         fireToken = token;
  //         LocalStorage().setString(LocalStorage.firebaseToken, fireToken);
  //         print("FirebaseMessaging token: $token");
  //         ApiService().sendFirebaseToken(firebaseToken: token);
  //       }
  //     }
  // });
}
