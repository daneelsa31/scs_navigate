import 'package:flutter/material.dart';
import '../models/specialization.dart';
import '../models/sample_project.dart';

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
              color: Color(0xFF0D9488),
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
                  color: Color(0xFF0D9488),
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
      child: Icon(widget.spec.icon, color: const Color(0xFF2DD4BF), size: 34),
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
            color: Color(0xFF0D9488),
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
                      ? const Color(0xFFCCFBF1)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isTechnology
                        ? const Color(0xFF0D9488)
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFCD34D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💡 IS IT FOR ME?',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF92400E),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            widget.spec.isItForMe,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF92400E),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // WHAT SHOULD I EXPECT?
  // ============================================================

  Widget _buildExpectSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 17 : 20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '⚠️ WHAT SHOULD I EXPECT?',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2DD4BF),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            widget.spec.expectText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.45,
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
                  color: const Color(0xFFCCFBF1),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.work_outline,
                  color: Color(0xFF0D9488),
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
    return _buildEmptyTab(
      'Student insights will be available here once verified SCS senior experiences are added.',
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
                          ? const Color(0xFF99F6E4)
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
    final projects = widget.spec.sampleProjects;

    if (projects.isEmpty) {
      return _buildEmptyTab(
        'No sample projects have been added for this specialization yet.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDFA),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF99F6E4)),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFF0D9488), size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'These are sample project ideas that can help you understand the kind of work you may encounter in this specialization.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF0F766E),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (isMobile)
          Column(children: projects.map(_buildSampleProjectCard).toList())
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 330,
            ),
            itemBuilder: (context, index) {
              return _buildSampleProjectCard(projects[index]);
            },
          ),
      ],
    );
  }

  Widget _buildSampleProjectCard(SampleProject project) {
    final hasImage =
        project.mediaType.toLowerCase() == 'image' &&
        project.imageUrl != null &&
        project.imageUrl!.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      height: 330,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCE5EF)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 135,
            width: double.infinity,
            child: hasImage
                ? Image.network(
                    project.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildProjectMediaPlaceholder(project.mediaType);
                    },
                  )
                : _buildProjectMediaPlaceholder(project.mediaType),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    project.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: project.technologies.map((technology) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCCFBF1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          technology,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0D9488),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  if ((project.githubUrl ?? '').trim().isNotEmpty ||
                      (project.demoUrl ?? '').trim().isNotEmpty)
                    Row(
                      children: [
                        if ((project.githubUrl ?? '').trim().isNotEmpty)
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.code, size: 15),
                            label: const Text(
                              'GitHub',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        if ((project.githubUrl ?? '').trim().isNotEmpty &&
                            (project.demoUrl ?? '').trim().isNotEmpty)
                          const SizedBox(width: 8),
                        if ((project.demoUrl ?? '').trim().isNotEmpty)
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.open_in_new, size: 15),
                            label: const Text(
                              'Demo',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectMediaPlaceholder(String mediaType) {
    final isVideo = mediaType.toLowerCase() == 'video';

    return Container(
      color: const Color(0xFFF8FAFC),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isVideo
                  ? Icons.play_circle_outline_rounded
                  : Icons.image_outlined,
              size: 38,
              color: const Color(0xFF94A3B8),
            ),
            const SizedBox(height: 7),
            Text(
              isVideo ? 'PROJECT VIDEO' : 'PROJECT PREVIEW',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF94A3B8),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
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
