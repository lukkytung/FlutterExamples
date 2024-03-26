import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import model
import 'package:flutter_mvc/models/me/me_model.dart';
// import controller
import 'package:flutter_mvc/controllers/me/me_controller.dart';

class MeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MeController viewController = MeController();
    return ChangeNotifierProvider<MeModel>(
      create: (context) => MeModel.instance(),
      child: Consumer<MeModel>(
        builder: (context, viewModel, child) {
          return Container(
              //TODO Add layout or component here
              );
        },
      ),
    );
  }
}