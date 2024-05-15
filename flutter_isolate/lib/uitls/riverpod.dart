import 'package:flutter_isolate/uitls/timer_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countRiverpod = StateProvider<int>((ref) => 0);

final timerRiverpod = ChangeNotifierProvider<TimerNotifier>((ref) {
  return TimerNotifier();
});
