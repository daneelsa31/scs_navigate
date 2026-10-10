import 'package:flutter/material.dart';
import '../models/specialization.dart';
import '../widgets/sample_project_section.dart';
import '../data/student_insights_data.dart';

class SpecializationDetailScreen extends StatefulWidget {
  final Specialization spec;
  final VoidCallback onBack;

  const SpecializationDetailScreen({
    super.key,
    required this.spec,
    required this.onBack,
  });

  @override
  State<SpecializationDetailScreen> createState() =>
      _SpecializationDetailScreenState();
}

class _SpecializationDetailScreenState
    extends State<SpecializationDetailScreen> {
  // 0 = Career Paths
  // 1 = Student Insights
  // 2 = FAQs
  // 3 = Sample Projects
  int _selectedTab = 0;

  final Set<int> _expandedFaqs = <int>{};

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        final isTablet =
            constraints.maxWidth >= 700 && constraints.maxWidth < 1000;

        final horizontalPadding = isMobile
            ? 4.0
            : isTablet
            ? 16.0
            : 12.0;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isMobile ? 0 : 24),
            border: isMobile
                ? null
                : Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isMobile ? 8 : 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopNavigation(isMobile),
                SizedBox(height: isMobile ? 20 : 28),
                _buildHeroSection(isMobile),
                SizedBox(height: isMobile ? 24 : 32),
                _buildWhatIsItSection(isMobile),
                SizedBox(height: isMobile ? 28 : 34),
                _buildWhatWillILearnSection(isMobile),
                SizedBox(height: isMobile ? 20 : 28),
                _buildSkillsAndTechnologySection(isMobile),
                SizedBox(height: isMobile ? 24 : 32),
                _buildIsItForMeSection(isMobile),
                SizedBox(height: isMobile ? 18 : 20),
                _buildExpectSection(isMobile),
                SizedBox(height: isMobile ? 28 : 34),
                _buildTrackDetailsSection(isMobile),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // TOP NAVIGATION
  // ============================================================

  Widget _buildTopNavigation(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton.icon(
          onPressed: widget.onBack,
          icon: const Icon(
            Icons.arrow_back,
            size: 18,
            color: Color(0xFF0F172A),
          ),
          label: Text(
            isMobile ? 'Back' : 'Back to Specializations',
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 18,
              vertical: 10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            side: const BorderSide(color: Color(0xFFD9E2EC)),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // HERO
  // ============================================================

  Widget _buildHeroSection(bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(),
          const SizedBox(height: 14),
          Text(
            widget.spec.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              height: 1.15,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            widget.spec.subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF55D95),
              height: 1.4,
            ),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildIcon(),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.spec.title,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.spec.subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFF55D95),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(widget.spec.icon, color: const Color(0xFFFD73A6), size: 34),
    );
  }

  // ============================================================
  // WHAT IS IT?
  // ============================================================

  Widget _buildWhatIsItSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 18 : 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What is it?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.spec.whatIsIt,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF475569),
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // WHAT WILL I LEARN?
  // ============================================================

  Widget _buildWhatWillILearnSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📖 What will I learn?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 16),
        _buildResponsiveListCards(widget.spec.whatWillILearn, isMobile),
      ],
    );
  }

  Widget _buildResponsiveListCards(List<String> items, bool isMobile) {
    if (isMobile) {
      return Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _buildLearningCard(item),
          );
        }).toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 14,
        mainAxisExtent: 92,
      ),
      itemBuilder: (context, index) {
        return _buildLearningCard(items[index]);
      },
    );
  }

  Widget _buildLearningCard(String item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDCE5EF)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFFF55D95),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF334155),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SKILLS + TECHNOLOGIES
  // ============================================================

  Widget _buildSkillsAndTechnologySection(bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          _buildInfoCard(
            title: '🛠️ SKILLS REQUIRED',
            items: widget.spec.skillsRequired,
            isTechnology: false,
          ),
          const SizedBox(height: 14),
          _buildInfoCard(
            title: '💻 TARGET TECHNOLOGIES',
            items: widget.spec.targetTechnologies,
            isTechnology: true,
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildInfoCard(
            title: '🛠️ SKILLS REQUIRED',
            items: widget.spec.skillsRequired,
            isTechnology: false,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildInfoCard(
            title: '💻 TARGET TECHNOLOGIES',
            items: widget.spec.targetTechnologies,
            isTechnology: true,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<String> items,
    required bool isTechnology,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDCE5EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isTechnology
                      ? const Color(0xFFFDD9E5)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isTechnology
                        ? const Color(0xFFF55D95)
                        : const Color(0xFF334155),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // IS IT FOR ME?
  // ============================================================

  Widget _buildIsItForMeSection(bool isMobile) {
    final bullets = _fitBulletsForSpecialization();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 18 : 22),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8FB),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFF55D95).withValues(alpha: 0.22),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.self_improvement_rounded,
                color: Color(0xFFF55D95),
                size: 22,
              ),
              SizedBox(width: 9),
              Text(
                'IS THIS SPECIALIZATION FOR ME?',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF071E4B),
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.spec.isItForMe,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          ...bullets.map(
            (item) => _buildGuidanceBullet(
              icon: Icons.check_circle_outline_rounded,
              text: item,
              iconColor: const Color(0xFFF55D95),
              textColor: const Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _fitBulletsForSpecialization() {
    final title = widget.spec.title.toLowerCase();

    if (title.contains('web')) {
      return const [
        'You enjoy turning ideas or designs into working websites and web applications.',
        'You are interested in both user interfaces and the logic or databases behind them.',
        'You do not mind debugging code and testing the same feature repeatedly until it works.',
        'You are willing to keep learning because web tools and frameworks change often.',
      ];
    }

    if (title.contains('mobile')) {
      return const [
        'You enjoy building interactive apps that people can use directly on their phones.',
        'You are interested in interface design, app logic, APIs, databases, and device features.',
        'You are comfortable testing layouts and behavior across different screen sizes.',
        'You like project-based work where a feature is designed, coded, tested, and improved.',
      ];
    }

    if (title.contains('cyber')) {
      return const [
        'You enjoy investigating how systems, networks, and applications work behind the scenes.',
        'You are curious about vulnerabilities, defensive tools, Linux, networking, and security labs.',
        'You are patient with troubleshooting and willing to document what you observe and test.',
        'You are comfortable continuously learning because security threats and tools evolve quickly.',
      ];
    }

    return [
      widget.spec.isItForMe,
      'You are willing to practice the listed skills through hands-on exercises and projects.',
      'You are interested in the technologies and career paths connected to this specialization.',
    ];
  }

  // ============================================================
  // WHAT SHOULD I EXPECT?
  // ============================================================

  Widget _buildExpectSection(bool isMobile) {
    final bullets = _expectBulletsForSpecialization();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 18 : 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF071E4B), Color(0xFF0B2A66)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFF55D95).withValues(alpha: 0.20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.route_outlined,
                color: Color(0xFFFD73A6),
                size: 22,
              ),
              SizedBox(width: 9),
              Text(
                'WHAT SHOULD I EXPECT?',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFFD73A6),
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.spec.expectText,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFFD6E0F0),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          ...bullets.map(
            (item) => _buildGuidanceBullet(
              icon: Icons.arrow_right_alt_rounded,
              text: item,
              iconColor: const Color(0xFFFD73A6),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  List<String> _expectBulletsForSpecialization() {
    final title = widget.spec.title.toLowerCase();

    if (title.contains('web')) {
      return const [
        'Regular coding exercises and projects that combine frontend, backend, and database work.',
        'Frequent debugging of browser, server, database, and integration problems.',
        'Building responsive interfaces and connecting them to real application logic.',
        'Team projects, version control, deadlines, and presenting a working web system.',
      ];
    }

    if (title.contains('mobile')) {
      return const [
        'Frequent Flutter or mobile-app coding with reusable screens, widgets, and navigation.',
        'Connecting apps to APIs, authentication, databases, maps, or other device services.',
        'Repeated UI testing and debugging on different devices or emulator sizes.',
        'Project work that requires planning, building, testing, and demonstrating a complete app.',
      ];
    }

    if (title.contains('cyber')) {
      return const [
        'Hands-on labs involving networks, Linux, vulnerable systems, monitoring, or investigation.',
        'Using security tools carefully and explaining what each result means rather than only running commands.',
        'Troubleshooting connectivity, permissions, configurations, and lab-environment issues.',
        'Writing findings, documenting evidence, and communicating security risks clearly.',
      ];
    }

    return [
      widget.spec.expectText,
      'Expect a mix of technical exercises, project work, troubleshooting, and documentation.',
      'You will need consistent practice outside class to become comfortable with the tools.',
    ];
  }

  Widget _buildGuidanceBullet({
    required IconData icon,
    required String text,
    required Color iconColor,
    required Color textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 19),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: textColor,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TRACK DETAILS
  // ============================================================

  Widget _buildTrackDetailsSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Text(
                '🔗 Explore Track Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
            if (!isMobile)
              const Text(
                'Select a tab below',
                style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
              ),
          ],
        ),
        const SizedBox(height: 14),
        _buildTabs(isMobile),
        const SizedBox(height: 18),
        _buildTabContent(isMobile),
      ],
    );
  }

  // ============================================================
  // TABS
  // ============================================================

  // Curriculum has been removed.
  //
  // New tab order:
  // 0 = Career Paths
  // 1 = Student Insights
  // 2 = FAQs
  // 3 = Sample Projects

  Widget _buildTabs(bool isMobile) {
    final tabs = [
      ('Sample Projects', Icons.folder_open_outlined),
      ('Career Paths', Icons.business_center),
      ('Student Insights', Icons.chat_bubble_outline),
      ('FAQs', Icons.help_outline),
    ];

    if (isMobile) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tabs.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          mainAxisExtent: 44,
        ),
        itemBuilder: (context, index) {
          final tab = tabs[index];

          return _buildTabButton(index: index, label: tab.$1, icon: tab.$2);
        },
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tabs.asMap().entries.map((entry) {
        final index = entry.key;
        final tab = entry.value;

        return _buildTabButton(index: index, label: tab.$1, icon: tab.$2);
      }).toList(),
    );
  }

  Widget _buildTabButton({
    required int index,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _selectedTab == index;

    return TextButton.icon(
      onPressed: () {
        setState(() {
          _selectedTab = index;
        });
      },
      icon: Icon(
        icon,
        size: 15,
        color: isSelected ? Colors.white : const Color(0xFF64748B),
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : const Color(0xFF64748B),
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: isSelected
            ? const Color(0xFF0F172A)
            : const Color(0xFFF1F5F9),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      ),
    );
  }

  // ============================================================
  // TAB CONTENT
  // ============================================================

  Widget _buildTabContent(bool isMobile) {
    switch (_selectedTab) {
      case 0:
        return _buildSampleProjectsTab(isMobile);

      case 1:
        return _buildCareerTab(isMobile);

      case 2:
        return _buildStudentInsightsTab();

      case 3:
        return _buildFaqTab();

      default:
        return _buildSampleProjectsTab(isMobile);
    }
  }

  // ============================================================
  // CAREER PATHS
  // ============================================================

  Widget _buildCareerTab(bool isMobile) {
    final paths = widget.spec.careerPaths;

    if (paths.isEmpty) {
      return _buildEmptyTab('No career path information available yet.');
    }

    return Column(
      children: paths.map((career) {
        final title = career['title'] ?? 'Career Path';

        final description =
            career['description'] ??
            career['desc'] ??
            'No description available.';

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(isMobile ? 15 : 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFDCE5EF)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDD9E5),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.work_outline,
                  color: Color(0xFFF55D95),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ============================================================
  // STUDENT INSIGHTS
  // ============================================================

  Widget _buildStudentInsightsTab() {
    final insights = studentInsightsFor(widget.spec.title);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7FA),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFF55D95).withValues(alpha: 0.18),
            ),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.edit_note_rounded,
                color: Color(0xFFF55D95),
                size: 20,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'The entries below are editable sample placeholders. Replace them with verified SCS student insights before publication.',
                  style: TextStyle(
                    color: Color(0xFF9D174D),
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ...insights.map(
          (insight) => Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFDCE5EF)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.format_quote_rounded,
                  color: Color(0xFFF55D95),
                  size: 28,
                ),
                const SizedBox(height: 6),
                Text(
                  insight.quote,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF334155),
                    height: 1.55,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  insight.author,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF071E4B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FAQ
  // ============================================================

  Widget _buildFaqTab() {
    final faqs = [
      {
        'question': 'Is this specialization required?',
        'answer':
            'Program requirements may vary. Please verify the latest official SCS curriculum and departmental guidelines.',
      },
      {
        'question': 'What skills should I develop beforehand?',
        'answer':
            'Start with the skills listed in the Skills Required section above. Building small projects and practicing consistently can help you prepare.',
      },
      {
        'question': 'Can I change my specialization later?',
        'answer':
            'Changes may depend on program rules, prerequisites, available slots, and departmental approval. Confirm the current policy with SCS.',
      },
      {
        'question': 'What technologies should I learn first?',
        'answer':
            'Use the Target Technologies section as a starting point. You do not need to master everything at once; focus first on the fundamentals relevant to your chosen track.',
      },
      {
        'question': 'Are the sample projects official SCS projects?',
        'answer':
            'The projects shown here are sample project ideas intended to illustrate what students could build within the specialization. They are not presented as official SCS projects unless explicitly verified.',
      },
    ];

    return Column(
      children: [
        ...List.generate(faqs.length, (index) {
          final faq = faqs[index];
          final isExpanded = _expandedFaqs.contains(index);

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(14),
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
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: isExpanded ? const Color(0xFFF8FAFC) : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isExpanded
                          ? const Color(0xFFFB9DBD)
                          : const Color(0xFFDCE5EF),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              faq['question']!,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
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
                        const SizedBox(height: 10),
                        Text(
                          faq['answer']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                            height: 1.45,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // ============================================================
  // SAMPLE PROJECTS
  // ============================================================

  Widget _buildSampleProjectsTab(bool isMobile) {
    return SampleProjectSection(
      projects: widget.spec.sampleProjects,
      isMobile: isMobile,
    );
  }

  

  

  // ============================================================
  // EMPTY TAB
  // ============================================================

  Widget _buildEmptyTab(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDCE5EF)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF64748B),
          height: 1.5,
        ),
      ),
    );
  }
}
