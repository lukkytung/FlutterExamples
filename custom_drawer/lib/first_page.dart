import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[50],
      child: const Center(
        child: Text('Home page'),
      ),
    );
  }
}
