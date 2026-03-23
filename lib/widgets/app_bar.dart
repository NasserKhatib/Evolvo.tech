import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/widgets/h-boutton.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(double) scrollToSection;
  final double aboutOffset;
  final double servicesOffset;
  final double contactOffset;
  final double portfolioOffset;

  const CustomAppBar({
    required this.scrollToSection,
    required this.aboutOffset,
    required this.servicesOffset,
    required this.contactOffset,
    required this.portfolioOffset,
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;
  bool _menuOpen = false;
  String _selectedButton = 'Home';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectButton(String label) {
    setState(() {
      _selectedButton = label;
      _menuOpen = false;
    });
  }

  Widget _buildNavItem(String label, VoidCallback onTap) {
    final isSelected = _selectedButton == label;
    return InkWell(
      onTap: () {
        onTap();
        _selectButton(label);
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.white,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: isSelected ? 28.0 : 0.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookCallButton([String label = 'Book a Call']) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          const whatsappUrl = "https://wa.me/963982338719";
          final uri = Uri.parse(whatsappUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 148,
                height: 46,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CustomPaint(
                  painter: HexagonalButtonPainter(
                    gradient: _isHovered
                        ? null
                        : const LinearGradient(
                            colors: [
                              Color(0xFF062A67),
                              Color(0xFF020F27),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    borderColor: _isHovered
                        ? Colors.blue
                        : Colors.blue.withOpacity(0.5),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FontAwesomeIcons.whatsapp,
                            color: Colors.white, size: 15),
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 820;

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        border: Border(
          bottom: BorderSide(
            color: Colors.blue.withOpacity(0.12),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'EVOLVO',
                  style: TextStyle(
                    fontFamily: 'OriginTech',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.blue,
                  ),
                ),

                if (!isMobile)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildNavItem('Home', () => widget.scrollToSection(0)),
                      _buildNavItem('About', () => widget.scrollToSection(widget.aboutOffset)),
                      _buildNavItem('Services', () => widget.scrollToSection(widget.servicesOffset)),
                      _buildNavItem('Portfolio', () => widget.scrollToSection(widget.portfolioOffset)),
                      _buildNavItem('Contact', () => widget.scrollToSection(widget.contactOffset)),
                    ],
                  ),

                if (!isMobile)
                  _buildBookCallButton()
                else
                  IconButton(
                    icon: Icon(
                      _menuOpen ? Icons.close : Icons.menu,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () => setState(() => _menuOpen = !_menuOpen),
                  ),
              ],
            ),

            // Mobile dropdown menu
            if (isMobile && _menuOpen) ...[
              const Divider(color: Colors.white12, height: 16),
              _buildNavItem('Home', () => widget.scrollToSection(0)),
              _buildNavItem('About', () => widget.scrollToSection(widget.aboutOffset)),
              _buildNavItem('Services', () => widget.scrollToSection(widget.servicesOffset)),
              _buildNavItem('Portfolio', () => widget.scrollToSection(widget.portfolioOffset)),
              _buildNavItem('Contact', () => widget.scrollToSection(widget.contactOffset)),
              const SizedBox(height: 8),
              Center(child: _buildBookCallButton()),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

// Keep NavButton for backward compatibility
class NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  const NavButton({
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        if (isSelected)
          Container(
            height: 2,
            width: 30,
            color: Colors.blue,
          ),
      ],
    );
  }
}

// Hexagonal Button Painter
class HexagonalButtonPainter extends CustomPainter {
  final LinearGradient? gradient;
  final Color borderColor;

  HexagonalButtonPainter({this.gradient, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader =
          gradient?.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final double width = size.width;
    final double height = size.height;
    final double corner = height * 0.25;

    final Path path = Path()
      ..moveTo(corner, 0)
      ..lineTo(width - corner, 0)
      ..lineTo(width, height / 2)
      ..lineTo(width - corner, height)
      ..lineTo(corner, height)
      ..lineTo(0, height / 2)
      ..close();

    if (gradient != null) {
      canvas.drawPath(path, paint);
    }

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
