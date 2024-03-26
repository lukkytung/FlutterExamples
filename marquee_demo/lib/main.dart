import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marquee App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Marquee App Bar'),
        ),
        body: Center(
          child: SizedBox(
            width: 200, // 设置容器宽度，适应你的实际情况
            height: 30,
            child: Marquee(
              text: '这是一段超出宽度的文本，将会以跑马灯效果滚动显示。',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.pinkAccent,
              ), // 设置文本样式
              scrollAxis: Axis.horizontal, // 设置滚动方向
              crossAxisAlignment: CrossAxisAlignment.start, // 设置文本对齐方式
              blankSpace: 20.0, // 设置文本间的空白间隔
              velocity: 50.0, // 设置滚动速度
            ),
          ),
        ),
      ),
    );
  }
}
