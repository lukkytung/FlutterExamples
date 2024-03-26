import 'package:flutter/material.dart';
import 'package:flutter_mvc/models/home/home_model.dart';
import 'package:flutter_mvc/views/home/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const HomeView(title: 'Flutter Demo Home Page'),
    );
  }
}
