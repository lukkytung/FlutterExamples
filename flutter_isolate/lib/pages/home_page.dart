import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Timer'),
        ),
      body: Center(
        child: Text(
          ref.watch(timerRiverpod).counter.toString(),
          style: Theme.of(context).textTheme.displayLarge,
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
