import 'package:flutter_isolate/provider/timer_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countRiverpod = StateProvider<int>((ref) => 0);

final timerRiverpod =
    ChangeNotifierProvider<TimerNotifier>((ref) => TimerNotifier());
