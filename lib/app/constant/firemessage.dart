// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:dich_vu_it/repository/authentication.repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.max,
);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);

const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin, macOS: initializationSettingsDarwin);

Future onDidReceiveLocalNotification(int? id, String? title, String? body, String? payload) async {
  print('title');
  print('payload');
}

class FireMessage {
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message");
    handleData(message);
    print('Handling a background message ${message.messageId}');
  }

  static void registerFirebase() async {
    var messaging = FirebaseMessaging.instance;
    var settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onBackgroundMessage(FireMessage.firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) {
      handleData(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleData(message);
      print('MessageOpenedApp123: ${message.data}');
    });
    checkOpenAppFromTerminate();
  }

  static final AuthenticationRepository authenticationRepository = AuthenticationRepository();

  static Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    }
  }

  static Future<void> registerToken() async {
    await FirebaseMessaging.instance.getToken().then((token) async {
      print("token firebase $token");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("tokenfirebase", token ?? "");
      var  tokenfirebase = prefs.getString("tokenfirebase");
      print("tokenfirebase:  $tokenfirebase");
      authenticationRepository.updateTokenFirebase(token);
    });
  }

  static void removeToken(String? id) async {
    await FirebaseMessaging.instance.getToken().then((value) async {});
  }

  static void checkOpenAppFromTerminate() async {
    var initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    print('terminal ${jsonEncode(initialMessage?.data ?? {})}');
    print('terminal1 ${jsonEncode(initialMessage.toString())}');
    if (initialMessage != null) {
      Future.delayed(const Duration(seconds: 4)).then((value) {
        handleData(initialMessage);
        return;
      });
    }
  }

  static void onDidReceiveNotificationResponse(NotificationResponse details) {
    print(details.notificationResponseType);
  }

  static void notificationTapBackground(NotificationResponse details) {
    print(details.notificationResponseType);
  }

  static void handleData(RemoteMessage message) {
    print("message messs ${message}");
    var notification = message.notification;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(channel.id, channel.name, channelDescription: channel.description, icon: 'app_icon', importance: Importance.max, priority: Priority.high, showWhen: true);
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin.show(1, notification?.title, notification?.body, platformChannelSpecifics, payload: json.encode(message.data)).then((value) {});
  }
}
