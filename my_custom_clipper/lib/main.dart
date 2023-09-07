import 'dart:ui';

import 'package:flutter/material.dart';

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
      title: 'MyViewClipper',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MyViewClipper App Bar'),
        ),
        body: Stack(children: [
          // 要添加高斯模糊效果的子widget
          Image.network(
            'https://pic1.zhimg.com/80/v2-e4409c6747bec6b9ac5d22e5dc299747_1440w.webp?source=1940ef5c',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          BackdropFilter(
            filter:
                ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // 调整sigma值以改变模糊程度
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),

          const Align(
            alignment: Alignment.bottomCenter,
            child: BlurBezierWidget(),
          ),
        ]),
      ),
    );
  }
}

class BlurBezierWidget extends StatelessWidget {
  const BlurBezierWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 400.0,
      child: Stack(
        children: [
          // 使用CustomPaint绘制贝塞尔曲线
          // 添加BackdropFilter并设置滤镜效果
          ClipPath(
            clipper: MyViewClipper(),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 20.0, sigmaY: 20.0), // 调整sigma值以改变模糊程度
              child: Container(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyViewClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // 自定义形状
    final path = Path();
    path.moveTo(0, size.height * 0.5); // 开始点

    // 添加贝塞尔曲线
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.65, size.width, size.height * 0.5);

    // 添加其他线段或曲线以定义形状
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
