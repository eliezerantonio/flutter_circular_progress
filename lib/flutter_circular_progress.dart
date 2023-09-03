library flutter_circular_progress;

import 'dart:math';

import 'package:flutter/material.dart';


class FlutterCircularProgress extends StatelessWidget {
  final double percentage;
  final Color circleColor;
  final Color arcColor;

  const FlutterCircularProgress({
    super.key,
    required this.percentage,
    this.circleColor = Colors.grey,
    this.arcColor = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.expand(
          child: CustomPaint(
            painter: _CircularProgress(
              percentage: percentage,
              arcColor: arcColor,
              circleColor: circleColor,
            ),
          ),
        ),
        Text("${percentage.toStringAsFixed(0)}%")
      ],
    );
  }
}

class _CircularProgress extends CustomPainter {
  final double percentage;
  final Color circleColor;
  final Color arcColor;

  _CircularProgress({
    required this.percentage,
    required this.circleColor,
    required this.arcColor,
  })  : assert(percentage <= 100,
            'The Percentage must be equal to or less than 100'),
        assert(percentage >= 0,
            'The percentage must be equal to or greater than 0');

  @override
  void paint(Canvas canvas, Size size) {
    //!circle

    final paint = Paint()
      ..color = circleColor
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke;

    final double width = size.width / 2;
    final double height = size.height * .5;

    final center = Offset(width, height);
    final double radius = min(width, height);
    canvas.drawCircle(center, radius, paint);

    //!arc

    final paintArc = Paint()
      ..color = arcColor
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final double sweepAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
