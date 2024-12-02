import 'package:flutter/material.dart';
import 'package:flutter_notifications/common/local_notification.dart';
import 'package:flutter_notifications/page/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotification.init();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
