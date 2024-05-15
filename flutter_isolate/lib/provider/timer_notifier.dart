import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';


class TimerNotifier extends ChangeNotifier {
  int _counterer = 0;
  bool _isTiming = true;

  get counter => _counterer;

  get isTiming => _isTiming;

  TimerNotifier() {
    playTimer();
  }

  set setCount(int value) {
    _counterer = value;
    notifyListeners();
  }

  set setIsTiming(bool value) {
    _isTiming = value;
    notifyListeners();
  }

  void playOrStop() {
    if (isTiming) {
      setIsTiming = false;
    } else {
      setIsTiming = true;
      playTimer();
    }
  }

  void playTimer() async {

    ReceivePort receivePort = ReceivePort();
    Isolate isolate =
        await Isolate.spawn(isolateFunction, receivePort.sendPort);
    receivePort.listen((newCount) {
      setCount = newCount;
      debugPrint('===Isolate counter: $newCount');
      if (!isTiming) {
        receivePort.close();
        isolate.kill();
        debugPrint('===kill isolate: $newCount');
      }
    });
  }

  // 在独立Isolate中运行的函数
  static void isolateFunction(SendPort sendPort) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // 计时器逻辑
      sendPort.send(timer.tick);
    });
  }
}
