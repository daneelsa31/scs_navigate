import 'package:flutter/material.dart';
import '../widgets/clickable_card.dart';

class HomeView extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeView({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 850;

    return Flex(
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: isMobile ? 0 : 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.circle, size: 6, color: Color(0xFF0284C7)),
                    SizedBox(width: 6),
                    Text(
                      'SCS ACADEMIC HUB',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0369A1),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
                    TextSpan(text: 'Your Path.\nYour Skills.\n', style: TextStyle(color: Color(0xFF0F172A))),
                    TextSpan(text: 'Your Future.', style: TextStyle(color: Color(0xFF94A3B8))),
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
              if (isMobile) const SizedBox(height: 40),
            ],
          ),
        ),
        if (!isMobile) const SizedBox(width: 48),
        Expanded(
          flex: isMobile ? 0 : 7,
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool stackCards = constraints.maxWidth < 550;
              return Flex(
                direction: stackCards ? Axis.vertical : Axis.horizontal,
                children: [
                  Expanded(
                    flex: stackCards ? 0 : 1,
                    child: ClickableCard(
                      icon: Icons.menu_book_rounded,
                      iconColor: Colors.white70,
                      backgroundColor: const Color(0xFF0F172A),
                      textColor: Colors.white,
                      title: 'GUIDE',
                      description: 'Understand your academic pathway. Discover skills, technologies, and career outcomes for your program.',
                      bulletPoints: const [
                        'SPECIALIZATIONS & ELECTIVES',
                        'TECHNOLOGY STACKS & SKILLS',
                        'COMPARE MATRIX & CURRICULUM',
                      ],
                      bulletColor: Colors.white38,
                      footerText: 'EXPLORE GUIDE →',
                      footerColor: const Color(0xFF0D9488),
                      onTap: () => onNavigate(1),
                    ),
                  ),
                  SizedBox(width: stackCards ? 0 : 16, height: stackCards ? 16 : 0),
                  Expanded(
                    flex: stackCards ? 0 : 1,
                    child: ClickableCard(
                      icon: Icons.explore_outlined,
                      iconColor: Colors.white70,
                      backgroundColor: const Color(0xFF0F172A),
                      textColor: Colors.white,
                      title: 'COMPASS',
                      description: 'Discover opportunities beyond the classroom. Find hackathons, certifications, and industry seminars.',
                      bulletPoints: const [
                        'HACKATHONS & EVENTS',
                        'SCHOLARSHIP PROGRAMS',
                        'RECOGNITION PROOF SUBMISSIONS',
                      ],
                      bulletColor: Colors.white38,
                      footerText: 'GO TO COMPASS →',
                      footerColor: const Color(0xFF0D9488),
                      onTap: () => onNavigate(2),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}