import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:demo_project/viewmodel/notification_viewmodel.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationViewModel.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationViewModel.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationViewModel.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationViewModel.onDismissActionReceivedMethod);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: 'hello world',
            body: 'This is my first notification!',
          ),
        );
      },
      child: const Icon(
        Icons.notification_add,
      ),
    );
  }
}
