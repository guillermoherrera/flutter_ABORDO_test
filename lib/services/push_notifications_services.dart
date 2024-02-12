import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//SHA1: DE:1E:CF:3F:2D:22:6B:63:9B:33:49:A5:76:BD:60:A3:37:A4:58:6C

class PushNotificationService{

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static Future _backgroundHandler(RemoteMessage message) async{
    print('_onBackgrounHandler ${message.messageId}');
  }

  static Future _onMessageHandler(RemoteMessage message) async{
    print('_onMessageHandler ${message.messageId}');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async{
    print('_onMessageOpenApp ${message.messageId}');
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('TOKEN_APP => $token');
    
    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

}