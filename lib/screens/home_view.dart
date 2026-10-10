import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeView({
    super.key,
    required this.onNavigate,
  });

  static const Color navy = Color(0xFF071E4B);
  static const Color pink = Color(0xFFF55D95);
  static const Color deepPink = Color(0xFFE91E63);
  static const Color mutedText = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 850;

        // Reduced height so there is no huge empty gap
        final double heroHeight = isMobile ? 650 : 535;

        return SizedBox(
          width: double.infinity,
          height: heroHeight,
          child: Stack(
            children: [
              // ===================================================
              // BACKGROUND
              // ===================================================

              Positioned.fill(
                child: Image.asset(
                  'assets/images/home_background.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),

              // Slight white overlay so text remains readable
              Positioned.fill(
                child: Container(
                  color: Colors.white.withValues(
                    alpha: 0.04,
                  ),
                ),
              ),

              // ===================================================
              // CONTENT
              // ===================================================

              Positioned.fill(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1500,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : 64,
                        vertical: isMobile ? 28 : 38,
                      ),
                      child: isMobile
                          ? _buildMobileContent()
                          : _buildDesktopContent(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // =============================================================
  // DESKTOP CONTENT
  // =============================================================

  Widget _buildDesktopContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =========================================================
        // SMALL LABEL
        // =========================================================

        const Row(
          children: [
            SizedBox(
              width: 48,
              child: Divider(
                color: pink,
                thickness: 2,
              ),
            ),
            SizedBox(width: 16),
            Text(
              'SCHOOL OF COMPUTER STUDIES',
              style: TextStyle(
                color: navy,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.2,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // =========================================================
        // HERO TITLE
        // =========================================================

        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 58,
                fontWeight: FontWeight.w800,
                height: 1.02,
                letterSpacing: -2,
              ),
              children: [
                TextSpan(
                  text: 'Your Comprehensive\n',
                  style: TextStyle(
                    color: navy,
                  ),
                ),
                TextSpan(
                  text: 'Academic Roadmap',
                  style: TextStyle(
                    color: deepPink,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // =========================================================
        // DESCRIPTION
        // =========================================================

        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 610,
          ),
          child: const Text(
            'Helping SCS students explore pathways, '
            'specializations, and opportunities.',
            style: TextStyle(
              color: mutedText,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              height: 1.45,
            ),
          ),
        ),

        const SizedBox(height: 30),

        // =========================================================
        // GUIDE + COMPASS
        // =========================================================

        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1080,
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildNavigationCard(
                  icon: Icons.menu_book_rounded,
                  title: 'GUIDE',
                  subtitle:
                      'Programs, pathways,\nand specializations',
                  accentColor: pink,
                  onTap: () => onNavigate(1),
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: _buildNavigationCard(
                  icon: Icons.explore_rounded,
                  title: 'COMPASS',
                  subtitle:
                      'Opportunities beyond\nthe classroom',
                  accentColor: navy,
                  onTap: () => onNavigate(2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =============================================================
  // MOBILE CONTENT
  // =============================================================

  Widget _buildMobileContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SCHOOL OF COMPUTER STUDIES',
          style: TextStyle(
            color: navy,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.6,
          ),
        ),

        const SizedBox(height: 16),

        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              height: 1.04,
              letterSpacing: -1.4,
            ),
            children: [
              TextSpan(
                text: 'Your Comprehensive\n',
                style: TextStyle(
                  color: navy,
                ),
              ),
              TextSpan(
                text: 'Academic Roadmap',
                style: TextStyle(
                  color: deepPink,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Helping SCS students explore pathways, '
          'specializations, and opportunities.',
          style: TextStyle(
            color: mutedText,
            fontSize: 15,
            height: 1.45,
          ),
        ),

        const SizedBox(height: 28),

        _buildNavigationCard(
          icon: Icons.menu_book_rounded,
          title: 'GUIDE',
          subtitle:
              'Programs, pathways, and specializations',
          accentColor: pink,
          onTap: () => onNavigate(1),
        ),

        const SizedBox(height: 14),

        _buildNavigationCard(
          icon: Icons.explore_rounded,
          title: 'COMPASS',
          subtitle:
              'Opportunities beyond the classroom',
          accentColor: navy,
          onTap: () => onNavigate(2),
        ),
      ],
    );
  }

  // =============================================================
  // NAVIGATION CARD
  // =============================================================

  Widget _buildNavigationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 120,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(
              alpha: 0.78,
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white.withValues(
                alpha: 0.92,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF55D95)
                    .withValues(alpha: 0.07),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              // ===================================================
              // ICON
              // ===================================================

              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: accentColor.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: accentColor,
                ),
              ),

              const SizedBox(width: 20),

              // ===================================================
              // TEXT
              // ===================================================

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: mutedText,
                        fontSize: 14,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // ===================================================
              // ARROW
              // ===================================================

              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(
                    alpha: 0.45,
                  ),
                  border: Border.all(
                    color: accentColor.withValues(
                      alpha: 0.32,
                    ),
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: accentColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}