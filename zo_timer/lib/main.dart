import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

const startTimerKey = "startTimerKey";
const pauseTimerKey = "pauseTimerKey";
const stopTimerKey = "stopTimerKey";

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    if (task == startTimerKey) {
      print("Native called background task:$startTimerKey");
    } else if (task == pauseTimerKey) {
      print("Native called background task:$pauseTimerKey");
    } else {
      print("Native called background task:$stopTimerKey");
    }
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class TimerData extends ChangeNotifier {
  int _seconds = 0;
  Timer? _timer;

  int get seconds => _seconds;

  bool get isRunning => _timer != null && _timer!.isActive;

  void startTimer() {
    Workmanager().initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode:
            true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );

    if (!isRunning) {
      Workmanager().registerOneOffTask(startTimerKey, startTimerKey);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds++;
        notifyListeners();
      });
    }
  }

  void pauseTimer() {
    Workmanager().registerOneOffTask(pauseTimerKey, pauseTimerKey);
    _timer?.cancel();
    _timer = null;
  }

  void stopTimer() async {
    await Workmanager().cancelAll();
    _timer?.cancel();
    _timer = null;
    _seconds = 0;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => TimerData(),
        child: const TimerScreen(),
      ),
    );
  }
}

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('计时器'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<TimerData>(
              builder: (context, timerData, _) {
                return Text(
                  '已经计时：${timerData.seconds} 秒',
                  style: const TextStyle(fontSize: 24.0),
                );
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    final timerData =
                        Provider.of<TimerData>(context, listen: false);
                    timerData.isRunning
                        ? timerData.pauseTimer()
                        : timerData.startTimer();
                  },
                  child: Consumer<TimerData>(
                    builder: (context, timerData, _) {
                      return Text(timerData.isRunning ? '暂停' : '开始');
                    },
                  ),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    final timerData =
                        Provider.of<TimerData>(context, listen: false);
                    timerData.stopTimer();
                  },
                  child: const Text('停止'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
