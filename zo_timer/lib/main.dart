import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(TimerApp());

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 0;
  bool _isRunning = false;
  bool _isPaused = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    // const IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //         requestAlertPermission: true,
    //         requestBadgePermission: true,
    //         requestSoundPermission: true,
    //         onDidReceiveLocalNotification: (int id, String? title, String? body,
    //             String? payload) async {
    //           // 处理通知点击事件
    //         });
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _updateTimer(Timer timer) {
    if (_isRunning && !_isPaused) {
      setState(() {
        _seconds++;
      });
      _updateNotification();
    }
  }

  void _updateNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'timer_channel', // 通道ID
      '计时器通知', // 通道名称
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true, // 通知不可被清除
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, // 通知ID
      '计时器运行中', // 标题
      '$_seconds 秒', // 内容（显示当前计时）
      platformChannelSpecifics,
      payload: 'timer_running', // 用于处理通知点击事件的数据
    );
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
    });
    _updateNotification();
  }

  void _pauseTimer() {
    setState(() {
      _isPaused = true;
    });
    _updateNotification();
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _seconds = 0;
    });
    _updateNotification();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('计时器 App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_seconds 秒',
              style: TextStyle(fontSize: 48.0),
            ),
            SizedBox(height: 20.0),
            if (!_isRunning)
              ElevatedButton(
                onPressed: _startTimer,
                child: Text('开始计时'),
              )
            else
              ElevatedButton(
                onPressed: _pauseTimer,
                child: Text(_isPaused ? '继续计时' : '暂停计时'),
              ),
            ElevatedButton(
              onPressed: _stopTimer,
              child: Text('停止计时'),
            ),
          ],
        ),
      ),
    );
  }
}
