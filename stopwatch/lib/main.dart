import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Stopwatch Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final Stopwatch _stopwatch = Stopwatch();
  bool _isRunning = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // const TimerService();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _counter = _stopwatch.elapsedMilliseconds;
      });
    });
    _stopwatch.start();
    _isRunning = true;
  }

  void _stopTimer() {
    _timer?.cancel();
    _stopwatch.stop();
    _isRunning = false;
  }

  void _resetTimer() {
    _timer?.cancel();
    _stopwatch.reset();
    _counter = 0;
    _isRunning = false;
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();
    int millisecondsLeft = milliseconds - hundreds * 10;
    int secondsLeft = seconds - minutes * 60;
    int minutesLeft = minutes - hours * 60;
    String hoursStr = (hours % 24).toString().padLeft(2, '0');
    String minutesStr = minutesLeft.toString().padLeft(2, '0');
    String secondsStr = secondsLeft.toString().padLeft(2, '0');
    String hundredsStr = millisecondsLeft.toString().padLeft(1, '0');
    return '$hoursStr:$minutesStr:$secondsStr.$hundredsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(_counter),
              style: const TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? _stopTimer : _startTimer,
                  child: Text(_isRunning ? 'STOP' : 'START'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('RESET'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
