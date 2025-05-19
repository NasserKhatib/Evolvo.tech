// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movies_app/widgets/app_bar.dart';

import 'package:url_launcher/url_launcher.dart';

class PortfolioSection extends StatefulWidget {
  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  final List<PortfolioItem> items = [
    PortfolioItem(
      android: true,
      iOS: true,
      title: 'IMN',
      imagePath: 'assets/images/imn1.png',
      description:
          'IMN is a social network app that promotes positivity by removing negative feedback. It enables users to connect, learn, and earn through an integrated college feature, turning education into a rewarding experience.',
      details:
          ' A place built on respect and community, where your feed uplifts you, your interactions are meaningful, and your time is educational. ',
      h: 300,
      w: 300,
      p: -100,
    ),
    PortfolioItem(
      android: true,
      iOS: true,
      title: 'foodora',
      imagePath: 'assets/images/imn2.png',
      description:
          'Foodora is a food delivery platform that connects local businesses, skilled riders, and a dedicated team to deliver fast, affordable, and quality meals. It empowers communities by saving valuable time and enhancing everyday experiences, turning every delivery into a positive impact',
      details:
          'A platform  for food delivery that connects local businesses, skilled riders to deliver fast.',
      h: 400,
      w: 320,
      p: -180,
    ),
    PortfolioItem(
      android: false,
      iOS: false,
      title: 'Outer Paradise',
      imagePath: 'assets/images/imn3.png',
      description:
          'Through our partnership with Outer Paradise, we have achieved exceptional quality in both gameplay and graphics. Whether you have a 2D, 3D, XR, or virtual production project in mind, you can count on our collaboration to deliver a high-quality experience that exceeds your expectations.',
      details:
          'where your game ideas are brought to life with creativity and precision',
      h: 420,
      w: 320,
      p: -150,
    ),
  ];
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Wrap(
            spacing: isMobile ? 70 : 40,
            runSpacing: isMobile ? 70 : 40,
            children: items
                .map((item) => _buildPortfolioItem(context, item))
                .toList(),
          ),
          SizedBox(
            height: 40,
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
                      builder: (context) => PortfolioDetailPage(items: items),
                    ),
                  );
                },
                child: Container(
                  width: 175,
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
                      borderColor:
                          _isHovered ? Colors.blue : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        'Portfolio Details',
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
    );
  }

  Widget _buildPortfolioItem(BuildContext context, PortfolioItem item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PortfolioDetailPage(items: items),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none, // Allows the image to overlap the container
        alignment: Alignment.topCenter,
        children: [
          // The card below the image
          Container(
            margin:
                EdgeInsets.only(top: 100), // Space for the image above the card
            width: isMobile ? screenWidth * 0.7 : 300,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blue, // Blue border color
                width: 2, // Border thickness
              ),
            ),
            padding: EdgeInsets.fromLTRB(16, 90, 16, 16), // Space for content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  item.details,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          // The image at the top center
          Positioned(
            top: item.p, // Ensures the image is properly positioned at the top
            child: Container(
              width: item.w, // Adjust size as needed
              height: item.h, // Adjust size as needed

              child: Image.asset(
                item.imagePath,
                fit: BoxFit
                    .cover, // Ensure the image is proportional and fills the circle
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PortfolioDetailPage extends StatefulWidget {
  final List<PortfolioItem> items;

  const PortfolioDetailPage({Key? key, required this.items}) : super(key: key);

  @override
  _PortfolioDetailPageState createState() => _PortfolioDetailPageState();
}

class _PortfolioDetailPageState extends State<PortfolioDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  BoxDecoration _buttonDecorationWithBorder() {
    return BoxDecoration(
      color: Colors.transparent,
      border: Border.all(color: Colors.white, width: 2),
      borderRadius: BorderRadius.circular(30),
    );
  }

  /*Widget _buildPlatformButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    bool _pressed = false;

    return StatefulBuilder(
      builder: (context, setLocalState) {
        return GestureDetector(
          onTap: onPressed,
          onTapDown: (_) => setLocalState(() => _pressed = true),
          onTapUp: (_) => setLocalState(() => _pressed = false),
          onTapCancel: () => setLocalState(() => _pressed = false),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: _pressed ? 0.95 : 1.0),
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Container(
              decoration: _buttonDecorationWithBorder(),
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(
                  icon,
                  color: Colors.white,
                  size: 35,
                ),
                label: Text(label, style: const TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Projects', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black,
                Colors.blue.shade900,
                Colors.blue.shade700,
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.blue.shade900,
              Colors.blue.shade700,
            ],
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(16.0),
          separatorBuilder: (_, __) => Divider(
            color: Colors.black.withOpacity(0.4),
            thickness: 1.5,
            height: 40,
          ),
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final item = widget.items[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: isMobile
                  ? Column(
                      children: [
                        // Image (Mobile)
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _imageSlideAnimation,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: AspectRatio(
                                aspectRatio: item.w /
                                    item.h, // use your item's width & height
                                child: Image.asset(
                                  item.imagePath,
                                  width: double.infinity,
                                  fit: BoxFit
                                      .cover, // still covers, but no cropping
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Title (Mobile)
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _textSlideAnimation,
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Details (Mobile)
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _textSlideAnimation,
                            child: Text(
                              item.details,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Mobile Buttons
                        /*   Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (item.android)
                              _buildPlatformButton(
                                icon: Icons.android,
                                label: 'Android',
                                onPressed: () =>
                                    _launchUrl('https://play.google.com/store'),
                              ),
                            if (item.android && item.iOS)
                              const SizedBox(width: 12),
                            if (item.iOS)
                              _buildPlatformButton(
                                icon: Icons.apple,
                                label: 'iOS',
                                onPressed: () => _launchUrl(
                                    'https://www.apple.com/app-store/'),
                              ),
                          ],
                        ),*/
                      ],
                    )
                  : Row(
                      children: [
                        // Image (Desktop)
                        Expanded(
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _imageSlideAnimation,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  item.imagePath,
                                  width: 500,
                                  height: 400,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        // Description & Buttons (Desktop)
                        Expanded(
                          flex: 2,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _textSlideAnimation,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.blue,
                                      decorationThickness: 1.5,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item.description,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  /*   Row(
                                    children: [
                                      if (item.android)
                                        _buildPlatformButton(
                                          icon: Icons.android,
                                          label: 'Android',
                                          onPressed: () => _launchUrl(
                                              'https://play.google.com/store'),
                                        ),
                                      if (item.android && item.iOS)
                                        const SizedBox(width: 12),
                                      if (item.iOS)
                                        _buildPlatformButton(
                                          icon: Icons.apple,
                                          label: 'iOS',
                                          onPressed: () => _launchUrl(
                                              'https://www.apple.com/app-store/'),
                                        ),
                                    ],
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}

class PortfolioItem {
  final String title;
  final String imagePath;
  final String description;
  final String details;
  final bool android;
  final bool iOS;
  final double h;
  final double w;
  final double p;

  PortfolioItem({
    required this.android,
    required this.iOS,
    required this.p,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.details,
    required this.h,
    required this.w,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
/*import 'package:flutter/material.dart';
import 'package:movies_app/lib/widgets/app_bar.dart';

class PortfolioSection extends StatefulWidget {
  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  final List<PortfolioItem> items = [
    PortfolioItem(
      title: 'IMN',
      imagePath: 'assets/images/imn1.png',
      description:
          'IMN is a social network app that promotes positivity by removing negative feedback. It enables users to connect, learn, and earn through an integrated college feature, turning education into a rewarding experience.',
      details:
          ' A place built on respect and community, where your feed uplifts you, your interactions are meaningful, and your time is educational. ',
      h: 300,
      w: 300,
      p: -100,
    ),
    PortfolioItem(
      title: 'foodora',
      imagePath: 'assets/images/imn2.png',
      description:
          'Foodora is a food delivery platform that connects local businesses, skilled riders, and a dedicated team to deliver fast, affordable, and quality meals. It empowers communities by saving valuable time and enhancing everyday experiences, turning every delivery into a positive impact',
      details:
          'A platform  for food delivery that connects local businesses, skilled riders to deliver fast.',
      h: 400,
      w: 320,
      p: -180,
    ),
    PortfolioItem(
      title: 'Outer Paradise',
      imagePath: 'assets/images/imn3.png',
      description:
          'Through our partnership with Outer Paradise, we have achieved exceptional quality in both gameplay and graphics. Whether you have a 2D, 3D, XR, or virtual production project in mind, you can count on our collaboration to deliver a high-quality experience that exceeds your expectations.',
      details:
          'where your game ideas are brought to life with creativity and precision',
      h: 420,
      w: 320,
      p: -150,
    ),
  ];
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Wrap(
            spacing: isMobile ? 70 : 40,
            runSpacing: isMobile ? 70 : 40,
            children: items
                .map((item) => _buildPortfolioItem(context, item))
                .toList(),
          ),
          SizedBox(
            height: 40,
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
                      builder: (context) => PortfolioDetailPage(items: items),
                    ),
                  );
                },
                child: Container(
                  width: 175,
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
                      borderColor:
                          _isHovered ? Colors.blue : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        'Portfolio Details',
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
    );
  }

  Widget _buildPortfolioItem(BuildContext context, PortfolioItem item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PortfolioDetailPage(items: items),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none, // Allows the image to overlap the container
        alignment: Alignment.topCenter,
        children: [
          // The card below the image
          Container(
            margin:
                EdgeInsets.only(top: 100), // Space for the image above the card
            width: isMobile ? screenWidth * 0.7 : 300,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blue, // Blue border color
                width: 2, // Border thickness
              ),
            ),
            padding: EdgeInsets.fromLTRB(16, 90, 16, 16), // Space for content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  item.details,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          // The image at the top center
          Positioned(
            top: item.p, // Ensures the image is properly positioned at the top
            child: Container(
              width: item.w, // Adjust size as needed
              height: item.h, // Adjust size as needed

              child: Image.asset(
                item.imagePath,
                fit: BoxFit
                    .cover, // Ensure the image is proportional and fills the circle
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PortfolioDetailPage extends StatefulWidget {
  final List<PortfolioItem> items;

  const PortfolioDetailPage({Key? key, required this.items}) : super(key: key);

  @override
  _PortfolioDetailPageState createState() => _PortfolioDetailPageState();
}

class _PortfolioDetailPageState extends State<PortfolioDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0), // Start off-screen to the left
      end: Offset.zero, // Natural position
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0), // Start off-screen to the right
      end: Offset.zero, // Natural position
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully visible
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward(); // Start animations
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Projects',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black,
                Colors.blue.shade900,
                Colors.blue.shade700,
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.blue.shade900,
              Colors.blue.shade700,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: widget.items.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.white.withOpacity(1), // Line between projects
            thickness: 1.5,
            height: 40,
          ),
          itemBuilder: (context, index) {
            final item = widget.items[index];

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white
                    .withOpacity(0.05), // Light background for each project
              ),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image (Mobile Layout)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            item.imagePath,
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Title
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromARGB(255, 5, 44, 172),
                            decorationThickness: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Description
                        Text(
                          item.details,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            height: 1.5,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        // Image (Desktop Layout)
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              item.imagePath,
                              width: 500,
                              height: 400,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        // Description (Desktop Layout)
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                  decorationThickness: 3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}

class PortfolioItem {
  final String title;
  final String imagePath;
  final String description;
  final String details;

  final double h;
  final double w;
  final double p;

  PortfolioItem({
    required this.p,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.details,
    required this.h,
    required this.w,
  });
}
*/