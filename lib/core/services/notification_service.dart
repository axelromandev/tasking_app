import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final _plugin = AwesomeNotifications();

  static const String _channelGroupKey = 'tasking_channel_group';
  static const String _channelGroupName = 'Tasking Group';
  static const String _channelKey = 'tasking_channel';
  static const String _channelName = 'Tasking Notifications';
  static const String _channelDescription =
      'Notification channel for basic tests';

  static Future<void> initialize() async {
    await _plugin.initialize(
      'resource://drawable/app_icon',
      [
        NotificationChannel(
          channelGroupKey: _channelGroupKey,
          channelKey: _channelKey,
          channelName: _channelName,
          channelDescription: _channelDescription,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: _channelGroupKey,
          channelGroupName: _channelGroupName,
        ),
      ],
      debug: true,
    );
  }

  static Future<void> show({
    int id = 1,
    required String title,
    String? body,
    DateTime? dateTime,
  }) async {
    final status = await Permission.notification.status;

    if (status.isDenied) {
      await _plugin.requestPermissionToSendNotifications(
        channelKey: _channelKey,
      );
      return;
    }

    if (status.isPermanentlyDenied) return;

    await _plugin.createNotification(
      content: NotificationContent(
        id: id,
        channelKey: _channelKey,
        title: title,
        body: body,
      ),
      schedule: (dateTime != null)
          ? NotificationCalendar.fromDate(date: dateTime)
          : null,
      actionButtons: [],
    );
  }
}
