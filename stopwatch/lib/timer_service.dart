import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class TimerService extends StatefulWidget {
  const TimerService({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimerServiceState createState() => _TimerServiceState();
}

class _TimerServiceState extends State<TimerService> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // 发送一个带有计时器当前时间的事件
      WidgetsBinding.instance.addPostFrameCallback((_) {
        const MethodChannel('com.example.stopwatch/timer')
            .invokeMethod('updateTimer', _stopwatch.elapsedMilliseconds);
      });
    });
    _stopwatch.start();
  }

  void _stopTimer() {
    _timer?.cancel();
    _stopwatch.stop();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
