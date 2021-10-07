import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moovup_demo/blocs/NotificationBloc/notification_events.dart';
import 'package:moovup_demo/blocs/NotificationBloc/notification_states.dart';
import 'package:moovup_demo/models/push_notification.dart';
import 'package:moovup_demo/pages/job_detail_page/job_detail_page.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  late final FirebaseMessaging _messaging;
  late int _totalNotifications;
  PushNotification? _notificationInfo;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NotificationBloc() : super(NotificationState()) {}

  NotificationState get initialState {
    return StartUpNotificationState();
  }

  initialize() async {
    registerNotification();

    checkForInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data,
        foreground: false,
      );

      add(NotificationEvent(notification));
    });
  }

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      // print(
      //     "Handling a onBackground message: ${message.messageId} title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}");
    });

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // print(
        //     'onMessage title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data,
          foreground: true,
        );

        add(NotificationEvent(notification));
      });
    } else {
      // print('User declined or has not accepted permission');
      add(NotificationErrorEvent("You can provide permission by going into Settings later."));
    }
  }

  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
        foreground: true,
      );
    }
  }

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is NotificationEvent) {
      if (event.payload != null) {
        print("${event.payload!.title}:  ${event.payload!.body!} ${event.payload!.dataBody}");
        yield JobDetailNotificationState(event.payload);
      }
    } else if (event is NotificationErrorEvent) {
      yield NotificationErrorState((event).error);
    }
  }
}
