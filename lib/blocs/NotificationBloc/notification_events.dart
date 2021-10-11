// NotificationEvent includes a payload from the notification
class NotificationEvent {
  var payload;

  @override
  List<Object> get props => [this.payload];

  NotificationEvent(this.payload);
}

class NotificationErrorEvent extends NotificationEvent {
  final String error;

  NotificationErrorEvent(this.error) : super('');
}
