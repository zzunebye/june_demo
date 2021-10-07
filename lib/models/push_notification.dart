import 'package:flutter/foundation.dart';

class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
    required this.foreground,
  });

  String? title;
  String? body;
  String? dataTitle;
  Map? dataBody;
  bool foreground;
}