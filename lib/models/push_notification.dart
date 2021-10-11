import 'package:flutter/foundation.dart';

class PushNotification {
  String? title;
  String? body;
  String? dataTitle;
  Map? dataBody;
  bool? foreground;

  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
    this.foreground,
  });

  String get getDataTitle {
    return this.dataTitle ?? '';
  }

  String get getBody {
    return this.body ?? '';
  }

  bool get getForeground {
    return this.foreground ?? true;
  }
}
