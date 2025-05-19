import 'package:flutter/material.dart';
import 'package:movies_app/widgets/app_bar.dart';

class AnimatedHexButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isHovered;
  final Animation<double> scaleAnimation;

  const AnimatedHexButton({
    Key? key,
    required this.label,
    required this.onTap,
    required this.isHovered,
    required this.scaleAnimation,
  }) : super(key: key);

  @override
  _AnimatedHexButtonState createState() => _AnimatedHexButtonState();
}

class _AnimatedHexButtonState extends State<AnimatedHexButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: widget.scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.scaleAnimation.value,
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: CustomPaint(
                painter: HexagonalButtonPainter(
                  gradient: widget.isHovered
                      ? null
                      : LinearGradient(
                          colors: [
                            Color.fromARGB(255, 6, 42, 103),
                            Color.fromARGB(255, 2, 15, 39),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  borderColor:
                      widget.isHovered ? Colors.blue : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
