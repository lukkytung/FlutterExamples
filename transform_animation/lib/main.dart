import 'package:flutter/material.dart';
import 'package:transform_animation/page/hidden_drawer.dart';
import 'package:transform_animation/page/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        HiddenDrawer(),
        Home(),
      ],
    );
  }
}
