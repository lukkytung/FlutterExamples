import 'package:flutter/material.dart';
import 'package:flutter_notifications/common/local_notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Local Notifications'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // 假设纪念日为某个固定日期
              // final eventDate = DateTime(2024, 12, 25); // 纪念日: 2024年12月25日
              // scheduleDailyNotification(eventDate);
              // LocalNotification.scheduleDailyNotification(eventDate);
              LocalNotification.checkNotificationPermission();
            },
            child: const Text('请求通知权限'),
          ),
          ElevatedButton(
            onPressed: () {
              // 假设纪念日为某个固定日期
              final eventDate = DateTime(2024, 12, 25); // 纪念日: 2024年12月25日
              // scheduleDailyNotification(eventDate);
              LocalNotification.scheduleDailyNotification(eventDate);
            },
            child: const Text('安排每日倒数通知'),
          ),
        ],
      )),
    );
  }
}
