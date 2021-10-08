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
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NotificationBloc() : super(NotificationState()) {}

  NotificationState get initialState {
    return StartUpNotificationState();
  }

  PushNotification createNotification(RemoteMessage message, bool foreground) {
    return PushNotification(
      title: message.notification != null ? message.notification!.title! : '',
      body: message.notification?.body,
      dataTitle: message.data['title'],
      dataBody: message.data,
      foreground: foreground,
    );
  }

  initialize() async {
    await Firebase.initializeApp();
    await registerNotification();
    await checkForInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = createNotification(message, false);

      add(NotificationEvent(notification));
    });
  }

  registerNotification() async {
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = createNotification(message, true);

        add(NotificationEvent(notification));
      });
    } else {
      // print('User declined or has not accepted permission');
      add(NotificationErrorEvent("You can provide permission by going into Settings later."));
    }
  }

  checkForInitialMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = createNotification(initialMessage, false);
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
