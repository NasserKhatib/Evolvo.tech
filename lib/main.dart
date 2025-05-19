/*import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AnimatedWord()));
}

class AnimatedWord extends StatefulWidget {
  @override
  _AnimatedWordState createState() => _AnimatedWordState();
}

class _AnimatedWordState extends State<AnimatedWord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentSegment = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _currentSegment = (_currentSegment + 1) % 8;
          });
          _controller.reset();
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "EV",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 90,
              height: 90,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ReactorPainter(_currentSegment, _animation.value),
                  );
                },
              ),
            ),
            Text(
              "LVO",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReactorPainter extends CustomPainter {
  final int currentSegment;
  final double animationValue;

  ReactorPainter(this.currentSegment, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;
    final double segmentAngle = pi / 4;

    // Draw the concentric reactor rings
    _drawReactorCore(canvas, center, size);

    // Draw the spinning gear in the center of the reactor
    _drawSpinningGear(canvas, center, radius);

    // Draw the animated segments as part of the reactor
    for (int i = 0; i < currentSegment; i++) {
      final startAngle = segmentAngle * i;
      final sweepAngle = segmentAngle - 0.1;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startAngle, sweepAngle, false, paint);

      final startX = center.dx + radius * cos(startAngle);
      final startY = center.dy + radius * sin(startAngle);
      canvas.drawCircle(Offset(startX, startY), 3, paint);

      final endX = center.dx + radius * cos(startAngle + sweepAngle);
      final endY = center.dy + radius * sin(startAngle + sweepAngle);
      canvas.drawCircle(Offset(endX, endY), 3, paint);
    }

    final startAngle = segmentAngle * currentSegment;
    final sweepAngle = (segmentAngle - 0.1) * animationValue;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, paint);

    final startX = center.dx + radius * cos(startAngle);
    final startY = center.dy + radius * sin(startAngle);
    canvas.drawCircle(Offset(startX, startY), 3, paint);

    final endX =
        center.dx + radius * cos(startAngle + sweepAngle * animationValue);
    final endY =
        center.dy + radius * sin(startAngle + sweepAngle * animationValue);
    canvas.drawCircle(Offset(endX, endY), 3, paint);
  }

  void _drawReactorCore(Canvas canvas, Offset center, Size size) {
    final corePaint = Paint()
      ..color = Colors.blue.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final radius = size.width / 4; // Core radius
    canvas.drawCircle(center, radius, corePaint);

    final glowPaint = Paint()
      ..color = Colors.blue.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    // Drawing outer glow (pulse effect)
    final pulseRadius = radius + (radius * 0.5 * animationValue);
    canvas.drawCircle(center, pulseRadius, glowPaint);
  }

  void _drawSpinningGear(Canvas canvas, Offset center, double radius) {
    final gearPaint = Paint()
      ..color = Colors.blue.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    double angle = animationValue * 0.5 * pi; // Rotating gear effect
    double gearRadius = radius / 3;

    // Draw the gear (multiple small teeth)
    for (int i = 0; i < 8; i++) {
      double angleOffset = i * pi / 4 + angle;
      double x = center.dx + gearRadius * cos(angleOffset);
      double y = center.dy + gearRadius * sin(angleOffset);

      canvas.drawCircle(Offset(x, y), 4, gearPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}*/

/*import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AnimatedWord()));
}

class AnimatedWord extends StatefulWidget {
  @override
  _AnimatedWordState createState() => _AnimatedWordState();
}

class _AnimatedWordState extends State<AnimatedWord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentSegment = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _currentSegment = (_currentSegment + 1) % 8;
          });
          _controller.reset();
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C3E50), // Midnight Blue Background
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "EV",
              style: TextStyle(
                color: Color(0xFF00BFFF), // Electric Blue Text
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 70,
              height: 70,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ReactorPainter(_currentSegment, _animation.value),
                  );
                },
              ),
            ),
            Text(
              "LVO",
              style: TextStyle(
                color: Color(0xFF00BFFF), // Electric Blue Text
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReactorPainter extends CustomPainter {
  final int currentSegment;
  final double animationValue;

  ReactorPainter(this.currentSegment, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF4682B4).withOpacity(0.9) // Steel Blue for outline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;
    final double segmentAngle = pi / 4;

    // Draw the concentric reactor rings with soft glowing effect
    _drawReactorCore(canvas, center, size);

    // Draw the spinning gear with metallic finish
    _drawSpinningGear(canvas, center, radius);

    // Draw the animated segments as part of the reactor
    for (int i = 0; i < currentSegment; i++) {
      final startAngle = segmentAngle * i;
      final sweepAngle = segmentAngle - 0.1;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startAngle, sweepAngle, false, paint);

      final startX = center.dx + radius * cos(startAngle);
      final startY = center.dy + radius * sin(startAngle);
      canvas.drawCircle(Offset(startX, startY), 3, paint);

      final endX = center.dx + radius * cos(startAngle + sweepAngle);
      final endY = center.dy + radius * sin(startAngle + sweepAngle);
      canvas.drawCircle(Offset(endX, endY), 3, paint);
    }

    final startAngle = segmentAngle * currentSegment;
    final sweepAngle = (segmentAngle - 0.1) * animationValue;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, paint);

    final startX = center.dx + radius * cos(startAngle);
    final startY = center.dy + radius * sin(startAngle);
    canvas.drawCircle(Offset(startX, startY), 3, paint);

    final endX =
        center.dx + radius * cos(startAngle + sweepAngle * animationValue);
    final endY =
        center.dy + radius * sin(startAngle + sweepAngle * animationValue);
    canvas.drawCircle(Offset(endX, endY), 3, paint);
  }

  void _drawReactorCore(Canvas canvas, Offset center, Size size) {
    final corePaint = Paint()
      ..color = Color(0xFF0047AB).withOpacity(0.8) // Cobalt Blue Core
      ..style = PaintingStyle.fill;

    final radius = size.width / 4; // Core radius
    canvas.drawCircle(center, radius, corePaint);

    final glowPaint = Paint()
      ..color = Color(0xFF87CEEB).withOpacity(0.3) // Sky Blue Glow
      ..style = PaintingStyle.fill;

    // Drawing outer glow (pulse effect)
    final pulseRadius = radius + (radius * 0.5 * animationValue);
    canvas.drawCircle(center, pulseRadius, glowPaint);
  }

  void _drawSpinningGear(Canvas canvas, Offset center, double radius) {
    final gearPaint = Paint()
      ..color = Color(0xFF0033A0).withOpacity(0.9) // Blue Pantone 286C for gear
      ..style = PaintingStyle.fill;

    final edgePaint = Paint()
      ..color = Colors.black // Black edges
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3; // Set edge thickness for visibility

    double angle = animationValue * 0.5 * pi; // Rotating gear effect
    double gearRadius = radius / 3;

    // Draw the gear teeth with fill and black edges
    for (int i = 0; i < 8; i++) {
      double angleOffset = i * pi / 4 + angle;
      double x = center.dx + gearRadius * cos(angleOffset);
      double y = center.dy + gearRadius * sin(angleOffset);

      // Draw the gear with both fill and black edges
      canvas.drawCircle(Offset(x, y), 6, gearPaint); // Interior of gear
      canvas.drawCircle(Offset(x, y), 6, edgePaint); // Black edge of gear
    }

    // Add concentric circles to mimic Rinnegan-like look
    final sharinganPaint = Paint()
      ..color = Colors.black.withOpacity(0.6) // Darker inner part of the gear
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Drawing concentric circles (starting from the center of the gear)
    int numCircles =
        4; // Number of concentric circles for the Rinnegan-like structure
    for (int i = 1; i <= numCircles; i++) {
      double radiusFactor = gearRadius * i / (numCircles + 1);
      canvas.drawCircle(center, radiusFactor, sharinganPaint); // Draw circles
    }

    // Add curved radial lines (representing the spiral patterns)
    final spokePaint = Paint()
      ..color = Colors.black // Black spokes for the spiral
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3; // Thicker spokes

    int numSpokes = 8; // Adjust number of spokes to create spiral look
    for (int i = 0; i < numSpokes; i++) {
      double angleOffset =
          i * pi / 4 + angle; // Divide into segments for the spiral effect
      double x1 = center.dx + gearRadius * 0.5 * cos(angleOffset);
      double y1 = center.dy + gearRadius * 0.5 * sin(angleOffset);
      double x2 = center.dx + gearRadius * 1.2 * cos(angleOffset);
      double y2 = center.dy + gearRadius * 1.2 * sin(angleOffset);

      // Draw radial lines for the spiral
      canvas.drawLine(
          Offset(x1, y1), Offset(x2, y2), spokePaint); // Radial lines
    }

    // Add the "pinwheel" pattern (sharp curves resembling Rinnegan)
    final pinwheelPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Draw the central "pinwheel" pattern (using rotated triangles)
    for (int i = 0; i < 4; i++) {
      double angleOffset = i * pi / 2 + angle;
      double x1 = center.dx + gearRadius * 0.3 * cos(angleOffset);
      double y1 = center.dy + gearRadius * 0.3 * sin(angleOffset);
      double x2 = center.dx + gearRadius * 0.7 * cos(angleOffset + pi / 8);
      double y2 = center.dy + gearRadius * 0.7 * sin(angleOffset + pi / 8);

      // Create the sharp shapes resembling the pinwheel design
      Path pinwheel = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(x1, y1)
        ..lineTo(x2, y2)
        ..close();
      canvas.drawPath(pinwheel, pinwheelPaint);
    }

    // Adding a glowing central effect to mimic the "eye" look of Madara's Sharingan
    final glowPaint = Paint()
      ..color = Color(0xFF0033A0).withOpacity(0.4) // Soft glowing effect
      ..style = PaintingStyle.fill;

    // Drawing the central glowing circle effect
    double centralGlowRadius = gearRadius * 0.2; // Glow around the center
    canvas.drawCircle(center, centralGlowRadius, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}*/
/*import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AnimatedWord()));
}

class AnimatedWord extends StatefulWidget {
  @override
  _AnimatedWordState createState() => _AnimatedWordState();
}

class _AnimatedWordState extends State<AnimatedWord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentSegment = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _currentSegment = (_currentSegment + 1) % 8;
          });
          _controller.reset();
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 255, 255, 255), // Midnight Blue Background
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "EV",
              style: TextStyle(
                fontFamily: 'Orbitron', // Futuristic font
                color: Color.fromARGB(255, 0, 138, 184), // Electric Blue Text
                fontSize: 80,
                fontWeight: FontWeight.bold,
                letterSpacing: 2, // Increased letter spacing
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Color.fromARGB(255, 0, 138, 184).withOpacity(0.7),
                    offset: Offset(0, 0),
                  ),
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.8),
                    offset: Offset(3, 3),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ReactorPainter(_currentSegment, _animation.value),
                  );
                },
              ),
            ),
            Text(
              "LVO",
              style: TextStyle(
                fontFamily: 'Orbitron', // Futuristic font
                color: Color.fromARGB(255, 0, 138, 184), // Electric Blue Text
                fontSize: 80,
                fontWeight: FontWeight.bold,
                letterSpacing: 2, // Increased letter spacing
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.blue.withOpacity(0.7),
                    offset: Offset(0, 0),
                  ),
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.8),
                    offset: Offset(3, 3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReactorPainter extends CustomPainter {
  final int currentSegment;
  final double animationValue;

  ReactorPainter(this.currentSegment, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 0, 138, 184)
          .withOpacity(0.9) // Electric Blue for reactor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;
    final double segmentAngle = pi / 4;

    // Draw the concentric reactor rings with electric blue glow effect
    _drawReactorCore(canvas, center, size);

    // Draw the spinning gear with metallic finish
    _drawSpinningGear(canvas, center, radius);

    // Draw the animated segments as part of the reactor
    for (int i = 0; i < currentSegment; i++) {
      final startAngle = segmentAngle * i;
      final sweepAngle = segmentAngle - 0.1;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startAngle, sweepAngle, false, paint);

      final startX = center.dx + radius * cos(startAngle);
      final startY = center.dy + radius * sin(startAngle);
      canvas.drawCircle(Offset(startX, startY), 3, paint);

      final endX = center.dx + radius * cos(startAngle + sweepAngle);
      final endY = center.dy + radius * sin(startAngle + sweepAngle);
      canvas.drawCircle(Offset(endX, endY), 3, paint);
    }

    final startAngle = segmentAngle * currentSegment;
    final sweepAngle = (segmentAngle - 0.1) * animationValue;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, paint);

    final startX = center.dx + radius * cos(startAngle);
    final startY = center.dy + radius * sin(startAngle);
    canvas.drawCircle(Offset(startX, startY), 3, paint);

    final endX =
        center.dx + radius * cos(startAngle + sweepAngle * animationValue);
    final endY =
        center.dy + radius * sin(startAngle + sweepAngle * animationValue);
    canvas.drawCircle(Offset(endX, endY), 3, paint);
  }

  void _drawReactorCore(Canvas canvas, Offset center, Size size) {
    final corePaint = Paint()
      ..color = Color(0xFF00BFFF).withOpacity(0.6) // Electric Blue Core
      ..style = PaintingStyle.fill;

    final radius = size.width / 4; // Core radius
    canvas.drawCircle(center, radius, corePaint);

    final glowPaint = Paint()
      ..color = Color(0xFF00BFFF).withOpacity(0.2) // Soft Electric Blue Glow
      ..style = PaintingStyle.fill;

    // Drawing outer glow (pulse effect)
    final pulseRadius = radius + (radius * 0.5 * animationValue);
    canvas.drawCircle(center, pulseRadius, glowPaint);
  }

  void _drawSpinningGear(Canvas canvas, Offset center, double radius) {
    final gearPaint = Paint()
      ..color =
          Color.fromARGB(255, 255, 255, 255).withOpacity(0.9) // White Gear
      ..style = PaintingStyle.fill;

    final edgePaint = Paint()
      ..color = Colors.black // Black edges
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3; // Set edge thickness for visibility

    double angle = animationValue * 0.5 * pi; // Rotating gear effect
    double gearRadius = radius / 3;

    // Draw the gear teeth with fill and black edges
    for (int i = 0; i < 8; i++) {
      double angleOffset = i * pi / 4 + angle;
      double x = center.dx + gearRadius * cos(angleOffset);
      double y = center.dy + gearRadius * sin(angleOffset);

      // Draw the gear with both fill and black edges
      canvas.drawCircle(Offset(x, y), 6, gearPaint); // Interior of gear
      canvas.drawCircle(Offset(x, y), 6, edgePaint); // Black edge of gear
    }

    // Add concentric circles to mimic Rinnegan-like look
    final sharinganPaint = Paint()
      ..color = Colors.black.withOpacity(0.6) // Darker inner part of the gear
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Drawing concentric circles (starting from the center of the gear)
    int numCircles =
        4; // Number of concentric circles for the Rinnegan-like structure
    for (int i = 1; i <= numCircles; i++) {
      double radiusFactor = gearRadius * i / (numCircles + 1);
      canvas.drawCircle(center, radiusFactor, sharinganPaint); // Draw circles
    }

    // Add curved radial lines (representing the spiral patterns)
    final spokePaint = Paint()
      ..color = Colors.black // Black spokes for the spiral
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3; // Thicker spokes

    int numSpokes = 8; // Adjust number of spokes to create spiral look
    for (int i = 0; i < numSpokes; i++) {
      double angleOffset =
          i * pi / 4 + angle; // Divide into segments for the spiral effect
      double x1 = center.dx + gearRadius * 0.5 * cos(angleOffset);
      double y1 = center.dy + gearRadius * 0.5 * sin(angleOffset);
      double x2 = center.dx + gearRadius * 1.2 * cos(angleOffset);
      double y2 = center.dy + gearRadius * 1.2 * sin(angleOffset);

      // Draw radial lines for the spiral
      canvas.drawLine(
          Offset(x1, y1), Offset(x2, y2), spokePaint); // Radial lines
    }

    // Add the "pinwheel" pattern (sharp curves resembling Rinnegan)
    final pinwheelPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Draw the central "pinwheel" pattern (using rotated triangles)
    for (int i = 0; i < 4; i++) {
      double angleOffset = i * pi / 2 + angle;
      double x1 = center.dx + gearRadius * 0.3 * cos(angleOffset);
      double y1 = center.dy + gearRadius * 0.3 * sin(angleOffset);
      double x2 = center.dx + gearRadius * 0.7 * cos(angleOffset + pi / 8);
      double y2 = center.dy + gearRadius * 0.7 * sin(angleOffset + pi / 8);

      // Create the sharp shapes resembling the pinwheel design
      Path pinwheel = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(x1, y1)
        ..lineTo(x2, y2)
        ..close();
      canvas.drawPath(pinwheel, pinwheelPaint);
    }

    // Adding a glowing central effect to mimic the "eye" look of Madara's Sharingan
    final glowPaint = Paint()
      ..color = Color.fromARGB(255, 173, 168, 13)
          .withOpacity(0.4) // Soft glowing effect
      ..style = PaintingStyle.fill;

    // Drawing the central glowing circle effect
    double centralGlowRadius = gearRadius * 0.2; // Glow around the center
    canvas.drawCircle(center, centralGlowRadius, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
*/
/*import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AnimatedWord()));
}

class AnimatedWord extends StatefulWidget {
  @override
  _AnimatedWordState createState() => _AnimatedWordState();
}

class _AnimatedWordState extends State<AnimatedWord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentSegment = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _currentSegment = (_currentSegment + 1) % 8;
          });
          _controller.reset();
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "EV",
              style: TextStyle(
                fontFamily: 'serif',
                color: Colors.blue,
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 90,
              height: 90,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ReactorPainter(_currentSegment, _animation.value),
                  );
                },
              ),
            ),
            Text(
              "LVO",
              style: TextStyle(
                fontFamily: 'serif',
                color: Colors.blue,
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReactorPainter extends CustomPainter {
  final int currentSegment;
  final double animationValue;

  ReactorPainter(this.currentSegment, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;
    final double segmentAngle = pi / 4;

    // Draw the concentric reactor rings
    _drawReactorCore(canvas, center, size);

    // Draw the spinning gear in the center of the reactor
    _drawSpinningGear(canvas, center, radius);

    // Draw the animated segments as part of the reactor
    for (int i = 0; i < currentSegment; i++) {
      final startAngle = segmentAngle * i;
      final sweepAngle = segmentAngle - 0.1;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startAngle, sweepAngle, false, paint);

      final startX = center.dx + radius * cos(startAngle);
      final startY = center.dy + radius * sin(startAngle);
      canvas.drawCircle(Offset(startX, startY), 3, paint);

      final endX = center.dx + radius * cos(startAngle + sweepAngle);
      final endY = center.dy + radius * sin(startAngle + sweepAngle);
      canvas.drawCircle(Offset(endX, endY), 3, paint);
    }

    final startAngle = segmentAngle * currentSegment;
    final sweepAngle = (segmentAngle - 0.1) * animationValue;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, paint);

    final startX = center.dx + radius * cos(startAngle);
    final startY = center.dy + radius * sin(startAngle);
    canvas.drawCircle(Offset(startX, startY), 3, paint);

    final endX =
        center.dx + radius * cos(startAngle + sweepAngle * animationValue);
    final endY =
        center.dy + radius * sin(startAngle + sweepAngle * animationValue);
    canvas.drawCircle(Offset(endX, endY), 3, paint);
  }

  void _drawReactorCore(Canvas canvas, Offset center, Size size) {
    final corePaint = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255).withOpacity(1)
      ..style = PaintingStyle.fill;

    final radius = size.width / 4; // Core radius
    canvas.drawCircle(center, radius, corePaint);

    final glowPaint = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    // Drawing outer glow (pulse effect)
    final pulseRadius = radius + (radius * 0.5 * animationValue);
    canvas.drawCircle(center, pulseRadius, glowPaint);
  }

  void _drawSpinningGear(Canvas canvas, Offset center, double radius) {
    final gearPaint = Paint()
      ..color = Colors.blue.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    double angle = animationValue * 0.5 * pi; // Rotating gear effect
    double gearRadius = radius / 4;

    // Draw the gear (multiple small teeth)
    for (int i = 0; i < 8; i++) {
      double angleOffset = i * pi / 4 + angle;
      double x = center.dx + gearRadius * cos(angleOffset);
      double y = center.dy + gearRadius * sin(angleOffset);

      canvas.drawCircle(Offset(x, y), 4, gearPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
*/
/*import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AnimatedWord()));
}

class AnimatedWord extends StatefulWidget {
  @override
  _AnimatedWordState createState() => _AnimatedWordState();
}

class _AnimatedWordState extends State<AnimatedWord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // "E" Text
            Text(
              "E",
              style: TextStyle(
                fontFamily: 'serif',
                color: Colors.blue,
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Layered V Shape
            SizedBox(
              width: 120,
              height: 120,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: LayeredVPainter(_animation.value),
                  );
                },
              ),
            ),
            // "LVO" Text
            Text(
              "LVO",
              style: TextStyle(
                fontFamily: 'serif',
                color: Colors.blue,
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LayeredVPainter extends CustomPainter {
  final double progress;

  LayeredVPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    const int layers = 3; // Number of "V" layers
    for (int i = 0; i < layers; i++) {
      double fade = 1 - (i / layers) - (0.2 * progress);
      fade = fade.clamp(0.0, 1.0);

      paint.color = Colors.blue.withOpacity(fade);

      double scale = 1 + (0.5 * i) + (0.3 * progress);

      final path = Path()
        ..moveTo(centerX, centerY + (100 * scale)) // Bottom point
        ..lineTo(centerX - (50 * scale), centerY - (50 * scale)) // Top left
        ..moveTo(centerX, centerY + (100 * scale)) // Bottom point again
        ..lineTo(centerX + (50 * scale), centerY - (50 * scale)); // Top right

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
*/
/*import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AnimatedWord()));
}

class AnimatedWord extends StatefulWidget {
  @override
  _AnimatedWordState createState() => _AnimatedWordState();
}

class _AnimatedWordState extends State<AnimatedWord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // "E" Text with smaller font size
            Text(
              "E",
              style: TextStyle(
                fontFamily: 'serif',
                color: Colors.blue,
                fontSize: 70, // Reduced font size
                fontWeight: FontWeight.bold,
              ),
            ),
            // Layered V Shape with smaller layers
            SizedBox(
              width: 80, // Adjusted size for smaller layers
              height: 80, // Adjusted size for smaller layers
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: LayeredVPainter(_animation.value),
                  );
                },
              ),
            ),
            // "LVO" Text with smaller font size
            Text(
              "LVO",
              style: TextStyle(
                fontFamily: 'serif',
                color: Colors.blue,
                fontSize: 70, // Reduced font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LayeredVPainter extends CustomPainter {
  final double progress;

  LayeredVPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    const int layers = 5; // Number of "V" layers
    for (int i = 0; i < layers; i++) {
      double fade = 1 - (i / layers) - (0.2 * progress);
      fade = fade.clamp(0.0, 1.0);

      paint.color = Colors.blue.withOpacity(fade);

      double scale =
          1 + (0.3 * i) + (0.2 * progress); // Reduced scale for smaller layers

      final path = Path()
        ..moveTo(centerX, centerY + (50 * scale)) // Bottom point
        ..lineTo(centerX - (25 * scale), centerY - (25 * scale)) // Top left
        ..moveTo(centerX, centerY + (50 * scale)) // Bottom point again
        ..lineTo(centerX + (25 * scale), centerY - (25 * scale)); // Top right

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}beeeest one
*/
/*import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AnimatedWord()));
}

class AnimatedWord extends StatefulWidget {
  @override
  _AnimatedWordState createState() => _AnimatedWordState();
}

class _AnimatedWordState extends State<AnimatedWord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // "E" Text with smaller font size
            Text(
              "E",
              style: TextStyle(
                fontFamily: 'serif',
                color: Colors.white,
                fontSize: 70, // Reduced font size
                fontWeight: FontWeight.bold,
              ),
            ),
            // Layered horned "V" Shape with repeat animation
            SizedBox(
              width: 120,
              height: 120,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: DeerFaceVPainter(_animation.value),
                  );
                },
              ),
            ),
            // "LVO" Text with smaller font size
            Text(
              "LVO",
              style: TextStyle(
                fontFamily: 'serif',
                color: Colors.white,
                fontSize: 70, // Reduced font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for deer face inside the "V"
class DeerFaceVPainter extends CustomPainter {
  final double progress;

  DeerFaceVPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white
          .withOpacity(1 - progress); // White color with animation effect

    const int layers = 5; // Number of "V" layers
    for (int i = 0; i < layers; i++) {
      double fade = 1 - (i / layers) - (0.2 * progress);
      fade = fade.clamp(0.0, 1.0);

      paint.color = Colors.white.withOpacity(fade);

      double scale =
          1 + (0.3 * i) + (0.2 * progress); // Adjusted scale for layered effect

      // Draw the "V" shape with horns
      final path = Path()
        ..moveTo(centerX, centerY + (50 * scale)) // Bottom point
        ..lineTo(centerX - (50 * scale), centerY - (50 * scale)) // Left side
        ..moveTo(centerX, centerY + (50 * scale)) // Bottom point again
        ..lineTo(centerX + (50 * scale), centerY - (50 * scale)); // Right side

      // Adding horns: curved points on the top of the V
      path.moveTo(centerX - (50 * scale), centerY - (50 * scale));
      path.quadraticBezierTo(centerX - (75 * scale), centerY - (80 * scale),
          centerX - (50 * scale), centerY - (110 * scale));

      path.moveTo(centerX + (50 * scale), centerY - (50 * scale));
      path.quadraticBezierTo(centerX + (75 * scale), centerY - (80 * scale),
          centerX + (50 * scale), centerY - (110 * scale));

      // Draw the path with updated paint
      canvas.drawPath(path, paint);
    }

    // Draw deer face details inside the "V"
    final facePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withOpacity(1 - progress);

    // Draw eyes
    canvas.drawCircle(
      Offset(centerX - 20, centerY - 20), // Left eye position
      5, // Eye radius
      facePaint,
    );
    canvas.drawCircle(
      Offset(centerX + 20, centerY - 20), // Right eye position
      5, // Eye radius
      facePaint,
    );

    // Draw nose
    canvas.drawCircle(
      Offset(centerX, centerY + 10), // Nose position
      3, // Nose radius
      facePaint,
    );

    // Draw antlers (simplified)
    final antlerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white.withOpacity(1 - progress);

    canvas.drawLine(
      Offset(centerX - 30, centerY - 50), // Left antler start
      Offset(centerX - 50, centerY - 80), // Left antler end
      antlerPaint,
    );
    canvas.drawLine(
      Offset(centerX + 30, centerY - 50), // Right antler start
      Offset(centerX + 50, centerY - 80), // Right antler end
      antlerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
*/
/*import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AnimatedWord()));
}

class AnimatedWord extends StatefulWidget {
  @override
  _AnimatedWordState createState() => _AnimatedWordState();
}

class _AnimatedWordState extends State<AnimatedWord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // "E" Text with thinner and soft silky style
            Text(
              "E",
              style: TextStyle(
                fontFamily: 'cursive',
                color: Colors.white.withOpacity(0.8),
                fontSize: 70,
                fontWeight: FontWeight.w300, // Lighter weight for silky feel
                letterSpacing: 3, // Increased letter spacing for airy feel
                height: 1.2, // Adjusted line height for balance
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.white.withOpacity(0.3),
                    offset: Offset(0, 2),
                  ),
                ], // Soft shadow to enhance silkiness
              ),
            ),
            // Layered "V" Shape with repeat animation
            SizedBox(
              width: 80, // Adjusted size for smaller "V"
              height: 80, // Adjusted size for smaller "V"
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: TechyVPainter(_animation.value),
                  );
                },
              ),
            ),
            // "LVO" Text with thinner and soft silky style
            Text(
              "LVO",
              style: TextStyle(
                fontFamily: 'serif',
                color: Colors.white.withOpacity(0.8),
                fontSize: 70,
                fontWeight: FontWeight.w300, // Lighter weight for silky feel
                letterSpacing: 3, // Increased letter spacing for airy feel
                height: 1.2, // Adjusted line height for balance
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.white.withOpacity(0.3),
                    offset: Offset(0, 2),
                  ),
                ], // Soft shadow to enhance silkiness
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for techy "V"
class TechyVPainter extends CustomPainter {
  final double progress;

  TechyVPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 // Adjusted stroke width for smaller "V"
      ..color = Colors.blue
          .withOpacity(1 - progress); // Blue color with animation effect

    const int layers = 5; // Number of "V" layers
    for (int i = 0; i < layers; i++) {
      double fade = 1 - (i / layers) - (0.2 * progress);
      fade = fade.clamp(0.0, 1.0);

      paint.color = Colors.blue.withOpacity(fade);

      double scale =
          1 + (0.3 * i) + (0.2 * progress); // Adjusted scale for layered effect

      // Draw the "V" shape
      final path = Path()
        ..moveTo(centerX, centerY + (30 * scale)) // Bottom point (smaller)
        ..lineTo(centerX - (30 * scale),
            centerY - (30 * scale)) // Left side (smaller)
        ..moveTo(centerX, centerY + (30 * scale)) // Bottom point again
        ..lineTo(centerX + (30 * scale),
            centerY - (30 * scale)); // Right side (smaller)

      // Draw the path with updated paint
      canvas.drawPath(path, paint);
    }

    // Draw a futuristic, glowing core inside the "V"
    final corePaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        colors: [
          Colors.blue.withOpacity(0.8),
          Colors.lightBlue.withOpacity(0.2)
        ],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromCircle(
        center: Offset(centerX, centerY),
        radius: 20,
      ));

    canvas.drawCircle(Offset(centerX, centerY), 20, corePaint);

    // Draw a holographic grid inside the "V"
    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.blue.withOpacity(0.5);

    for (int i = 0; i < 5; i++) {
      double offset = i * 10.0;
      canvas.drawLine(
        Offset(centerX - 30 + offset, centerY - 30),
        Offset(centerX - 30 + offset, centerY + 30),
        gridPaint,
      );
      canvas.drawLine(
        Offset(centerX - 30, centerY - 30 + offset),
        Offset(centerX + 30, centerY - 30 + offset),
        gridPaint,
      );
    }

    // Add a pulsing effect to the core
    final pulsePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.blue.withOpacity(0.3);

    double pulseRadius = 20 + (10 * progress); // Pulsing radius
    canvas.drawCircle(Offset(centerX, centerY), pulseRadius, pulsePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
*/
/*import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AnimatedWord()));
}

class AnimatedWord extends StatefulWidget {
  @override
  _AnimatedWordState createState() => _AnimatedWordState();
}

class _AnimatedWordState extends State<AnimatedWord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // "E" Text with thinner and soft silky style
            Text(
              "EV",
              style: TextStyle(
                fontFamily: 'cursive',
                color: Colors.blue.withOpacity(1),
                fontSize: 70,
                fontWeight: FontWeight.w300,
                letterSpacing: 3,
                height: 1.2,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.white.withOpacity(0.3),
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
            // Hexagonal "V" Shape with repeat animation
            SizedBox(
              width: 80,
              height: 80,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: HexagonalVPainter(_animation.value),
                  );
                },
              ),
            ),
            // "LVO" Text with thinner and soft silky style
            Text(
              "LVO",
              style: TextStyle(
                fontFamily: 'serif',
                color: Colors.blue.withOpacity(1),
                fontSize: 70,
                fontWeight: FontWeight.w300,
                letterSpacing: 3,
                height: 1.2,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.white.withOpacity(0.3),
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for hexagonal "V"
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

    const int layers = 5; // Number of hexagonal layers
    for (int i = 0; i < layers; i++) {
      double fade = 1 - (i / layers) - (0.2 * progress);
      fade = fade.clamp(0.0, 1.0);

      paint.color = Colors.blue.withOpacity(fade);

      double scale = 1 + (0.3 * i) + (0.2 * progress);

      // Draw the hexagonal "V" shape
      final path = Path();
      final double radius = 30 * scale; // Radius of the hexagon
      final double angle = 2 * 3.14159 / 6; // Angle for each vertex

      // Start at the bottom point
      path.moveTo(centerX, centerY + radius);

      // Draw the left side of the hexagon
      path.lineTo(
          centerX - radius * cos(angle / 2), centerY + radius * sin(angle / 2));
      path.lineTo(
          centerX - radius * cos(angle / 2), centerY - radius * sin(angle / 2));

      // Draw the top-left side
      path.lineTo(centerX, centerY - radius);

      // Draw the top-right side
      path.lineTo(
          centerX + radius * cos(angle / 2), centerY - radius * sin(angle / 2));
      path.lineTo(
          centerX + radius * cos(angle / 2), centerY + radius * sin(angle / 2));

      // Close the path to complete the hexagon
      path.close();

      // Draw the path with updated paint
      canvas.drawPath(path, paint);
    }

    // Draw a futuristic, glowing core inside the hexagon
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

    // Add a pulsing effect to the core
    final pulsePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.blue.withOpacity(0.3);

    double pulseRadius = 20 + (10 * progress); // Pulsing radius
    canvas.drawCircle(Offset(centerX, centerY), pulseRadius, pulsePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
*/
/*import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AnimatedWord()));
}

class AnimatedWord extends StatefulWidget {
  @override
  _AnimatedWordState createState() => _AnimatedWordState();
}

class _AnimatedWordState extends State<AnimatedWord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // "E" Text with custom styling and serif font
            Text(
              "E",
              style: TextStyle(
                fontFamily: 'serif', // Applied serif font family
                color: Colors.white.withOpacity(0.8),
                fontSize: 70,
                fontWeight: FontWeight.w300, // Lighter weight for silky feel
                letterSpacing: 3, // Increased letter spacing for airy feel
                height: 1.2, // Adjusted line height for balance
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.white.withOpacity(0.3),
                    offset: Offset(0, 2),
                  ),
                ], // Soft shadow to enhance silkiness
              ),
            ),
            // Layered horned "V" Shape with repeat animation
            SizedBox(
              width: 80,
              height: 80,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: DeerFaceVPainter(_animation.value),
                  );
                },
              ),
            ),
            // "LVO" Text with custom styling and serif font
            Text(
              "OLVO",
              style: TextStyle(
                fontFamily: 'serif', // Applied serif font family
                color: Colors.white.withOpacity(0.8),
                fontSize: 70,
                fontWeight: FontWeight.w300, // Lighter weight for silky feel
                letterSpacing: 3, // Increased letter spacing for airy feel
                height: 1.2, // Adjusted line height for balance
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.white.withOpacity(0.3),
                    offset: Offset(0, 2),
                  ),
                ], // Soft shadow to enhance silkiness
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for deer face inside the "V"
class DeerFaceVPainter extends CustomPainter {
  final double progress;

  DeerFaceVPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 // Adjusted stroke width for smaller "V"
      ..color = Colors.white
          .withOpacity(1 - progress); // White color with animation effect

    const int layers = 5; // Number of "V" layers
    for (int i = 0; i < layers; i++) {
      double fade = 1 - (i / layers) - (0.2 * progress);
      fade = fade.clamp(0.0, 1.0);

      paint.color = Colors.white.withOpacity(fade);

      double scale =
          1 + (0.3 * i) + (0.2 * progress); // Adjusted scale for layered effect

      // Draw the "V" shape with horns (scaled down)
      final path = Path()
        ..moveTo(centerX, centerY + (30 * scale)) // Bottom point (smaller)
        ..lineTo(centerX - (30 * scale),
            centerY - (30 * scale)) // Left side (smaller)
        ..moveTo(centerX, centerY + (30 * scale)) // Bottom point again
        ..lineTo(centerX + (30 * scale),
            centerY - (30 * scale)); // Right side (smaller)

      // Adding horns: curved points on the top of the V (scaled down)
      path.moveTo(centerX - (30 * scale), centerY - (30 * scale));
      path.quadraticBezierTo(centerX - (45 * scale), centerY - (50 * scale),
          centerX - (30 * scale), centerY - (70 * scale));

      path.moveTo(centerX + (30 * scale), centerY - (30 * scale));
      path.quadraticBezierTo(centerX + (45 * scale), centerY - (50 * scale),
          centerX + (30 * scale), centerY - (70 * scale));

      // Draw the path with updated paint
      canvas.drawPath(path, paint);
    }

    // Draw deer face details inside the "V" (scaled down)
    final facePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withOpacity(1 - progress);

    // Draw eyes (smaller)
    canvas.drawCircle(
      Offset(centerX - 15, centerY - 15), // Left eye position (smaller)
      3, // Eye radius (smaller)
      facePaint,
    );
    canvas.drawCircle(
      Offset(centerX + 15, centerY - 15), // Right eye position (smaller)
      3, // Eye radius (smaller)
      facePaint,
    );

    // Draw nose (smaller)
    canvas.drawCircle(
      Offset(centerX, centerY + 5), // Nose position (smaller)
      2, // Nose radius (smaller)
      facePaint,
    );

    // Draw antlers (simplified and smaller)
    final antlerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5 // Adjusted stroke width for smaller antlers
      ..color = Colors.white.withOpacity(1 - progress);

    canvas.drawLine(
      Offset(centerX - 20, centerY - 30), // Left antler start (smaller)
      Offset(centerX - 35, centerY - 50), // Left antler end (smaller)
      antlerPaint,
    );
    canvas.drawLine(
      Offset(centerX + 20, centerY - 30), // Right antler start (smaller)
      Offset(centerX + 35, centerY - 50), // Right antler end (smaller)
      antlerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

import 'package:flutter/material.dart';
import 'package:movies_app/core/servecies/servecies_locator.dart';
import 'package:movies_app/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies_app/movies/presentation/screens/movies_screen.dart';
import 'home_page.dart';

void main() {
  ServicesLocator().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(getIt<GetNowPlayingMoviesUseCase>.hashCode);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EVOLVO Tech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.blue,
            fontSize: 70,
            fontWeight: FontWeight.w300,
            letterSpacing: 3,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.white.withOpacity(0.3),
                offset: Offset(0, 2),
              ),
            ],
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      //home: MainMoviesScreen(),
      home: HomePage(),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:movies_app/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EVOLVO Tech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.blue,
            fontSize: 70,
            fontWeight: FontWeight.w300,
            letterSpacing: 3,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.white.withOpacity(0.3),
                offset: Offset(0, 2),
              ),
            ],
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      // home: MoviesScreen(),
      home: HomePage(),
    );
  }
}
