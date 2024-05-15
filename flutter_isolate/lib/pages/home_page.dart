import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../uitls/timer_riverpod.dart';

final timerRiverpod = ChangeNotifierProvider<TimerRiverpod>((ref) {
  return TimerRiverpod();
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text(
          ref.watch(timerRiverpod).count.toString(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(timerRiverpod).playOrStop(),
        child: Icon(
          ref.watch(timerRiverpod).isTiming
              ? Icons.pause_sharp
              : Icons.play_arrow,
        ),
      ),
    );
  }
}
