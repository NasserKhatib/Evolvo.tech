import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:movies_app/widgets/animated_slogan.dart';
import 'package:movies_app/widgets/protfolio.dart';
import 'package:movies_app/widgets/screens/team.dart';
import 'widgets/app_bar.dart';
import 'widgets/footer.dart';
import 'widgets/hexagonal_background.dart';
import 'widgets/service_card.dart';
import 'widgets/hexagonal_v_painter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ScrollController _scrollController;

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
  }

  Widget _sectionDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 1,
        margin: const EdgeInsets.symmetric(horizontal: 60),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.blue.withOpacity(0.25),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'OriginTech',
            color: Colors.blue,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.55),
            fontSize: 13,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 36,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 32),
      color: Colors.blue.withOpacity(0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(156, 6, 42, 103),
              Color.fromARGB(94, 5, 34, 85),
              Color.fromARGB(74, 2, 15, 39),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Hexagonal Background Right
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: SizedBox(
                width: isMobile ? 60 : 130,
                child: HexagonalBackground(
                  borderColor: Colors.blue,
                  color: Colors.blue,
                  opacity: 0.05,
                  hexagonSize: isMobile ? 38 : 65,
                ),
              ),
            ),

            // Hexagonal Background Left
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: SizedBox(
                width: isMobile ? 50 : 90,
                child: HexagonalBackground(
                  borderColor: Colors.blue,
                  color: Colors.blue,
                  opacity: 0.05,
                  hexagonSize: isMobile ? 38 : 65,
                ),
              ),
            ),

            // Main Content
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // App Bar
                  CustomAppBar(
                    scrollToSection: (offset) {
                      if (offset == 0) {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else if (offset == 1) {
                        _scrollToSection(_aboutKey);
                      } else if (offset == 2) {
                        _scrollToSection(_servicesKey);
                      } else if (offset == 3) {
                        _scrollToSection(_contactKey);
                      } else if (offset == 4) {
                        _scrollToSection(_portfolioKey);
                      }
                    },
                    aboutOffset: 1,
                    servicesOffset: 2,
                    contactOffset: 3,
                    portfolioOffset: 4,
                  ),

                  // ── Hero Section ──────────────────────────────────────
                  SizedBox(
                    height: isMobile ? screenHeight * 0.65 : screenHeight * 0.82,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // EVOLVO Logo with animated hexagon
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "E V ",
                                style: TextStyle(
                                  fontFamily: 'OriginTech',
                                  fontSize: isMobile ? 48 : 82,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: isMobile ? 48 : 82,
                                height: isMobile ? 48 : 82,
                                child: AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return CustomPaint(
                                      painter:
                                          HexagonalVPainter(_animation.value),
                                    );
                                  },
                                ),
                              ),
                              Text(
                                " L V O",
                                style: TextStyle(
                                  fontFamily: 'OriginTech',
                                  fontSize: isMobile ? 48 : 82,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: isMobile ? 12 : 20),

                          // Animated slogan
                          AnimatedSlogan(
                            words: const ['EVOLVE ', 'TO ', 'THE ', 'NEXT ', 'LEVEL'],
                            textStyle: TextStyle(
                              fontSize: isMobile ? 17 : 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                              letterSpacing: 1.5,
                            ),
                          ),

                          SizedBox(height: isMobile ? 30 : 44),

                          // CTA Buttons
                          Wrap(
                            spacing: 16,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () =>
                                    _scrollToSection(_servicesKey),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 24 : 32,
                                    vertical: isMobile ? 12 : 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Text(
                                  'Our Services',
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () =>
                                    _scrollToSection(_portfolioKey),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: BorderSide(
                                    color: Colors.blue.withOpacity(0.7),
                                    width: 1.5,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 24 : 32,
                                    vertical: isMobile ? 12 : 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  'See Our Work',
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  _sectionDivider(),

                  // ── About Section ──────────────────────────────────────
                  Container(
                    key: _aboutKey,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : (isTablet ? 48 : 100),
                      vertical: isMobile ? 40 : 60,
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'About Us',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: isMobile ? 30 : 40,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 50,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Stats Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildStat('150+', 'PROJECTS'),
                            _buildStatDivider(),
                            _buildStat('50+', 'CLIENTS'),
                            _buildStatDivider(),
                            _buildStat('5+', 'YEARS'),
                          ],
                        ),

                        const SizedBox(height: 36),

                        // About text
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 860),
                          child: Column(
                            children: [
                              Text(
                                'Evolvo Technology designs and implements software systems using modern technologies, helping customers and organizations improve performance and organize work. We strive to enhance our knowledge and leadership skills to create synergies between our team and customers. We believe in our potential and want to achieve greatness.',
                                style: TextStyle(
                                  fontSize: isMobile ? 16 : 19,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white.withOpacity(0.8),
                                  height: 1.75,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Our mission is to create economic value through technology. By continuously pushing the boundaries of innovation, we aim to deliver impactful and sustainable solutions that propel businesses forward.',
                                style: TextStyle(
                                  fontSize: isMobile ? 16 : 19,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white.withOpacity(0.8),
                                  height: 1.75,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 36),

                        // Our Team button
                        MouseRegion(
                          onEnter: (_) =>
                              setState(() => _isHovered = true),
                          onExit: (_) =>
                              setState(() => _isHovered = false),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TeamScreen()),
                              );
                            },
                            child: Container(
                              width: 160,
                              height: 50,
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
                                            Colors.blue,
                                            Color.fromARGB(255, 10, 60, 153),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                  borderColor: _isHovered
                                      ? Colors.blue
                                      : Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    'Our Team',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  _sectionDivider(),

                  // ── Services Section ───────────────────────────────────
                  Container(
                    key: _servicesKey,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : (isTablet ? 48 : 80),
                      vertical: isMobile ? 40 : 60,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Services',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: isMobile ? 30 : 40,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 50,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(height: isMobile ? 28 : 40),

                        // Responsive service grid
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final w = constraints.maxWidth;
                            final int cols =
                                w < 650 ? 1 : (w < 1100 ? 2 : 3);
                            const double spacing = 20;
                            final double cardW =
                                (w - spacing * (cols - 1)) / cols;

                            final services = [
                              (FontAwesomeIcons.code, 'Web Development', 'We build responsive and modern web applications tailored to your business needs.'),
                              (FontAwesomeIcons.mobileAlt, 'Mobile Apps', 'We create high-performance cross-platform mobile apps for iOS and Android.'),
                              (FontAwesomeIcons.paintBrush, 'UI/UX Design', 'We design intuitive and user-friendly interfaces that delight users.'),
                              (FontAwesomeIcons.gamepad, 'Game Development', 'We create immersive 2D/3D games for various platforms, including AR, VR, and virtual production.'),
                              (FontAwesomeIcons.brain, 'Artificial Intelligence', 'We develop intelligent systems and machine learning solutions to automate and enhance performance.'),
                              (FontAwesomeIcons.microchip, 'Embedded Systems', 'We empower engineers and makers to revolutionize hardware prototyping and electronics.'),
                            ];

                            return Wrap(
                              spacing: spacing,
                              runSpacing: spacing,
                              children: services
                                  .map((s) => SizedBox(
                                        width: cardW,
                                        child: ServiceCard(
                                          icon: s.$1,
                                          title: s.$2,
                                          description: s.$3,
                                        ),
                                      ))
                                  .toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  _sectionDivider(),

                  // ── Portfolio Section ──────────────────────────────────
                  Container(
                    key: _portfolioKey,
                    padding: EdgeInsets.only(
                      top: isMobile ? 40 : 60,
                      bottom: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Portfolio',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: isMobile ? 30 : 40,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 50,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),

                  PortfolioSection(),

                  const SizedBox(height: 60),

                  _sectionDivider(),

                  // ── Contact Section ────────────────────────────────────
                  Container(
                    key: _contactKey,
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 40 : 60,
                      horizontal: isMobile ? 20 : 80,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Get In Touch',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: isMobile ? 30 : 40,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 50,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: Text(
                            'Ready to bring your ideas to life? Reach out to us and let\'s build something amazing together.',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              color: Colors.white.withOpacity(0.7),
                              height: 1.7,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () async {
                            const url = 'https://wa.me/963982338719';
                            final uri = Uri.parse(url);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            }
                          },
                          icon: const Icon(Icons.message_outlined, size: 20),
                          label: const Text('Contact Us on WhatsApp',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Footer ─────────────────────────────────────────────
                  Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

