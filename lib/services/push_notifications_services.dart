import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//SHA1: DE:1E:CF:3F:2D:22:6B:63:9B:33:49:A5:76:BD:60:A3:37:A4:58:6C

class PushNotificationService{

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<List<String>> _messsageStream = StreamController.broadcast();
  static Stream<List<String>> get messagetram => _messsageStream.stream;

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future _backgroundHandler(RemoteMessage message) async{
    //print('_onBackgrounHandler ${message.messageId}');
    _messsageStream.add( [message.notification?.title ?? 'No title', message.notification?.body ?? 'No body'] );
    //showNotification(title: message.notification?.title ?? 'No title');
  }

  static Future _onMessageHandler(RemoteMessage message) async{
    //print('_onMessageHandler ${message.messageId}');
    _messsageStream.add( [message.notification?.title ?? 'No title', message.notification?.body ?? 'No body'] );
    //showNotification(title: message.notification?.title ?? 'No title');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async{
    // print('_onMessageOpenApp ${message.messageId}');
    _messsageStream.add( [message.notification?.title ?? 'No title', message.notification?.body ?? 'No body'] );
    //showNotification(title: message.notification?.title ?? 'No title');
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    //print('TOKEN_APP => $token');
    
    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStreams(){
    _messsageStream.close();
  }

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('splash');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}