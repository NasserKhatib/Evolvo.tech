// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movies_app/widgets/app_bar.dart';
import 'package:movies_app/l10n/strings.dart';

class PortfolioSection extends StatefulWidget {
  final bool isArabic;
  const PortfolioSection({this.isArabic = false});

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  List<PortfolioItem> _buildItems(AppStrings s) => [
    PortfolioItem(
      android: true,
      iOS: true,
      title: 'IMN',
      imagePath: 'assets/images/imn1.png',
      category: s.imnCategory,
      description: s.imnDescription,
      details: s.imnDetails,
    ),
    PortfolioItem(
      android: true,
      iOS: true,
      title: 'Foodora',
      imagePath: 'assets/images/imn2.png',
      category: s.foodoraCategory,
      description: s.foodoraDescription,
      details: s.foodoraDetails,
    ),
    PortfolioItem(
      android: false,
      iOS: false,
      title: 'Outer Paradise',
      imagePath: 'assets/images/imn3.png',
      category: s.outerParadiseCategory,
      description: s.outerParadiseDescription,
      details: s.outerParadiseDetails,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final s = AppStrings(widget.isArabic);
    final items = _buildItems(s);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 60,
        vertical: 20,
      ),
      child: Column(
        children: [
          // Responsive portfolio grid
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final int cols = w < 650 ? 1 : (w < 1100 ? 2 : 3);
              const double spacing = 24;
              final double cardW = (w - spacing * (cols - 1)) / cols;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: items
                    .map((item) => _PortfolioCard(
                          item: item,
                          width: cardW,
                          viewDetailsLabel: s.viewDetails,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PortfolioDetailPage(
                                items: items,
                                isArabic: widget.isArabic,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              );
            },
          ),

          const SizedBox(height: 48),

          // View All button
          _ViewAllButton(
            label: s.viewAllProjects,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PortfolioDetailPage(
                  items: items,
                  isArabic: widget.isArabic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Portfolio Card ─────────────────────────────────────────────────────────────

class _PortfolioCard extends StatefulWidget {
  final PortfolioItem item;
  final double width;
  final VoidCallback onTap;
  final String viewDetailsLabel;

  const _PortfolioCard({
    required this.item,
    required this.width,
    required this.onTap,
    this.viewDetailsLabel = 'View Details',
  });

  @override
  State<_PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<_PortfolioCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          width: widget.width,
          transform: _hovered
              ? (Matrix4.identity()..translate(0.0, -8.0))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: const Color(0xFF060E1B),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? Colors.blue
                  : Colors.blue.withOpacity(0.18),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? Colors.blue.withOpacity(0.25)
                    : Colors.blue.withOpacity(0.04),
                blurRadius: _hovered ? 24 : 8,
                spreadRadius: _hovered ? 2 : 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with overlay on hover
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      widget.item.imagePath,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    // Hover overlay
                    Positioned.fill(
                      child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _hovered ? 1.0 : 0.0,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue.withOpacity(0.5),
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.open_in_new_rounded,
                            color: Colors.white,
                            size: 44,
                          ),
                        ),
                      ),
                    ),
                    ), // Positioned.fill
                    // Category badge
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.item.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Card body
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            widget.item.title,
                            style: TextStyle(
                              color: _hovered
                                  ? const Color(0xFF90CAF9)
                                  : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                        // Platform icons
                        if (widget.item.android)
                          const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(Icons.android,
                                color: Color(0xFF3DDC84), size: 20),
                          ),
                        if (widget.item.iOS)
                          const Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Icon(Icons.apple,
                                color: Colors.white70, size: 20),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.item.details,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.white.withOpacity(0.5),
                        height: 1.6,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Text(
                          widget.viewDetailsLabel,
                          style: TextStyle(
                            color: _hovered
                                ? Colors.blue
                                : Colors.blue.withOpacity(0.6),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 14,
                          color: _hovered
                              ? Colors.blue
                              : Colors.blue.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── View All Button ────────────────────────────────────────────────────────────

class _ViewAllButton extends StatefulWidget {
  final VoidCallback onTap;
  final String label;
  const _ViewAllButton({required this.onTap, this.label = 'View All Projects'});

  @override
  State<_ViewAllButton> createState() => _ViewAllButtonState();
}

class _ViewAllButtonState extends State<_ViewAllButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 190,
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(_hovered ? 0.35 : 0.15),
                blurRadius: _hovered ? 20 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CustomPaint(
            painter: HexagonalButtonPainter(
              gradient: _hovered
                  ? null
                  : const LinearGradient(
                      colors: [Colors.blue, Color(0xFF0A3CD1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderColor: _hovered ? Colors.blue : Colors.transparent,
            ),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Portfolio Detail Page ──────────────────────────────────────────────────────

class PortfolioDetailPage extends StatefulWidget {
  final List<PortfolioItem> items;
  final bool isArabic;

  const PortfolioDetailPage({Key? key, required this.items, this.isArabic = false}) : super(key: key);

  @override
  _PortfolioDetailPageState createState() => _PortfolioDetailPageState();
}

class _PortfolioDetailPageState extends State<PortfolioDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;

    final s = AppStrings(widget.isArabic);
    return Directionality(
      textDirection: widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
      backgroundColor: const Color(0xFF020B18),
      appBar: AppBar(
        backgroundColor: const Color(0xFF060E1B),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            widget.isArabic
                ? Icons.arrow_forward_ios_rounded
                : Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          s.ourProjects,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.blue.withOpacity(0.15),
            height: 1,
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 60,
              vertical: 40,
            ),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return _ProjectDetailCard(
                item: item,
                index: index,
                isMobile: isMobile,
                isReversed: index % 2 == 1 && !isMobile,
                availableOnLabel: s.availableOn,
              );
            },
          ),
        ),
      ),
    ),  // Scaffold
    ); // Directionality
  }
}

// ── Project Detail Card ────────────────────────────────────────────────────────

class _ProjectDetailCard extends StatelessWidget {
  final PortfolioItem item;
  final int index;
  final bool isMobile;
  final bool isReversed;
  final String availableOnLabel;

  const _ProjectDetailCard({
    required this.item,
    required this.index,
    required this.isMobile,
    required this.isReversed,
    this.availableOnLabel = 'AVAILABLE ON',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project number + divider
          Row(
            children: [
              Text(
                '0${index + 1}',
                style: const TextStyle(
                  fontFamily: 'OriginTech',
                  color: Colors.blue,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Content: image + text
          isMobile
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final imageWidget = _buildImage(context);
    final textWidget = _buildText(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isReversed
          ? [
              Expanded(flex: 5, child: textWidget),
              const SizedBox(width: 48),
              Expanded(flex: 5, child: imageWidget),
            ]
          : [
              Expanded(flex: 5, child: imageWidget),
              const SizedBox(width: 48),
              Expanded(flex: 5, child: textWidget),
            ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(context),
        const SizedBox(height: 24),
        _buildText(context),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Image.asset(
          item.imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Text(
            item.category,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Title
        Text(
          item.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),

        // Blue underline
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),

        // Description
        Text(
          item.description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.7),
            height: 1.8,
          ),
        ),
        const SizedBox(height: 24),

        // Platform badges
        if (item.android || item.iOS) ...[
          Text(
            availableOnLabel,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (item.android)
                _PlatformBadge(
                  icon: Icons.android,
                  label: 'Android',
                  color: const Color(0xFF3DDC84),
                ),
              if (item.android && item.iOS) const SizedBox(width: 10),
              if (item.iOS)
                _PlatformBadge(
                  icon: Icons.apple,
                  label: 'iOS',
                  color: Colors.white70,
                ),
            ],
          ),
        ],
      ],
    );
  }
}

// ── Platform Badge ─────────────────────────────────────────────────────────────

class _PlatformBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _PlatformBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Portfolio Item Data ────────────────────────────────────────────────────────

class PortfolioItem {
  final String title;
  final String imagePath;
  final String description;
  final String details;
  final String category;
  final bool android;
  final bool iOS;

  PortfolioItem({
    required this.title,
    required this.imagePath,
    required this.description,
    required this.details,
    this.category = 'App',
    this.android = false,
    this.iOS = false,
  });
}
