import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  runApp(MyApp());
  Workmanager().initialize(callbackDispatcher);
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    if (task == 'timerTask') {
      TimerProvider().startTimer();
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerPage(),
    );
  }
}

class TimerProvider with ChangeNotifier {
  int _secondsLeft = 1500; // 25 minutes
  Timer? _timer;
  bool _isRunning = false;

  int get secondsLeft => _secondsLeft;
  bool get isRunning => _isRunning;

  void startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        _secondsLeft--;
        notifyListeners();
      } else {
        _timer?.cancel();
        _isRunning = false;
        _showNotification();
        notifyListeners();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    _secondsLeft = 1500; // Reset timer to 25 minutes
    notifyListeners();
  }

  void _showNotification() async {
    FlutterLocalNotificationsPlugin notifications =
        FlutterLocalNotificationsPlugin();
    var androidDetails = const AndroidNotificationDetails(
      'channel_id',
      'Tomato Clock',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iosDetails = const DarwinNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await notifications.show(
      0,
      'Time to take a break!',
      'Your tomato clock timer has finished.',
      platformChannelSpecifics,
      payload: 'payload',
    );
  }
}

class TimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TimerProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tomato Clock'),
        ),
        body: TimerWidget(),
      ),
    );
  }
}

class TimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TimerProvider timerProvider = Provider.of<TimerProvider>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${(timerProvider.secondsLeft ~/ 60).toString().padLeft(2, '0')}:${(timerProvider.secondsLeft % 60).toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 48),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: timerProvider.isRunning
                    ? timerProvider.pauseTimer
                    : timerProvider.startTimer,
                child: Text(timerProvider.isRunning ? '暂停' : '开始'),
              ),
              ElevatedButton(
                onPressed: timerProvider.stopTimer,
                child: Text('停止'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
