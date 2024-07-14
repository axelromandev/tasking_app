import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final _plugin = AwesomeNotifications();

  final String _channelGroupKey = 'tasking_channel_group';
  final String _channelGroupName = 'Tasking Group';
  final String _channelKey = 'tasking_channel';
  final String _channelName = 'Tasking Notifications';
  final String _channelDescription = 'Notification channel for basic tests';

  Future<void> initialize() async {
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

  Future<void> show({
    int id = 1,
    required String title,
    String? body,
    DateTime? dateTime,
  }) async {
    try {
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
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remove(int id) async {
    try {
      await _plugin.cancel(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NotificationModel>> getListSchedule() async {
    return await _plugin.listScheduledNotifications();
  }
}
