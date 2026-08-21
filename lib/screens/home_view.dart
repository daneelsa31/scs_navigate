import 'package:flutter/material.dart';
import '../widgets/clickable_card.dart';

class HomeView extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeView({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 850;
        final cards = [
          _buildCard(
            icon: Icons.menu_book_rounded,
            title: 'GUIDE',
            description: 'Understand your academic pathway. Discover skills, technologies, and career outcomes for your program.',
            bulletPoints: const [
              'SPECIALIZATIONS & ELECTIVES',
              'TECHNOLOGY STACKS & SKILLS',
              'COMPARE MATRIX & CURRICULUM',
            ],
            footerText: 'EXPLORE GUIDE ->',
            onTap: () => onNavigate(1),
          ),
          _buildCard(
            icon: Icons.explore_outlined,
            title: 'COMPASS',
            description: 'Discover opportunities beyond the classroom. Find hackathons, certifications, and industry seminars.',
            bulletPoints: const [
              'HACKATHONS & EVENTS',
              'SCHOLARSHIP PROGRAMS',
              'RECOGNITION PROOF SUBMISSIONS',
            ],
            footerText: 'GO TO COMPASS ->',
            onTap: () => onNavigate(2),
          ),
        ];

        final introduction = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.5,
                    height: 1.05,
                    fontFamily: 'sans-serif',
                  ),
                  children: [
                    TextSpan(text: 'Your Path.\nYour Skills.\n', style: TextStyle(color: Color(0xFF071E4B))),
                    TextSpan(text: 'Your Future.', style: TextStyle(color: Color(0xFFF55D95))),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Explore SCS specializations and discover\nverified technology-related opportunities.',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),
            ],
          );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [introduction, ...cards.expand((card) => [card, const SizedBox(height: 16)])],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 5, child: introduction),
            const SizedBox(width: 48),
            Expanded(
              flex: 7,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: cards[0]),
                  const SizedBox(width: 16),
                  Expanded(child: cards[1]),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
    required List<String> bulletPoints,
    required String footerText,
    required VoidCallback onTap,
  }) {
    return ClickableCard(
      icon: icon,
      iconColor: Colors.white,
      backgroundColor: const Color(0xFF071E4B),
      textColor: Colors.white,
      title: title,
      description: description,
      bulletPoints: bulletPoints,
      bulletColor: const Color(0xFFF55D95),
      footerText: footerText,
      footerColor: const Color(0xFFF55D95),
      onTap: onTap,
    );
  }
}