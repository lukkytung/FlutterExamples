
import 'package:flutter/material.dart';
import 'package:flutter_realm_demo/pages/home_page.dart';
import 'package:flutter_realm_demo/pages/second_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Realm Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Realm Demo'),
        ),
        body: const SecondPage(),
      ),
    );
  }
}
