import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/bloc/counter_event.dart';
import 'package:flutter_bloc_demo/bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<CounterIncrementPressed>(
        (event, emit) => emit(CounterState(state.count + 1)));
    on<CounterDecrementPressed>(
        (event, emit) => emit(CounterState(state.count - 1)));
  }
}
