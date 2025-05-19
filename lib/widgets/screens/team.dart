import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/widgets/hexagonal_background.dart';

import 'package:url_launcher/url_launcher.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    // Sample team members data
    final List<Map<String, String>> teamMembers = [
      {
        'name': 'Nasser Khtib',
        'role': 'CEO/Project Manager/Software Engineer',
        'description': 'Leading technical vision and business strategy.',
        'image': 'assets/images/na.png',
      },
      {
        'name': 'Hasan Marrawi',
        'role': 'CTO/Software Engineer',
        'description': 'Overseeing architecture and technical delivery.',
        'image': 'assets/images/hus4.jpg',
      },
      {
        'name': 'Muhammad Ghaith Modarati',
        'role': 'Embedded Systems Engineering Lead',
        'description': 'Designing PCBs and firmware for IoT devices.',
        'image': 'assets/images/mda.jpg',
      },
      {
        'name': 'Mahmood Reda',
        'role': 'Embedded Systems Engineering Lead',
        'description': 'Specialist in drone systems and automation.',
        'image': 'assets/images/rda.jpg',
      },
      {
        'name': 'Mostafa Al Afandī',
        'role': 'Full-Stack IoT Lead',
        'description': 'Building end-to-end web and IoT integrations.',
        'image': 'assets/images/mo.jpg',
      },
      {
        'name': 'Youssef Dashak',
        'role': 'UX/UI Designer',
        'description': 'Crafting user experiences and digital identities.',
        'image': 'assets/images/y1.jpg',
      },
      {
        'name': 'Kamal Fansa',
        'role': 'Marketing Associate',
        'description': 'Driving growth through strategic campaigns.',
        'image': 'assets/images/kf.jpg',
      },
      {
        'name': 'Outer Paradise Games Studio',
        'role': 'Strategic Partner',
        'description':
            'Our game development partner specializing in interactive experiences.',
        'image': 'assets/images/outer.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Team', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
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
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
            // Hexagonal Background on Right
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: isMobile ? 80 : 150,
                child: HexagonalBackground(
                  color: Colors.blue,
                  opacity: 0.06,
                  hexagonSize: isMobile ? 40 : 70,
                  borderColor: Colors.blue,
                  borderWidth: 1.0,
                  borderOpacity: 0.2,
                ),
              ),
            ),
            // Hexagonal Background on Left
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: isMobile ? 60 : 100,
                child: HexagonalBackground(
                  color: Colors.blue,
                  opacity: 0.06,
                  hexagonSize: isMobile ? 40 : 70,
                  borderColor: Colors.blue,
                  borderWidth: 1.0,
                  borderOpacity: 0.2,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Text('Our Team',
                        style: TextStyle(
                          fontSize: isMobile ? 24 : 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 20,
                      children: teamMembers.map((member) {
                        return HexagonalCell(
                          name: member['name']!,
                          role: member['role']!,
                          description: member['description']!,
                          imageUrl: member['image']!,
                        );
                      }).toList(),
                    ),
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

// Custom Hexagonal Cell Widget
class HexagonalCell extends StatefulWidget {
  final String name;
  final String role;
  final String description;
  final String imageUrl;
  //final String linkedinUrl;
  //final String facebook;

  const HexagonalCell({
    Key? key,
    required this.name,
    required this.role,
    required this.description,
    required this.imageUrl,
    //required this.linkedinUrl,
    //required this.facebook,
  }) : super(key: key);

  @override
  _HexagonalCellState createState() => _HexagonalCellState();
}

class _HexagonalCellState extends State<HexagonalCell> {
  bool _isHovered = false;
  bool _isLinkedInHovered = false;
  bool _isFacebookHovered = false;

  /*Future<void> _launchLinkedInUrl() async {
    final Uri url = Uri.parse(widget.linkedinUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppBrowserView);
    }
  }*/

  /*Future<void> _launchFacebookUrl() async {
    final Uri url = Uri.parse(widget.facebook);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppBrowserView);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        children: [
          ClipPath(
            clipper: HexagonClipper(),
            child: Container(
              width: isMobile ? 115 : 150,
              height: isMobile ? 125 : 175,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                border: Border.all(
                  color: Colors.black.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(widget.imageUrl, fit: BoxFit.cover),
                  ),
                  AnimatedOpacity(
                    opacity: _isHovered ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /* MouseRegion(
                              onEnter: (_) =>
                                  setState(() => _isLinkedInHovered = true),
                              onExit: (_) =>
                                  setState(() => _isLinkedInHovered = false),
                              child: GestureDetector(
                                onTap: () {},
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: Icon(
                                    FontAwesomeIcons.linkedin,
                                    color: _isLinkedInHovered
                                        ? Colors.lightBlue
                                        : Colors.blue,
                                    size: _isLinkedInHovered ? 28 : 24,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),*/
                            /*  MouseRegion(
                              onEnter: (_) =>
                                  setState(() => _isFacebookHovered = true),
                              onExit: (_) =>
                                  setState(() => _isFacebookHovered = false),
                              child: GestureDetector(
                                onTap: () {},
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: Icon(
                                    FontAwesomeIcons.facebook,
                                    color: _isFacebookHovered
                                        ? Colors.lightBlue
                                        : Colors.blue,
                                    size: _isFacebookHovered ? 28 : 24,
                                  ),
                                ),
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(widget.name,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          Text(widget.role,
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 4),
          Text(widget.description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white54, fontSize: 10)),
        ],
      ),
    );
  }
}

// Hexagon Clipper
class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height * 0.75);
    path.lineTo(0, size.height * 0.25);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
