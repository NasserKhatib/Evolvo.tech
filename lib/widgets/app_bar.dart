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
  String _selectedButton = 'Home'; // Track the selected button

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600; // Check if the device is a mobile

    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
      child: isMobile
          ? Column(
              children: [
                // "EVOLVO" on top
                Text(
                  'EVOLVO',
                  style: TextStyle(
                    fontFamily: 'OriginTech',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 10), // Add spacing between title and buttons
                // Navigation buttons stacked vertically
                Column(
                  children: [
                    NavButton(
                      label: 'Home',
                      onPressed: () {
                        widget.scrollToSection(0);
                        _selectButton('Home');
                      },
                      isSelected: _selectedButton == 'Home',
                    ),
                    NavButton(
                      label: 'About',
                      onPressed: () {
                        widget.scrollToSection(widget.aboutOffset);
                        _selectButton('About');
                      },
                      isSelected: _selectedButton == 'About',
                    ),
                    NavButton(
                      label: 'Services',
                      onPressed: () {
                        widget.scrollToSection(widget.servicesOffset);
                        _selectButton('Services');
                      },
                      isSelected: _selectedButton == 'Services',
                    ),
                    NavButton(
                      label: 'Portfolio',
                      onPressed: () {
                        widget.scrollToSection(widget.servicesOffset);
                        _selectButton('Portfolio');
                      },
                      isSelected: _selectedButton == 'Portfolio',
                    ),
                    NavButton(
                      label: 'Contact',
                      onPressed: () {
                        widget.scrollToSection(widget.contactOffset);
                        _selectButton('Contact');
                      },
                      isSelected: _selectedButton == 'Contact',
                    ),
                    // "Book a Call" button below navigation buttons on mobile
                    SizedBox(height: 10), // Add spacing

                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: MouseRegion(
                        onEnter: (_) => setState(() => _isHovered = true),
                        onExit: (_) => setState(() => _isHovered = false),
                        child: GestureDetector(
                          onTap: () async {
                            const whatsappUrl = "https://wa.me/963982338719";
                            final uri = Uri.parse(whatsappUrl);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              throw 'Could not launch $whatsappUrl';
                            }
                          },
                          child: AnimatedBuilder(
                            animation: _scaleAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _scaleAnimation.value,
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
                                      gradient: _isHovered
                                          ? null
                                          : LinearGradient(
                                              colors: [
                                                Color.fromARGB(255, 6, 42, 103),
                                                Color.fromARGB(255, 2, 15, 39),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                      borderColor: _isHovered
                                          ? Colors.blue
                                          : Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(FontAwesomeIcons.whatsapp,
                                              color: Colors.white, size: 18),
                                          SizedBox(width: 8),
                                          Text(
                                            'Book a Call',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
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
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // "EVOLVO" on the left
                Text(
                  'EVOLVO',
                  style: TextStyle(
                    fontFamily: 'OriginTech',
                    fontSize: 36,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),

                // Centered navigation buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NavButton(
                      label: 'Home',
                      onPressed: () {
                        widget.scrollToSection(0);
                        _selectButton('Home');
                      },
                      isSelected: _selectedButton == 'Home',
                    ),
                    SizedBox(width: 20),
                    NavButton(
                      label: 'About',
                      onPressed: () {
                        widget.scrollToSection(widget.aboutOffset);
                        _selectButton('About');
                      },
                      isSelected: _selectedButton == 'About',
                    ),
                    SizedBox(width: 20),
                    NavButton(
                      label: 'Services',
                      onPressed: () {
                        widget.scrollToSection(widget.servicesOffset);
                        _selectButton('Services');
                      },
                      isSelected: _selectedButton == 'Services',
                    ),
                    SizedBox(width: 20),
                    NavButton(
                      label: 'Portfolio',
                      onPressed: () {
                        widget.scrollToSection(widget.portfolioOffset);
                        _selectButton('Portfolio');
                      },
                      isSelected: _selectedButton == 'Portfolio',
                    ),
                    SizedBox(width: 20),
                    NavButton(
                      label: 'Contact',
                      onPressed: () {
                        widget.scrollToSection(widget.contactOffset);
                        _selectButton('Contact');
                      },
                      isSelected: _selectedButton == 'Contact',
                    ),
                  ],
                ),

                // "Book a Call" button on the right (for larger screens)
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _isHovered = true),
                    onExit: (_) => setState(() => _isHovered = false),
                    child: GestureDetector(
                      onTap: () async {
                        const whatsappUrl = "https://wa.me/963982338719";
                        final uri = Uri.parse(whatsappUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri,
                              mode: LaunchMode.externalApplication);
                        } else {
                          throw 'Could not launch $whatsappUrl';
                        }
                      },
                      child: AnimatedBuilder(
                        animation: _scaleAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
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
                                  gradient: _isHovered
                                      ? null
                                      : LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 6, 42, 103),
                                            Color.fromARGB(255, 2, 15, 39),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                  borderColor: _isHovered
                                      ? Colors.blue
                                      : Colors.transparent,
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(FontAwesomeIcons.whatsapp,
                                          color: Colors.white, size: 18),
                                      SizedBox(width: 8),
                                      Text(
                                        'Book a Call',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
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
                  ),
                ),
              ],
            ),
    );
  }
}

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
              color: const Color.fromARGB(
                  255, 255, 255, 255), // Keep text color unchanged
              fontSize: 25,
              fontWeight: FontWeight.bold, // Keep font weight unchanged
            ),
          ),
        ),
        if (isSelected)
          Container(
            height: 2, // Height of the blue underline
            width: 75, // Width of the blue underline
            color: Colors.blue, // Color of the underline
          ),
      ],
    );
  }
}

// Custom Painter for Hexagonal Button with Gradient and Border
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
      ..strokeWidth = 2;

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
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
