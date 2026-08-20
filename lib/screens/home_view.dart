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
        Flexible(
          flex: isMobile ? 1 : 5,
          fit: isMobile ? FlexFit.loose : FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
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
              if (isMobile) const SizedBox(height: 40),
            ],
          ),
        ),
        if (!isMobile) const SizedBox(width: 48),
        Flexible(
          flex: isMobile ? 1 : 7,
          fit: isMobile ? FlexFit.loose : FlexFit.tight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool stackCards = constraints.maxWidth < 550;
              return Flex(
                direction: stackCards ? Axis.vertical : Axis.horizontal,
                children: [
                  Flexible(
                    flex: 1,
                    fit: stackCards ? FlexFit.loose : FlexFit.tight,
                    child: ClickableCard(
                      icon: Icons.menu_book_rounded,
                      iconColor: Colors.white70,
                      backgroundColor: const Color(0xFF071E4B),
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
                      footerColor: const Color(0xFFF55D95),
                      onTap: () => onNavigate(1),
                    ),
                  ),
                  SizedBox(width: stackCards ? 0 : 16, height: stackCards ? 16 : 0),
                  Flexible(
                    flex: 1,
                    fit: stackCards ? FlexFit.loose : FlexFit.tight,
                    child: ClickableCard(
                      icon: Icons.explore_outlined,
                      iconColor: Colors.white70,
                      backgroundColor: const Color(0xFF071E4B),
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
                      footerColor: const Color(0xFFF55D95),
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