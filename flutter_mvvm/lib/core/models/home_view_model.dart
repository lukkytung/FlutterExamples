import 'package:flutter_mvvm/core/base/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  int _counter;

  HomeViewModel({int counter = 0, required super.title}) : _counter = counter;

  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  void increment() => counter += 1;
}
