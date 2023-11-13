import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnalogClock extends StatefulWidget {
  const AnalogClock({super.key});

  @override
  State<AnalogClock> createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth * 0.8,
          height: constraints.maxWidth * 0.8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3F6080).withOpacity(.2),
                      blurRadius: 32,
                      offset: const Offset(40, 20),
                    ),
                    BoxShadow(
                      color: const Color(0xFFFFFFFF).withOpacity(1),
                      blurRadius: 32,
                      offset: const Offset(-20, -10),
                    ),
                  ],
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFECF6FF), Color(0xFFCADBEB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3F6080).withOpacity(.2),
                      blurRadius: 32,
                      offset: const Offset(10, 5),
                    ),
                    BoxShadow(
                      color: const Color(0xFFFFFFFF).withOpacity(1),
                      blurRadius: 32,
                      offset: const Offset(-10, -5),
                    ),
                  ],
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE3F0F8), Color(0xFFEEF5FD)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
              Transform.rotate(
                angle: pi / 2,
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  child: CustomPaint(
                    painter: ClockPainter(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerY, centerX);

    Paint dashPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    Paint secdashPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    double outerRadius = radius - 20;
    double innerRadius = radius - 30;
    for (int i = 0; i < 360; i += 30) {
      double x1 = centerX - outerRadius * cos(i * pi / 180);
      double y1 = centerX - outerRadius * sin(i * pi / 180);
      double x2 = centerX - innerRadius * cos(i * pi / 180);
      double y2 = centerX - innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashPaint);
    }
    for (int i = 0; i < 360; i += 6) {
      double x1 = centerX - outerRadius * .95 * cos(i * pi / 180);
      double y1 = centerX - outerRadius * .95 * sin(i * pi / 180);
      double x2 = centerX - innerRadius * cos(i * pi / 180);
      double y2 = centerX - innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), secdashPaint);
    }

    DateTime dateTime = DateTime.now();

    Offset secondStartOffset = Offset(
      centerX - outerRadius * cos(dateTime.second * 6 * pi / 180),
      centerX - outerRadius * sin(dateTime.second * 6 * pi / 180),
    );
    Offset secondEndOffset = Offset(
      centerX + 20 * cos(dateTime.second * 6 * pi / 180),
      centerX + 20 * sin(dateTime.second * 6 * pi / 180),
    );

    Offset minStartOffset = Offset(
      centerX - outerRadius * .6 * cos(dateTime.minute * 6 * pi / 180),
      centerX - outerRadius * .6 * sin(dateTime.minute * 6 * pi / 180),
    );
    Offset minEndOffset = Offset(
      centerX + 20 * cos(dateTime.minute * 6 * pi / 180),
      centerX + 20 * sin(dateTime.minute * 6 * pi / 180),
    );

    double hourAngle = (dateTime.hour % 12 + dateTime.minute / 60) * 30.0;
    double hourHandLength = outerRadius * 0.4;

    Offset hourStartOffset = Offset(
      centerX - hourHandLength * cos(hourAngle * pi / 180),
      centerY - hourHandLength * sin(hourAngle * pi / 180),
    );

    double hourHandEndX =
        centerX + 10 * cos(hourAngle * pi / 180); // Adjust the length as needed
    double hourHandEndY =
        centerY + 10 * sin(hourAngle * pi / 180); // Adjust the length as needed
    Offset hourEndOffset = Offset(hourHandEndX, hourHandEndY);

    Paint centerCirclePaint = Paint()..color = const Color(0xFFE81466);
    Paint secondPaint = Paint()
      ..color = const Color(0xFFE81466)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    Paint minPaint = Paint()
      ..color = const Color(0xFFBEC5D5)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    Paint hourPaint = Paint()
      ..color = const Color(0xFF222E63)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(minStartOffset, minEndOffset, minPaint);
    canvas.drawLine(hourStartOffset, hourEndOffset, hourPaint);
    canvas.drawLine(secondStartOffset, secondEndOffset, secondPaint);
    canvas.drawCircle(center, 4, centerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
