import 'dart:async';
import 'dart:isolate';

class TimerModel {
  Timer? _timer;
  bool _isRunning = false;
  Duration _duration = Duration.zero;
  SendPort? _sendPort;

  void start() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        _duration += const Duration(seconds: 1);
        _sendPort?.send(_duration);
      });
    }
  }

  void pause() {
    if (_isRunning) {
      _isRunning = false;
      _timer?.cancel();
    }
  }

  void stop() {
    _isRunning = false;
    _timer?.cancel();
    _duration = Duration.zero;
    _sendPort?.send(_duration);
  }

  Duration get duration => _duration;

  void startIsolate() async {
    ReceivePort receivePort = ReceivePort();
    Isolate isolate = await Isolate.spawn(_timerIsolate, receivePort.sendPort);
    receivePort.listen((message) {
      if (message is SendPort) {
        _sendPort = message;
      } else if (message is Duration) {
        _duration = message;
      }
    });
  }

  static void _timerIsolate(SendPort sendPort) {
    Timer? timer;
    Duration duration = Duration.zero;
    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    receivePort.listen((message) {
      if (message is Duration) {
        duration = message;
      }
    });
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      duration += const Duration(seconds: 1);
      sendPort.send(duration);
    });
  }
}
