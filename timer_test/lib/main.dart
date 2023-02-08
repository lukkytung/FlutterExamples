import 'package:flutter/material.dart';
import 'package:timer_test/second_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyTimer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Custom Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PageView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const FirstView(
                key: ValueKey("FirstView"),
              );
            } else {
              return const SecondView(
                key: ValueKey("SecondView"),
              );
            }
          },
        ));
  }
}

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.red,
      child: const Center(
        child: Text(
          'First View',
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
      ),
    );
  }
}
