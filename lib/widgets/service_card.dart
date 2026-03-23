import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -8.0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _hovered ? const Color(0xFF07111E) : Colors.black,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? Colors.blue : Colors.blue.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? Colors.blue.withOpacity(0.28)
                  : Colors.blue.withOpacity(0.06),
              spreadRadius: _hovered ? 2 : 0,
              blurRadius: _hovered ? 22 : 8,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _hovered
                      ? [const Color(0xFF1976D2), const Color(0xFF0D47A1)]
                      : [const Color(0xFF0D47A1), const Color(0xFF062A67)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: _hovered
                    ? [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          blurRadius: 16,
                          spreadRadius: 2,
                        )
                      ]
                    : [],
              ),
              child: FaIcon(widget.icon, size: 30, color: Colors.white),
            ),
            const SizedBox(height: 18),
            Text(
              widget.title,
              style: TextStyle(
                color: _hovered ? const Color(0xFF90CAF9) : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white54,
                height: 1.65,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
