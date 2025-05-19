import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/widgets/animated_slogan.dart';
import 'package:movies_app/widgets/protfolio.dart';
import 'package:movies_app/widgets/screens/team.dart';
import 'widgets/app_bar.dart';
import 'widgets/contact_form.dart';
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

  // Keys to calculate offsets for each section
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _portfolioKey =
      GlobalKey(); // Add a key for the portfolio section
  bool _isHovered = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
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

  // Scroll to a specific section
  void _scrollToSection(GlobalKey key) {
    final BuildContext? context = key.currentContext;
    if (context != null) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final offset = box.localToGlobal(Offset.zero).dy;

      _scrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600; // Check if the device is a mobile
    final isTablet = screenWidth >= 600 &&
        screenWidth < 1200; // Check if the device is a tablet

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(156, 6, 42, 103),
              Color.fromARGB(94, 5, 34, 85),
              Color.fromARGB(74, 2, 15, 39),
              /*  Colors.black,
              Colors.black,
              Colors.black,*/
            ],
          ),
        ),
        child: Stack(
          children: [
            // Hexagonal Background on Top Right (Full Height)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0, // Span from top to bottom
              child: Container(
                width: isMobile ? 80 : 150, // Adjust width for mobile
                child: HexagonalBackground(
                  borderColor: Colors.blue,
                  color: Colors.blue, // Hexagon color
                  opacity: 0.06,
                  hexagonSize:
                      isMobile ? 40 : 70, // Adjust hexagon size for mobile
                ),
              ),
            ),

            // Hexagonal Background on Top Left (Full Height)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0, // Span from top to bottom
              child: Container(
                width: isMobile ? 60 : 100, // Adjust width for mobile
                child: HexagonalBackground(
                  borderColor: Colors.blue,
                  color: Colors.blue, // Hexagon color
                  opacity: 0.06,
                  hexagonSize:
                      isMobile ? 40 : 70, // Adjust hexagon size for mobile
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
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else if (offset == 1) {
                        _scrollToSection(_aboutKey);
                      } else if (offset == 2) {
                        _scrollToSection(_servicesKey);
                      } else if (offset == 3) {
                        _scrollToSection(_contactKey);
                      } else if (offset == 4) {
                        _scrollToSection(_portfolioKey); // Scroll to portfolio
                      }
                    },
                    aboutOffset: 1,
                    servicesOffset: 2,
                    contactOffset: 3,
                    portfolioOffset: 4, // Add portfolio offset
                  ),

                  // Hero Section
                  Container(
                    height: isMobile
                        ? screenHeight * 0.6
                        : screenHeight * 0.8, // Adjust height for mobile
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "E V ",
                                style: TextStyle(
                                  fontFamily: 'OriginTech',
                                  fontSize: isMobile
                                      ? 50
                                      : 80, // Adjust font size for mobile
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: isMobile
                                    ? 50
                                    : 80, // Adjust size for mobile
                                height: isMobile ? 50 : 80,
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
                                  fontSize: isMobile
                                      ? 50
                                      : 80, // Adjust font size for mobile
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: isMobile
                                  ? 10
                                  : 20), // Adjust spacing for mobile
                          AnimatedSlogan(
                            words: ["EVOLVE ", "TO ", "THE ", "NEXT ", "LEVEL"],
                            textStyle: TextStyle(
                              fontSize: isMobile
                                  ? 18
                                  : 26, // Adjust font size for mobile
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  // About Section
                  Container(
                    key: _aboutKey,
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          isMobile ? 10 : 20, // Adjust padding for mobile
                      vertical: isMobile ? 20 : 40,
                    ),
                    width: double.infinity, // Ensure full width
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'About Us',
                            style: TextStyle(
                              color: Colors.blue,

                              fontSize: isMobile
                                  ? 30
                                  : 40, // Adjust font size for mobile
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        // Adjust spacing for mobile
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15, bottom: 0),
                          child: Text(
                            'Evolvo Technology designs and implements software systems using modern technologies, helping customers and organizations improve performance and organize work. We strive to enhance our knowledge and leadership skills to create synergies between our team and customers. We believe in our potential and want to achieve greatness.',
                            style: TextStyle(
                              fontSize: isMobile
                                  ? 18
                                  : 22, // Adjust font size for mobile
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              height: 1.6, // Line height for better readability
                            ),
                          ),
                        ),
                        // Adjust spacing for mobile
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            'Our mission is to create economic value through technology. By continuously pushing the boundaries of innovation, we aim to deliver impactful and sustainable solutions that propel businesses forward.',
                            style: TextStyle(
                              fontSize: isMobile
                                  ? 18
                                  : 22, // Adjust font size for mobile
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              height: 1.6,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: MouseRegion(
                            onEnter: (_) => setState(() => _isHovered = true),
                            onExit: (_) => setState(() => _isHovered = false),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TeamScreen()),
                                );
                              },
                              child: Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: const Offset(5, 5),
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
                                        fontSize: isMobile ? 18 : 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                  SizedBox(
                    height: 20,
                  ),

                  // Services Section
                  Container(
                    key: _servicesKey,
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          isMobile ? 10 : 20, // Adjust padding for mobile
                      vertical: isMobile ? 20 : 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Services',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: isMobile
                                  ? 30
                                  : 40, // Adjust font size for mobile
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: isMobile
                                ? 10
                                : 20), // Adjust spacing for mobile
                        Wrap(
                          spacing:
                              isMobile ? 10 : 20, // Adjust spacing for mobile
                          runSpacing: isMobile ? 10 : 20,
                          children: [
                            ServiceCard(
                              icon: FontAwesomeIcons.code,
                              title: 'Web Development',
                              description:
                                  'We build responsive and modern web applications.',
                            ),
                            ServiceCard(
                              icon: FontAwesomeIcons.mobileAlt,
                              title: 'Mobile Apps',
                              description:
                                  'We create cross-platform mobile apps.',
                            ),
                            ServiceCard(
                              icon: FontAwesomeIcons.paintBrush,
                              title: 'UI/UX Design',
                              description:
                                  'We design intuitive and user-friendly interfaces.',
                            ),
                            ServiceCard(
                              icon: FontAwesomeIcons.gamepad,
                              title: 'Game Development',
                              description:
                                  'We create immersive and engaging 2D/3D games for various platforms, in addition to AR, VR, and virtual production.',
                            ),
                            ServiceCard(
                              icon: FontAwesomeIcons.brain,
                              title: 'Artificial Intelligence',
                              description:
                                  'We develop intelligent systems and machine learning solutions to automate processes and enhance performance.',
                            ),
                            ServiceCard(
                              icon: FontAwesomeIcons.microchip,
                              title: 'Embedded Systems',
                              description:
                                  'We empower engineers, makers, and artists to revolutionize hardware prototyping and the electronics industry.',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    key: _portfolioKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Portfolio',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: isMobile
                                ? 30
                                : 40, // Adjust font size for mobile
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Portfolio Section

                  PortfolioSection(), // Add the portfolio section

                  SizedBox(
                    height: screenHeight * 0.35,
                  ),

                  // Contact Section
                  Container(
                    key: _contactKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Adjust spacing for mobile
                        // ContactForm(),
                      ],
                    ),
                  ),

                  // Footer
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
