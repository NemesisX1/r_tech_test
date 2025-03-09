class Notification {
  const Notification({
    required this.title,
    this.icon,
    this.subtitle,
    this.source,
    this.type,
  });

  final String title;
  final String? icon;
  final String? subtitle;
  final NotificationSource? source;
  final NotificationType? type;
}

enum NotificationSource {
  user,
  app,
}

enum NotificationType {
  none,
  alert,
  info,
  error,
  reward,
}
