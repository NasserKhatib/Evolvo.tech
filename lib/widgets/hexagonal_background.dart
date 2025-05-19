import 'dart:math';

import 'package:flutter/material.dart';

class HexagonalBackground extends StatelessWidget {
  final Color color;
  final double opacity;
  final double hexagonSize;
  final Color borderColor;
  final double borderWidth;
  final double borderOpacity;

  const HexagonalBackground({
    Key? key,
    this.color = Colors.yellow,
    this.opacity = 0.1,
    this.hexagonSize = 30,
    this.borderColor = const Color.fromARGB(255, 0, 0, 0),
    this.borderWidth = 1.0,
    this.borderOpacity = 0.3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _HexagonalBackgroundPainter(
        color.withOpacity(opacity),
        hexagonSize,
        borderColor.withOpacity(borderOpacity),
        borderWidth,
      ),
    );
  }
}

class _HexagonalBackgroundPainter extends CustomPainter {
  final Color color;
  final double hexagonSize;
  final Color borderColor;
  final double borderWidth;

  _HexagonalBackgroundPainter(
      this.color, this.hexagonSize, this.borderColor, this.borderWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final double hexagonWidth = hexagonSize * sqrt(3);
    final double hexagonHeight = hexagonSize * 2;

    final int rows = (size.height / (hexagonHeight * 0.75)).ceil() + 1;
    final int columns = (size.width / hexagonWidth).ceil() + 1;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        final double x =
            col * hexagonWidth + (row % 2 == 0 ? 0 : hexagonWidth / 2);
        final double y = row * hexagonHeight * 0.75;

        final Path path = Path()
          ..moveTo(x + hexagonSize * cos(0), y + hexagonSize * sin(0));
        for (int i = 1; i <= 6; i++) {
          final double angle = 2 * pi * i / 6;
          path.lineTo(
              x + hexagonSize * cos(angle), y + hexagonSize * sin(angle));
        }
        path.close();

        canvas.drawPath(path, fillPaint);
        canvas.drawPath(path, borderPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
