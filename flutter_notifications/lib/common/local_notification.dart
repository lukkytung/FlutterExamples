import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void init() async {
    // 初始化时区数据
    tz.initializeTimeZones();

    // final String timeZoneName = tz.local.name; // 改用本地时区名称
    // print('===本地时区名称:$timeZoneName');
    // tz.setLocalLocation(tz.getLocation(timeZoneName));
    var detroit = tz.getLocation('Asia/Shanghai');
    tz.setLocalLocation(detroit);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> scheduleDailyNotification(DateTime eventDate) async {
    final remainingDays = _calculateDaysToEvent(eventDate);
    const String title = '倒数日提醒';
    final String body = '距离纪念日还有 $remainingDays 天！';
    print('===距离纪念日还有 $remainingDays 天！');

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'daily_notification_channel_id',
      'Daily Notifications',
      channelDescription: '每日倒数日提醒',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    // 计算下一次早上9点的时间
    final tz.TZDateTime scheduledTime = _nextInstanceOfTime(20, 40);

    print('====通知时间:${scheduledTime.toString()}');

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0, // 通知ID
      title,
      body,
      scheduledTime,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  static Future<void> checkNotificationPermission() async {
    final bool? granted = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
    if (granted == true) {
      print('通知权限已授予');
    } else {
      print('通知权限被拒绝');
    }
  }

// 计算下一个9点的时间
  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

// 计算距离纪念日的天数
  static int _calculateDaysToEvent(DateTime eventDate) {
    final now = DateTime.now();
    final difference = eventDate.difference(now).inDays;
    return difference >= 0 ? difference : 0;
  }
}
