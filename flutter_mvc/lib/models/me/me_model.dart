import 'package:flutter/material.dart';

enum MeModelStatus {
  Ended,
  Loading,
  Error,
}

class MeModel extends ChangeNotifier {
  late MeModelStatus _status;
  late String _errorCode;
  late String _errorMessage;

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;
  MeModelStatus get status => _status;

  MeModel();

  MeModel.instance() {
    //TODO Add code here
  }

  void getter() {
    _status = MeModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = MeModelStatus.Ended;
    notifyListeners();
  }

  void setter() {
    _status = MeModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = MeModelStatus.Ended;
    notifyListeners();
  }

  void update() {
    _status = MeModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = MeModelStatus.Ended;
    notifyListeners();
  }

  void remove() {
    _status = MeModelStatus.Loading;
    notifyListeners();

    //TODO Add code here

    _status = MeModelStatus.Ended;
    notifyListeners();
  }
}
