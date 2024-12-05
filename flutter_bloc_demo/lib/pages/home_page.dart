import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/bloc/counter_bloc.dart';
import 'package:flutter_bloc_demo/bloc/counter_event.dart';
import 'package:flutter_bloc_demo/bloc/counter_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.read<CounterBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Text('${state.count}',
                style: Theme.of(context).textTheme.displayLarge);
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              onPressed: () => {counterBloc.add(CounterIncrementPressed())},
              child: const Icon(Icons.add)),
              const SizedBox(height: 10,),
          FloatingActionButton(
              onPressed: () => {counterBloc.add(CounterDecrementPressed())},
              child: const Icon(Icons.remove))
        ],
      ),
    );
  }
}
