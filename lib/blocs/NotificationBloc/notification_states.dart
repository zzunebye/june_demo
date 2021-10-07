import 'package:equatable/equatable.dart';
import 'package:moovup_demo/models/push_notification.dart';

class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class StartUpNotificationState extends NotificationState {}

class JobDetailNotificationState extends NotificationState {
  final PushNotification _notificationInfo;

  PushNotification get notificationInfo => _notificationInfo;

  JobDetailNotificationState(this._notificationInfo);

  @override
  List<Object> get props => [_notificationInfo];
}

class NotificationErrorState extends NotificationState {
  final String error;

  NotificationErrorState(this.error);
}
