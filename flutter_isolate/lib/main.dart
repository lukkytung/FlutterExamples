import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: const HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int count = 0;
int isoCount = 0;
bool isMain = true;

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel(); // 在应用退出时取消计时器
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // 计时器逻辑
      setState(() {
        if (isoCount != 0) {
          count = isoCount + count + 1;
          isoCount = 0;
        } else {
          count += 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'COUNT: $count',
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // 应用进入后台时，移除计时器到独立Isolate中运行
      _moveTimerToIsolate();
      _timer.cancel(); // 取消主Isolate中的计时器
      isMain = false;
    } else if (state == AppLifecycleState.resumed) {
      // 应用回到前台时，恢复计时器
      isMain = true;
      startTimer();
    }
  }
}

// 将计时器移动到独立Isolate中运行
void _moveTimerToIsolate() async {
  ReceivePort receivePort = ReceivePort();

  Isolate isolate = await Isolate.spawn(_isolateFunction, receivePort.sendPort);
  receivePort.listen((newCount) {
    isoCount = newCount;
    debugPrint('===Isolate count: $newCount');
    if (isMain) {
      receivePort.close();
      isolate.kill();
      debugPrint('=== kill isolate: $newCount');
    }
  });
}

// 在独立Isolate中运行的函数
void _isolateFunction(SendPort sendPort) {
  Timer.periodic(const Duration(seconds: 1), (timer) {
    // 计时器逻辑
    sendPort.send(timer.tick);
  });
}
