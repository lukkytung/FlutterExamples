import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import model
import 'package:flutter_mvc/models/me/me_model.dart';

class MeController {
  MeController();
  
  void getter(BuildContext context) {
    MeModel viewModel = Provider.of<MeModel>(context, listen: false);
    //TODO Add code here for getter
    viewModel.getter();
  }

  void setter(BuildContext context) {
    MeModel viewModel = Provider.of<MeModel>(context, listen: false);
    //TODO Add code here for setter
    viewModel.setter();
  }

  void update(BuildContext context) {
    MeModel viewModel = Provider.of<MeModel>(context, listen: false);
    //TODO Add code here for update
    viewModel.update();
  }

  void remove(BuildContext context) {
    MeModel viewModel = Provider.of<MeModel>(context, listen: false);
    //TODO Add code here for remove
    viewModel.remove();
  }
}