import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _localNotification = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

  static Future<void> initialize() async {
    const settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    final initializationSettings = InitializationSettings(
      android: settingsAndroid,
      iOS: settingsDarwin,
    );
    _localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationClick,
      onDidReceiveBackgroundNotificationResponse: onNotificationClick,
    );
  }

  static void onNotificationClick(NotificationResponse response) {
    onClickNotification.add(response.payload ?? 'no payload');
  }

  static Future<void> cancelAll() async {
    await _localNotification.cancelAll();
  }

  static Future<void> cancel(int id) async {
    await _localNotification.cancel(id);
  }

  static Future<void> showSimple({
    int id = 0,
    required String title,
    required String body,
    required String payload,
  }) async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'tasking simple $id',
        'tasking simple name',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _localNotification.show(id, title, body, details, payload: payload);
  }

  static Future<void> showPeriodic({
    int id = 1,
    required String title,
    required String body,
    RepeatInterval repeatInterval = RepeatInterval.everyMinute,
  }) async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'tasking periodic $id',
        'tasking periodic name',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _localNotification.periodicallyShow(
        id, title, body, repeatInterval, details);
  }

  static Future<void> showSchedule({
    int id = 2,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    tz.initializeTimeZones();

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'tasking schedule $id',
        'tasking schedule name',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _localNotification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
