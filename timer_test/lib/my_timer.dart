import 'dart:async';

import 'package:flutter/material.dart';

enum MyTimerControlType {
  ///默认状态，获取当前Timer数据
  normal,

  ///开始倒计时
  start,

  ///暂停倒计时
  pause,

  ///刷新倒计时
  refresh,

  ///停止倒计时
  stop,
}

enum MyTimerState {
  ///默认状态，获取当前Timer数据
  normal,

  ///专注倒计时
  focus,

  ///专注倒计时结束
  focusFinish,

  ///休息倒计时
  rest,

  ///休息倒计时结束
  restFinish,

  ///开始倒计时
  start,

  ///暂停倒计时
  pause,

  ///刷新倒计时
  refresh,

  ///停止倒计时
  stop,
}

class MyTimer extends ChangeNotifier {
  factory MyTimer() => _instance;

  MyTimer._internal();

  static final MyTimer _instance = MyTimer._internal();
  Timer? _timer;

  MyTimerState state = MyTimerState.normal;

  // 是否正在计时（秒）
  bool isRunning = false;

  ///当前剩余专注时长（秒）
  int focusTick = 0;

  ///当前剩余休息时长（秒）
  int restTick = 0;

  ///最大专注时长（秒）
  int maxFocus = 0;

  ///最大休息时长（秒）
  int maxRest = 0;

  bool get isActive {
    return _timer == null ? false : _timer!.isActive;
  }

  void _enable({
    int focusSec = 60,
    int restSec = 30,
  }) {
    maxFocus = focusSec;
    maxRest = restSec;
    _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      // 开始倒计时
      if (isRunning) {
        // 专注时间倒计时
        if (focusTick != maxFocus && restTick == 0) {
          focusTick++;
          state = MyTimerState.focus;
          notifyListeners();
          // 专注时间完成
          if (focusTick == maxFocus) {
            state = MyTimerState.focusFinish;
            notifyListeners();
          }
        }
        // 休息时间倒计时
        if (restTick != maxRest && focusTick == maxFocus) {
          restTick++;
          state = MyTimerState.rest;
          notifyListeners();
          // 休息时间完成
          if (restTick == maxRest) {
            state = MyTimerState.restFinish;
            isRunning = false;
            // Timer倒计时结束，销毁Timer
            _disable();
            notifyListeners();
          }
        }
      }
    });
  }

  /// 销毁Timer
  void _disable() {
    focusTick = 0;
    restTick = 0;
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void runTimer({
    MyTimerControlType type = MyTimerControlType.normal,
    int? focusValue = 0,
    int? restValue = 0,
  }) {
    switch (type) {
      case MyTimerControlType.normal:
        state = MyTimerState.normal;
        notifyListeners();
        break;
      case MyTimerControlType.start:
        _startOrPause(focusValue: focusValue!, restValue: restValue!);
        break;
      case MyTimerControlType.pause:
        _startOrPause(focusValue: focusValue!, restValue: restValue!);
        break;
      case MyTimerControlType.refresh:
        _refresh(focusValue: focusValue!, restValue: restValue!);
        break;
      case MyTimerControlType.stop:
        _stop();
        break;
    }
  }

  /// 开始或暂停Timer
  void _startOrPause({int focusValue = 0, int restValue = 0}) {
    isRunning = !isRunning;
    state = isRunning ? MyTimerState.start : MyTimerState.pause;
    notifyListeners();
    if (MyTimer().isRunning) {
      MyTimer()._enable(
        focusSec: focusValue,
        restSec: restValue,
      );
    }
  }

  /// 刷新Timer
  void _refresh({int focusValue = 0, int restValue = 0}) {
    state = MyTimerState.refresh;
    notifyListeners();
    _disable();

    MyTimer().isRunning = true;
    MyTimer()._enable(
      focusSec: focusValue,
      restSec: restValue,
    );
  }

  /// 停止并销毁Timer
  void _stop() {
    state = MyTimerState.stop;
    notifyListeners();
    MyTimer().isRunning = false;

    _disable();
  }
}
