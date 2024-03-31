library home_view;

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/models/home_view_model.dart';

part 'home_mobile.dart';
part 'home_tablet.dart';
part 'home_desktop.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(title: ''),
        disposeViewModel: false,
        builder: (context, viewModel, child) {
          return ScreenTypeLayout.builder(
            mobile: (context) => _HomeMobile(viewModel),
            desktop: (context) => _HomeDesktop(viewModel),
            tablet: (context) => _HomeTablet(viewModel),
          );
        });
  }
}
