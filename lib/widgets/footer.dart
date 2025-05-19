import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final int _hexagonCount = 10;
  final List<Hexagon> _hexagons = [];
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    )..addListener(() {
        setState(() {
          _moveHexagons();
        });
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      for (int i = 0; i < _hexagonCount; i++) {
        _hexagons.add(Hexagon.random(context, speedMultiplier: 6));
      }
      _isInitialized = true;
    }
  }

  void _moveHexagons() {
    for (var hexagon in _hexagons) {
      hexagon.updatePosition(context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 200),
            painter: TwoWavePainter(_animation.value),
          ),
        ),
        for (var hexagon in _hexagons)
          Positioned(
            left: hexagon.x,
            bottom: hexagon.y,
            child: CustomPaint(
              size: Size(hexagon.size, hexagon.size),
              painter: HexagonPainter(),
            ),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedIcon(Icons.facebook,
                    "https://www.facebook.com/profile.php?id=61574596812691"),
                _buildAnimatedIcon(FontAwesomeIcons.linkedin,
                    "https://www.linkedin.com/company/evolvo-tech/?lipi=urn%3Ali%3Apage%3Ad_flagship3_company%3BEY12qNBTTke1Qf0u74o3Iw%3D%3D"),
                _buildAnimatedIcon(FontAwesomeIcons.instagram,
                    "https://www.instagram.com/evolvo.tech?igsh=MXBzNng2eDE0bzdsNQ%3D%3D&utm_source=qr"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedIcon(IconData icon, String url) {
    return GestureDetector(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
        child: Icon(
          icon,
          size: 30,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class TwoWavePainter extends CustomPainter {
  final double animationValue;
  TwoWavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    _drawWave(canvas, size, Color.fromARGB(255, 20, 37, 184).withOpacity(0.1),
        2, 20, pi);
    _drawWave(canvas, size, Colors.lightBlue.withOpacity(0.1), 2, 20, 0);
  }

  void _drawWave(Canvas canvas, Size size, Color color, double speed,
      double amplitude, double phaseShift) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.75);

    for (double i = 0; i < size.width; i++) {
      final y = size.height * 0.75 +
          sin((i / size.width * 2 * pi) +
                  (animationValue * 2 * pi * speed) +
                  phaseShift) *
              amplitude;
      path.lineTo(i, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class HexagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path();
    final double radius = size.width / 2;

    for (int i = 0; i < 6; i++) {
      final angle = (pi / 3) * i - pi / 2;
      final x = radius + radius * cos(angle);
      final y = radius + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Hexagon {
  double x;
  double y;
  double dx;
  double dy;
  double size;

  Hexagon({
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
    required this.size,
  });

  factory Hexagon.random(BuildContext context, {double speedMultiplier = 6}) {
    final random = Random();
    final screenWidth = MediaQuery.of(context).size.width;

    return Hexagon(
      x: random.nextDouble() * screenWidth,
      y: random.nextDouble() * 200,
      dx: (random.nextDouble() * 2 - 1) * speedMultiplier,
      dy: (random.nextDouble() * 2 - 1) * speedMultiplier,
      size: random.nextDouble() * 15 + 15,
    );
  }

  void updatePosition(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    x += dx;
    y += dy;

    if (x <= 0 || x + size >= screenWidth) {
      dx = -dx;
    }
    if (y <= 0 || y + size >= 200) {
      dy = -dy;
    }
  }
}
