class NotificationEvent {
  var payload;

  @override
  List<Object> get props => [this.payload];

  NotificationEvent(this.payload); // payload from the notification
}

class NotificationErrorEvent extends NotificationEvent {
  final String error;

  NotificationErrorEvent(this.error) : super('');
}
