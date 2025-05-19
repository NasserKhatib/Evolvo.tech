import 'dart:math';
import 'package:flutter/material.dart';

class HexagonalVPainter extends CustomPainter {
  final double progress;

  HexagonalVPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.blue.withOpacity(1 - progress);

    const int layers = 5;
    for (int i = 0; i < layers; i++) {
      double fade = 1 - (i / layers) - (0.2 * progress);
      fade = fade.clamp(0.0, 1.0);

      paint.color = Colors.blue.withOpacity(fade);

      double scale = 1 + (0.3 * i) + (0.2 * progress);

      final Path path = Path();
      final double radius = 30 * scale;
      final double angle = 2 * 3.14159 / 6;

      path.moveTo(centerX, centerY + radius);
      path.lineTo(
          centerX - radius * cos(angle / 2), centerY + radius * sin(angle / 2));
      path.lineTo(
          centerX - radius * cos(angle / 2), centerY - radius * sin(angle / 2));
      path.lineTo(centerX, centerY - radius);
      path.lineTo(
          centerX + radius * cos(angle / 2), centerY - radius * sin(angle / 2));
      path.lineTo(
          centerX + radius * cos(angle / 2), centerY + radius * sin(angle / 2));
      path.close();

      canvas.drawPath(path, paint);
    }

    final corePaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        colors: [Colors.blue.withOpacity(0.8), Colors.lightBlue.withOpacity(1)],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromCircle(
        center: Offset(centerX, centerY),
        radius: 20,
      ));

    canvas.drawCircle(Offset(centerX, centerY), 20, corePaint);

    final pulsePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.blue.withOpacity(0.3);

    double pulseRadius = 20 + (10 * progress);
    canvas.drawCircle(Offset(centerX, centerY), pulseRadius, pulsePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
