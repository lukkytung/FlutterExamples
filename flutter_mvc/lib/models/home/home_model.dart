import 'package:flutter/material.dart';

enum HomeModelStatus {
  ended,
  loading,
  error,
}

class HomeModel extends ChangeNotifier {
  late HomeModelStatus _status;
  late String _errorCode;
  late String _errorMessage;
  int _counter = 0;
  get counter => _counter;

  set counter(value) => _counter = value;

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  HomeModelStatus get status => _status;

  HomeModel();

  HomeModel.instance() {
    _counter = 0;
  }

  void incrementCounter() {
    counter++;
    notifyListeners();
  }

  void getter() {
    _status = HomeModelStatus.loading;
    notifyListeners();

    //TODO Add code here

    _status = HomeModelStatus.ended;
    notifyListeners();
  }

  void setter() {
    _status = HomeModelStatus.loading;
    notifyListeners();

    //TODO Add code here

    _status = HomeModelStatus.ended;
    notifyListeners();
  }

  void update() {
    _status = HomeModelStatus.loading;
    notifyListeners();

    //TODO Add code here

    _status = HomeModelStatus.ended;
    notifyListeners();
  }

  void remove() {
    _status = HomeModelStatus.loading;
    notifyListeners();

    //TODO Add code here

    _status = HomeModelStatus.ended;
    notifyListeners();
  }
}
