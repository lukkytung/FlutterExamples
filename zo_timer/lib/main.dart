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
    // final timerData = Provider.of<TimerData>(context);
    print("=======callbackDispatcher:$task");
    if (task == startTimerKey) {
      print("===Native called background task:$startTimerKey");
      TimerData.startBackgroundTimer();
    } else if (task == pauseTimerKey) {
      print("===Native called background task:$pauseTimerKey");

      TimerData.stopBackgroundTimer();
    } else {
      print("===Native called background task:$stopTimerKey");
    }
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerData()),
      ],
      child: const MyApp(),
    ),
  );
  // runApp(const MyApp());
}

class TimerData extends ChangeNotifier {
  int _seconds = 0;
  Timer? _timer;

  int get seconds => _timer == null ? _seconds : _timer!.tick;

  bool get isRunning => _timer != null && _timer!.isActive;

  // 开启后台计时
  static void startBackgroundTimer() {
    // _timer?.cancel();

    print("=======进入后台计时");
    // _seconds++;
  }

  // 进入前台计时
  static void stopBackgroundTimer() {
    print("=======停止后台计时");
  }

  void startTimer() {
    if (!isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds = timer.tick + _seconds;
        notifyListeners();
      });
    }
  }

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void stopTimer() async {
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

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // 监听App生命周期
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 在这里处理生命周期事件
    print("===========生命周期回调:$state");
    switch (state) {
      case AppLifecycleState.inactive:
        // 应用程序变得不活跃
        break;
      case AppLifecycleState.paused:
        // 应用程序进入后台
        Workmanager().registerPeriodicTask(
          startTimerKey,
          startTimerKey,
          frequency: const Duration(seconds: 1),
        );
        break;
      case AppLifecycleState.resumed:
        // 应用程序恢复前台
        Workmanager().registerOneOffTask(
          pauseTimerKey,
          pauseTimerKey,
        );
        break;
      case AppLifecycleState.detached:
        // 应用程序被终止
        Workmanager().cancelAll();
        break;
    }
  }

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
                      print("========Second:${timerData.seconds}");
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
