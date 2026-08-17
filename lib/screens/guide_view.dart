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
        const SizedBox(height: 32),
        _buildProgramPathwaySection(),
        const SizedBox(height: 48),
        _buildSpecializationsSection(),
        const SizedBox(height: 48),
        _buildComparisonSection(),
        const SizedBox(height: 48),
        _buildFaqSection(),
        const SizedBox(height: 48),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFCCFBF1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.menu_book_rounded, size: 14, color: Color(0xFF0D9488)),
              SizedBox(width: 6),
              Text(
                'SCS GUIDE — ACADEMIC PATHWAY HUB',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F766E),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Your Comprehensive Academic Roadmap',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
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
        color: const Color(0xFF0F172A),
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
                            color: Color(0xFF2DD4BF),
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
                          color: Color(0xFF2DD4BF),
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
              color: const Color(0xFF1E293B),
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
                        color: const Color(0xFF0D9488).withValues(alpha: 0.2),
                        border: Border.all(color: const Color(0xFF0D9488)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '✓ $spec',
                        style: const TextStyle(
                          color: Color(0xFF2DD4BF),
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
          'PRIMARY IT SPECIALIZATIONS',
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
              title: mobileDevelopmentSpec.title,
              description:
                  'Create native and cross-platform mobile apps for millions of users.',
              actionText: 'EXPLORE MOBILE DEVELOPMENT →',
              onTap: () {
                widget.onSpecializationTap(mobileDevelopmentSpec);
              },
            );

            final card3 = SpecCard(
              icon: cybersecuritySpec.icon,
              title: cybersecuritySpec.title,
              description:
                  'Protect networks, data, and systems from emerging cyber threats.',
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
        // PROFESSIONAL ELECTIVE
        // --------------------------------------------------------
        const Text(
          'COURSE',
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

            final courseCard = SpecCard(
              icon: aiotSpec.icon,
              title: aiotSpec.title,
              description:
                  'Bridging embedded devices and artificial intelligence.',
              actionText: 'EXPLORE AIoT →',
              onTap: () {
                widget.onSpecializationTap(aiotSpec);
              },
            );

            if (isSmall) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [courseCard],
              );
            }

            return Row(
              children: [
                Expanded(child: courseCard),
                const SizedBox(width: 16),
                const Expanded(child: SizedBox.shrink()),
                const SizedBox(width: 16),
                const Expanded(child: SizedBox.shrink()),
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
              childAspectRatio: isSmall ? 2.5 : 1.3,
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
      ],
    );
  }

  // ============================================================
  // COMPARISON
  // ============================================================

  Widget _buildComparisonSection() {
    final allRows = <DataRow>[
      const DataRow(
        cells: [
          DataCell(
            Text('Main Focus', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataCell(Text('Web apps, UI/UX, and cloud APIs')),
          DataCell(Text('Native & cross-platform apps')),
          DataCell(Text('Network defense & system security')),
        ],
      ),
      const DataRow(
        cells: [
          DataCell(
            Text(
              'Programming Depth',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataCell(Text('High (Full Stack / OOP)')),
          DataCell(Text('High (Full Stack / Mobile OOP)')),
          DataCell(Text('Medium (Scripting & Automation)')),
        ],
      ),
      const DataRow(
        cells: [
          DataCell(
            Text(
              'UI / UX Focus',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataCell(
            Text(
              '✓ High',
              style: TextStyle(
                color: Color(0xFF0D9488),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DataCell(
            Text(
              '✓ High',
              style: TextStyle(
                color: Color(0xFF0D9488),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DataCell(Text('✕ Low')),
        ],
      ),
      const DataRow(
        cells: [
          DataCell(
            Text(
              'Networking Focus',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataCell(Text('✕ Low')),
          DataCell(Text('✕ Low')),
          DataCell(
            Text(
              '✓ High',
              style: TextStyle(
                color: Color(0xFF0D9488),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      const DataRow(
        cells: [
          DataCell(
            Text(
              'Primary Tech Stack',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataCell(Text('HTML, CSS, JS, TypeScript, React')),
          DataCell(Text('Kotlin, Java, Dart, Flutter')),
          DataCell(Text('Wireshark, Linux, Nmap, Metasploit')),
        ],
      ),
    ];

    // Show only the first 3 rows initially.
    final visibleRows = _showAllComparisonRows
        ? allRows
        : allRows.take(3).toList();

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
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('⚖️ ', style: TextStyle(fontSize: 18)),
              SizedBox(width: 4),
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
            'Comparing core primary specializations side by side.',
            style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),

          const SizedBox(height: 24),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
              columns: const [
                DataColumn(
                  label: Text(
                    'CRITERIA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Web Development',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Mobile Development',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Cybersecurity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
              ],
              rows: visibleRows,
            ),
          ),

          const SizedBox(height: 12),

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
                foregroundColor: const Color(0xFF0D9488),
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
                foregroundColor: const Color(0xFF0D9488),
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
                  ? const Color(0xFF99F6E4)
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
        return [
          'Artificial Intelligence',
          'Maximum of 1 Specialization or Professional Elective Course',
        ];

      case 'BSIS':
        return [
          'Business Analytics',
          'Maximum of 1 Specialization or Professional Elective Course',
        ];

      case 'ACT':
        return [
          'Software Development',
          'Maximum of 1 Specialization or Professional Elective Course',
        ];

      default:
        return [];
    }
  }

  String _getProgramNote(String program) {
    switch (program) {
      case 'BSIT':
        return 'If you only choose to enroll 1 specialization, you will have to take Prof Elec';

      case 'BSIS':
        return 'BSIS students combine core business strategy with IT systems development. [To be verified with SCS]';

      default:
        return '';
    }
  }
}
