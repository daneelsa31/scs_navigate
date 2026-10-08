import 'package:flutter/material.dart';
import '../widgets/guide_cards.dart';
import '../models/specialization.dart';
import '../data/specializations_data.dart';

class GuideView extends StatefulWidget {
  final void Function(Specialization) onSpecializationTap;

  const GuideView({super.key, required this.onSpecializationTap});

  @override
  State<GuideView> createState() => _GuideViewState();
}

class _GuideViewState extends State<GuideView> {
  String _selectedProgram = 'BSIS';

  final Set<int> _expandedFaqs = <int>{};
  bool _showAllFaqs = false;
  bool _showAllComparisonRows = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGuideHeader(),
        const SizedBox(height: 30),
        _buildProgramPathwaySection(),
        const SizedBox(height: 30),
        _buildSpecializationsSection(),
        const SizedBox(height: 30),
        _buildComparisonSection(),
        const SizedBox(height: 30),
        _buildFaqSection(),
        const SizedBox(height: 30),
        _buildStudentInsightsSection(),
      ],
    );
  }

  // ============================================================
  // GUIDE HEADER
  // ============================================================

  Widget _buildGuideHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Comprehensive Academic Roadmap',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Color(0xFFFD73A6),
            letterSpacing: -1.0,
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          'SCS GUIDE helps you navigate academic requirements, compare tracks, and select the right specializations based on verified curriculum standards and real senior experiences.',
          style: TextStyle(fontSize: 16, color: Color(0xFF64748B), height: 1.5),
        ),
      ],
    );
  }

  // ============================================================
  // PROGRAM PATHWAY
  // ============================================================

  Widget _buildProgramPathwaySection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF071E4B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 700;

              final programButtons = Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['BSIT', 'BSCS', 'BSIS', 'ACT'].map((program) {
                  final isSelected = _selectedProgram == program;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedProgram = program;
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.white12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        program,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF0F172A)
                              : Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );

              if (isSmall) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text('🎓 ', style: TextStyle(fontSize: 16)),
                        Text(
                          'PROGRAM PATHWAY',
                          style: TextStyle(
                            color: Color(0xFFFD73A6),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    programButtons,
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text('🎓 ', style: TextStyle(fontSize: 16)),
                      Text(
                        'PROGRAM PATHWAY',
                        style: TextStyle(
                          color: Color(0xFFFD73A6),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  programButtons,
                ],
              );
            },
          ),

          const SizedBox(height: 20),

          Text(
            _getProgramTitle(_selectedProgram),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            _getProgramDescription(_selectedProgram),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 22, 49, 104),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'YOU ARE REQUIRED TO TAKE:',
                  style: TextStyle(
                    color: Color.fromARGB(153, 240, 239, 239),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 5),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _getRequiredCourses(_selectedProgram).map((course) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        '•  $course',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                if (_getProgramNote(_selectedProgram).isNotEmpty) ...[
                  const SizedBox(height: 5),

                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Color(0xFFF59E0B),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          _getProgramNote(_selectedProgram),
                          style: const TextStyle(
                            color: Color(0xFFF59E0B),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 16),

                const Text(
                  'YOU MAY CHOOSE FROM THESE SPECIALIZATIONS:',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: _getProgramSpecializations(_selectedProgram).map((
                    spec,
                  ) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF55D95).withValues(alpha: 0.2),
                        border: Border.all(color: const Color(0xFFF55D95)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '✓ $spec',
                        style: const TextStyle(
                          color: Color(0xFFFD73A6),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SPECIALIZATIONS
  // ============================================================

  Widget _buildSpecializationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What do you want to explore?',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          'Discover SCS specializations, program rules, career outlooks, and student insights.',
          style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
        ),

        const SizedBox(height: 24),

        const Text(
          'PRIMARY IT SPECIALIZATIONS YOU CAN CHOOSE FROM',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF94A3B8),
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 16),

        // --------------------------------------------------------
        // PRIMARY SPECIALIZATIONS
        // --------------------------------------------------------
        LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 700;

            final card1 = SpecCard(
              icon: webDevelopmentSpec.icon,
              imagePath: 'assets/images/specializations/web_development.png',
              title: webDevelopmentSpec.title,
              description:
                  'Build websites. Build applications. Build solutions.',
              actionText: 'EXPLORE WEB DEVELOPMENT →',
              onTap: () {
                widget.onSpecializationTap(webDevelopmentSpec);
              },
            );

            final card2 = SpecCard(
              icon: mobileDevelopmentSpec.icon,
              imagePath: 'assets/images/specializations/mobile_development.png',
              title: mobileDevelopmentSpec.title,
              description:
                  'Create cross-platform apps and interactive mobile experiences.',
              actionText: 'EXPLORE MOBILE DEVELOPMENT →',
              onTap: () {
                widget.onSpecializationTap(mobileDevelopmentSpec);
              },
            );

            final card3 = SpecCard(
              icon: cybersecuritySpec.icon,
              imagePath: 'assets/images/specializations/cybersecurity.png',
              title: cybersecuritySpec.title,
              description:
                  'Protect networks, systems, and data from cyber threats.',
              actionText: 'EXPLORE CYBERSECURITY →',
              onTap: () {
                widget.onSpecializationTap(cybersecuritySpec);
              },
            );

            if (isSmall) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  card1,
                  const SizedBox(height: 16),
                  card2,
                  const SizedBox(height: 16),
                  card3,
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: card1),
                const SizedBox(width: 16),
                Expanded(child: card2),
                const SizedBox(width: 16),
                Expanded(child: card3),
              ],
            );
          },
        ),

        const SizedBox(height: 28),

        // --------------------------------------------------------
        // OTHER SPECIALIZATIONS
        // --------------------------------------------------------
        const Text(
          'OTHER PROGRAM SPECIALIZATIONS & ELECTIVES',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF94A3B8),
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 16),

        LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 700;

            return GridView.count(
              crossAxisCount: isSmall ? 1 : 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: isSmall ? 3.2 : 2.3,
              children: const [
                MiniSpecCard(
                  icon: Icons.memory,
                  title: 'Artificial Intelligence',
                  description: 'Engineered intelligence and machine learning.',
                ),
                MiniSpecCard(
                  icon: Icons.analytics_outlined,
                  title: 'Business Analytics',
                  description: 'Bridge technology and business decisions.',
                ),
                MiniSpecCard(
                  icon: Icons.code,
                  title: 'Software Development',
                  description: 'Master object-oriented design and clean code.',
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 16),

        // --------------------------------------------------------
        // PROFESSIONAL ELECTIVE
        // --------------------------------------------------------
        const Text(
          'PROFESSIONAL ELECTIVE',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF94A3B8),
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 16),

        _buildProfessionalElectiveCard(),

        const SizedBox(height: 28),
      ],
    );
  }

  Widget _buildProfessionalElectiveCard() {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: _showProfessionalElectiveDialog,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 480,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7FA),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFF55D95).withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDD9E5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'COURSE OPTION',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFF55D95),
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              const Row(
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    color: Color(0xFFF55D95),
                    size: 24,
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      'Professional Elective',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                'An elective course option that may be taken depending on '
                'your program requirements and available SCS offerings.',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  height: 1.45,
                ),
              ),

              const SizedBox(height: 12),

              TextButton.icon(
                onPressed: _showProfessionalElectiveDialog,
                icon: const Icon(Icons.info_outline_rounded, size: 16),
                label: const Text(
                  'View Details',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFF55D95),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProfessionalElectiveDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDD9E5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.menu_book_outlined,
                            color: Color(0xFFF55D95),
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Expanded(
                          child: Text(
                            'Professional Elective / AIoT',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // WHAT IS IT?
                    const Text(
                      'What is it?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'The Professional Elective is an academic course option '
                      'designed to give students an additional area of learning '
                      'outside the main IT specializations. In the current setup, '
                      'the Professional Elective is AIoT, which introduces students '
                      'to concepts that combine Artificial Intelligence and '
                      'Internet of Things technologies.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'It serves as another structured learning option within the '
                      'program. It allows students to explore a different area of '
                      'computing while still meeting the academic requirements '
                      'of their degree.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // WHO MAY TAKE IT?
                    const Text(
                      'Who may take it?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const _ElectiveBullet(
                      text:
                          'BSIT and BSIS students who choose only one specialization',
                    ),

                    const _ElectiveBullet(
                      text:
                          'BSCS students who choose not to take an IT specialization',
                    ),

                    const _ElectiveBullet(
                      text:
                          'Students whose program pathway requires a Professional Elective to complete the required units or course requirements',
                    ),

                    const SizedBox(height: 20),

                    // WHAT IS AIoT ABOUT?
                    const Text(
                      'What is AIoT about?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'AIoT, or Artificial Intelligence of Things, combines '
                      'connected devices with intelligent systems. It explores '
                      'how devices can collect data, communicate with one another, '
                      'and use intelligent processing to support automation, '
                      'monitoring, and smarter decision-making.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // WHY IS IT PART OF THE PROGRAM?
                    const Text(
                      'Why is it part of the program?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'The Professional Elective gives students another way to '
                      'broaden their technical exposure while completing the '
                      'required academic units of their program. It provides a '
                      'distinct learning experience from the main specialization '
                      'tracks rather than simply acting as a replacement for them.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // NOTE
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Professional Elective requirements are based on the '
                        'student\'s program pathway and the current SCS curriculum.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9D174D),
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // COMPARISON
  // ============================================================

  Widget _buildComparisonSection() {
    final rows = [
      [
        'Best For Students Who...',
        'Enjoy building websites, solving coding problems, and working with both interfaces and databases.',
        'Enjoy creating apps, designing interfaces, and building interactive features for mobile devices.',
        'Enjoy solving technical challenges, investigating systems, networking, Linux, and hands-on security labs.',
      ],
      [
        'Main Focus',
        'Building complete web applications from interface to database.',
        'Building cross-platform apps using Flutter, APIs, databases, maps, and AI features.',
        'Learning how systems are attacked, monitored, investigated, and defended.',
      ],
      [
        'Programming Intensity',
        'High — lots of coding and application building.',
        'High — app development, logic, APIs, and project work.',
        'Medium to High — scripting, automation, security tools, and technical labs.',
      ],
      [
        'UI / Design Focus',
        'Medium to High — web interfaces and turning designs into working pages.',
        'High — responsive layouts, widgets, animations, and mobile interfaces.',
        'Low — more focused on systems, networks, investigation, and security operations.',
      ],
      [
        'Networking / Systems Focus',
        'Low to Medium — mainly web servers and backend systems.',
        'Low to Medium — mostly app and backend integration.',
        'Very High — networking, traffic analysis, Linux, SIEM, and system security.',
      ],
      [
        'Typical Projects / Activities',
        'Web systems, PHP/MySQL applications, database-driven websites, and Laravel projects.',
        'Flutter apps, maps, login systems, backend-connected apps, AI tools, and production-ready mobile projects.',
        'CTFs, ethical hacking labs, vulnerable machines, pentesting, forensics, and red-team/blue-team exercises.',
      ],
      [
        'Possible Career Directions',
        'Frontend Developer, Backend Developer, Full-Stack Developer, PHP Developer, Laravel Developer.',
        'Flutter Developer, Mobile App Developer, Cross-Platform Developer, Mobile UI Developer, Software Developer.',
        'SOC Analyst, Cybersecurity Analyst, Junior Pentester, Incident Response Analyst, Digital Forensics Analyst.',
      ],
      [
        'Primary Technologies',
        'HTML5, CSS3, JavaScript, PHP, MySQL, Apache, Nginx, Laravel.',
        'Flutter, Dart, Riverpod, Supabase, PostgreSQL, REST APIs, Mapbox, Firebase.',
        'Kali Linux, Nmap, Wireshark, Burp Suite, Metasploit, Splunk, Wazuh, Python.',
      ],
    ];

    final visibleRows = _showAllComparisonRows ? rows : rows.take(4).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('⚖️', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Can't decide? Compare them.",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          const Text(
            'Compare the specializations based on what students usually want to know before choosing.',
            style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),

          const SizedBox(height: 18),

          // HEADER
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'CRITERIA',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Web Development',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Mobile Development',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Cybersecurity',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ROWS
          ...visibleRows.map((row) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      row[0],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                        height: 1.4,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    flex: 3,
                    child: Text(
                      row[1],
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF334155),
                        height: 1.45,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    flex: 3,
                    child: Text(
                      row[2],
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF334155),
                        height: 1.45,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    flex: 3,
                    child: Text(
                      row[3],
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF334155),
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 8),

          Center(
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _showAllComparisonRows = !_showAllComparisonRows;
                });
              },
              icon: Icon(
                _showAllComparisonRows
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 18,
              ),
              label: Text(
                _showAllComparisonRows ? 'See less' : 'See more',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFF55D95),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FAQ
  // ============================================================

  Widget _buildFaqSection() {
    final faqs = [
      {
        'question': 'What happens if I only choose one IT specialization?',
        'answer':
            'Depending on official SCS rules, you may need to complement it with an elective course to fulfill total credit requirements.',
      },
      {
        'question':
            'Can CS (Computer Science) students take Cybersecurity subjects?',
        'answer':
            'This may depend on the approved curriculum, prerequisites, and course availability. Please verify the latest SCS curriculum and departmental guidelines.',
      },
      {
        'question':
            'What happens if I shift programs within SCS (e.g., BSCS to BSIT)?',
        'answer':
            'Shifting programs may affect credited subjects, prerequisites, and remaining requirements. The exact evaluation should be confirmed with the SCS department.',
      },
      {
        'question': 'Can I change my specialization after choosing one?',
        'answer':
            'Specialization changes may be subject to program rules, available slots, prerequisites, and departmental approval. Confirm the current policy with SCS before making a change.',
      },
      {
        'question': 'Do I need to take a Professional Elective?',
        'answer':
            'This depends on your program and the number of specializations you take. Review the Program Pathway above and verify the requirement with SCS.',
      },
      {
        'question': 'Where can I check the official curriculum?',
        'answer':
            'Use the latest official SCS curriculum and departmental announcements as the final reference. Information shown in SCS Navigate should be treated as a guide unless explicitly verified.',
      },
    ];

    final visibleCount = _showAllFaqs ? faqs.length : 3;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '❓ Frequently Asked Questions',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Click on any question to view official curriculum answers.',
            style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 18),
          ...List.generate(visibleCount, (index) {
            final faq = faqs[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildFaqItem(
                index: index,
                question: faq['question']!,
                answer: faq['answer']!,
              ),
            );
          }),
          const SizedBox(height: 4),
          Center(
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _showAllFaqs = !_showAllFaqs;
                });
              },
              icon: Icon(
                _showAllFaqs
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 18,
              ),
              label: Text(
                _showAllFaqs ? 'See less' : 'See more',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFF55D95),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem({
    required int index,
    required String question,
    required String answer,
  }) {
    final isExpanded = _expandedFaqs.contains(index);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          setState(() {
            if (isExpanded) {
              _expandedFaqs.remove(index);
            } else {
              _expandedFaqs.add(index);
            }
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isExpanded ? const Color(0xFFF8FAFC) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isExpanded
                  ? const Color(0xFFFB9DBD)
                  : const Color(0xFFE2E8F0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 20,
                    color: const Color(0xFF64748B),
                  ),
                ],
              ),
              if (isExpanded) ...[
                const SizedBox(height: 12),
                Text(
                  answer,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // STUDENT INSIGHTS
  // ============================================================

  Widget _buildStudentInsightsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '💬 Student Insights',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 4),

        const Text(
          'What SCS Seniors Wish They Knew Earlier.',
          style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
        ),

        const SizedBox(height: 16),

        LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 700;

            const insight1 = InsightCard(
              quote:
                  "I wish I knew more about the required skills before picking my track. Building small weekend projects early helps you realize whether you enjoy frontend or databases.",
              author: "— 4th Year BSIT — Web Development Track",
            );

            const insight2 = InsightCard(
              quote:
                  "Participate in at least one COMPASS hackathon per year. The network you build with seniors and industry mentors is priceless.",
              author: "— 4th Year BSIS — Business Analytics",
            );

            if (isSmall) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [insight1, SizedBox(height: 16), insight2],
              );
            }

            return const Row(
              children: [
                Expanded(child: insight1),
                SizedBox(width: 16),
                Expanded(child: insight2),
              ],
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // PROGRAM INFORMATION
  // ============================================================

  String _getProgramTitle(String program) {
    switch (program) {
      case 'BSIT':
        return 'Bachelor of Science in Information Technology (BSIT)';

      case 'BSCS':
        return 'Bachelor of Science in Computer Science (BSCS)';

      case 'BSIS':
        return 'Bachelor of Science in Information Systems (BSIS)';

      case 'ACT':
      default:
        return 'Associate in Computer Technology (ACT)';
    }
  }

  String _getProgramDescription(String program) {
    switch (program) {
      case 'BSIT':
        return 'Focuses on computing infrastructure, software development, and systems administration.';

      case 'BSCS':
        return 'Focuses on computing theories, algorithmic foundations, and advanced software engineering.';

      case 'BSIS':
        return 'Integrates information technology solutions with business processes to help organizations achieve strategic goals.';

      case 'ACT':
      default:
        return 'Two-year practical program covering essential software development and IT infrastructure basics.';
    }
  }

  List<String> _getProgramSpecializations(String program) {
    switch (program) {
      case 'BSIT':
        return [
          'Web Development',
          'Mobile Development',
          'Cybersecurity',
          'AIoT',
        ];

      case 'BSCS':
        return [
          'Artificial Intelligence',
          'Software Development',
          'Cybersecurity',
        ];

      case 'BSIS':
        return [
          'Business Analytics',
          'Web Development',
          'Software Development',
        ];

      case 'ACT':
      default:
        return ['Web Development', 'Application Development'];
    }
  }

  List<String> _getRequiredCourses(String program) {
    switch (program) {
      case 'BSIT':
        return ['Minimum of 1 Specialization', 'Maximum of 2 Specializations'];

      case 'BSCS':
        return ['Artificial Intelligence', 'Maximum of 1 IT Specialization'];

      case 'BSIS':
        return ['Business Analytics', 'Maximum of 1 IT Specialization'];

      case 'ACT':
        return ['Software Development', 'Maximum of 1 IT Specialization'];

      default:
        return [];
    }
  }

  String _getProgramNote(String program) {
    switch (program) {
      case 'BSIT':
        return 'If you opt to enroll in only 1 specialization, you are required to enroll in Proffessional Elective course.';

      case 'BSCS':
        return 'If you opt not to take any specialization, you are required to enroll in Proffessional Elective course.';

      case 'BSIS':
        return 'If you opt not to take any specialization, you are required to enroll in Proffessional Elective course.';

      default:
        return '';
    }
  }
}

class _ElectiveBullet extends StatelessWidget {
  final String text;

  const _ElectiveBullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: Color(0xFFF55D95),
            size: 17,
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF475569),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
