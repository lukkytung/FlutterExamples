import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import model
import 'package:flutter_mvc/models/home/home_model.dart';
// import controller
import 'package:flutter_mvc/controllers/home/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    HomeController viewController = HomeController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: ChangeNotifierProvider<HomeModel>(
        create: (context) => HomeModel(),
        child: Consumer<HomeModel>(
          builder: (context, viewModel, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${viewModel.counter}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      viewController.incrementCounter(context);
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
