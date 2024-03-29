import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  /// 是否打开抽屉
  bool isOpen = false;

  @override
  void initState() {
    super.initState();

    initAnimation();
  }

  void initAnimation() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          print("===开始执行动画");
        }
        if (status == AnimationStatus.completed) {
          // 完成动画
          // isOpen = false;
          print("===动画结束");
        }
      })
      ..addListener(() {
        setState(() {});
      });

    final curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeOutCubic,
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    // controller.forward();
  }

  /// 打开抽屉
  void openDrawer() {
    if (!isOpen && !controller.isAnimating) {
      isOpen = true;
      controller.forward();
    }
  }

  // 关闭抽屉
  void closDrawer() {
    if (isOpen && !controller.isAnimating) {
      isOpen = false;
      controller.reverse();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (event) {
          closDrawer();
        },
        onPointerMove: (event) {
          // event.position 是指针在屏幕上的位置
          // event.delta 是指针移动的速度
          if (event.delta.dx > 10) {
            // 向右滑动
            print("===向右滑动");
            // openDrawer();
          } else if (event.delta.dx < -10) {
            // 向左滑动
            print("===向左滑动");
            // closDrawer();
          } else if (event.delta.dy > 10) {
            // 向下滑动
            // print("===向下滑动");
            openDrawer();
          } else if (event.delta.dy < -10) {
            // 向上滑动
            // print("===向上滑动");
            // openDrawer();
          }
        },
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                // ..translate(60 * animation.value)
                ..scale(1 - 0.25 * animation.value),
              child: child,
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 185, 185, 185),
                      offset: Offset(0, 0),
                      blurRadius: 20.0)
                ],
                borderRadius:
                    BorderRadius.all(Radius.circular(animation.value * 16.0))),
            child: Center(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.orange,
              ),
            ),
          ),
        ));
  }
}
