import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: RootPage(),
        ),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: -1, end: 0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Ink(
          child: InkWell(
              onTap: () {
                setState(() {
                  currentIndex = currentIndex == 0 ? 1 : 0;
                });
                print("==========$currentIndex==");
                controller.forward();
              },
              child: AnimatedBuilder(
                animation: animation,
                child:
                    currentIndex == 0 ? const FirstPage() : const SecondPage(),
                builder: (context, child) {
                  final width = MediaQuery.of(context).size.width;
                  final x = animation.value * width;
                  return Transform(
                    transform: Matrix4.translationValues(x, 0, 0),
                    child: child,
                  );
                },
              ))),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
