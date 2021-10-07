import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:moovup_demo/models/push_notification.dart';


class NotificationService {
  late FirebaseMessaging _messaging;
  var setNotificationInfo;


  NotificationService(this.setNotificationInfo);

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

   void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        // setState(() {
        //   _notificationInfo = notification;
        //   _totalNotifications++;
        // });
        //
        // if (_notificationInfo != null) {
        //   // For displaying the notification as an overlay
        //   showSimpleNotification(
        //     Text(_notificationInfo!.title!),
        //     leading: NotificationBadge(totalNotifications: _totalNotifications),
        //     subtitle: Text(_notificationInfo!.body!),
        //     background: Colors.cyan.shade700,
        //     duration: Duration(seconds: 2),
        //   );
        // }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }
}