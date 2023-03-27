import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:transition_animation/first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transition Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        controller: CarouselSliderController(),
        slideTransform: const CubeTransform(),
        scrollPhysics: const ClampingScrollPhysics(),
        children: [
          Container(
            color: Colors.orange,
          ),
          Container(
            color: Colors.deepOrange,
          ),
        ],
        onSlideChanged: (value) {
          print("===========value");
        },
      ),
    );
  }
}
