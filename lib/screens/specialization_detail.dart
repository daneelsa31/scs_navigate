import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  static const navy = Color(0xFF0F172A);
  static const pink = Color(0xFFF55D95);
  static const lightPink = Color(0xFFFDD9E5);
  static const textGray = Color(0xFF64748B);
  static const border = Color(0xFFDCE5EF);
  static const softBackground = Color(0xFFF8FAFC);

  int _selectedTab = 0;
  final Set<int> _expandedFaqs = {};

  // ============================================================
  // PPT LINKS
  // Replace these with your actual links later.
  // ============================================================

  static const webPresentationLink =
      'https://drive.google.com/file/d/1Aq6G4fEfFZXlCAMQoZhKX0Mx_3_OVIVX/view?usp=sharing';

  static const mobilePresentationLink =
      'https://ahdzlee.github.io/usjr-mobile-cybsec-track/';

  static const cybersecurityPresentationLink =
      'https://ahdzlee.github.io/usjr-mobile-cybsec-track/';

  // ============================================================
  // CONTENT SELECTOR
  // ============================================================

  _SpecializationContent get content {
    final title = widget.spec.title.toLowerCase();

    if (title.contains('web')) return _webContent;
    if (title.contains('mobile')) return _mobileContent;
    if (title.contains('cyber')) return _cyberContent;

    return _SpecializationContent(
      title: widget.spec.title,
      subtitle: widget.spec.subtitle,
      whatIsIt: widget.spec.whatIsIt,
      whatWillILearn: widget.spec.whatWillILearn,
      recommendedSkills: widget.spec.skillsRequired,
      targetTechnologies: widget.spec.targetTechnologies,
      isItForMe: widget.spec.isItForMe,
      expectText: widget.spec.expectText,
      careerPaths: widget.spec.careerPaths,
      presentationUrl: '',
    );
  }

  // ============================================================
  // WEB DEVELOPMENT
  // ============================================================

  static const _webContent = _SpecializationContent(
    title: 'Web Development',
    subtitle:
        'Build complete web applications from interface to database.',

    whatIsIt:
        'Web Development is about creating websites and web applications '
        'that people can use through a browser. In this specialization, you '
        'will learn how to build the visible part of a website, write the '
        'logic behind it, connect it to a database, and use web frameworks '
        'to make development more organized and efficient.',

    whatWillILearn: [
      'Build websites and web applications.',
      'Turn designs and wireframes into working interfaces.',
      'Write server-side code using PHP.',
      'Connect applications to databases.',
      'Process forms and user input.',
      'Apply Object-Oriented Programming in web development.',
      'Create reusable code and classes.',
      'Use web frameworks such as Laravel.',
      'Build secure, database-driven web applications.',
    ],

    recommendedSkills: [
      'Basic to intermediate HTML',
      'Basic to intermediate CSS',
      'Basic JavaScript',
      'Programming fundamentals',
      'Object-Oriented Programming',
      'Basic database concepts',
      'SQL basics',
      'Problem-solving and debugging',
    ],

    targetTechnologies: [
      'HTML5',
      'CSS3',
      'JavaScript',
      'PHP',
      'MySQL',
      'Apache',
      'Nginx',
      'Laravel',
      'ORM',
      'MVC',
    ],

    isItForMe:
        'This specialization may be a good fit if you enjoy creating '
        'websites, turning designs into working systems, solving programming '
        'problems, and working with both user interfaces and databases. '
        'You may especially enjoy Web Development if you like seeing your '
        'code turn into something visible and usable in a browser.',

    expectText:
        'Expect a lot of coding and application building. You will start '
        'with server-side programming and database integration, then move '
        'into OOP and reusable code, and later use frameworks such as '
        'Laravel to build larger and more organized applications. You should '
        'also be comfortable debugging code and improving applications until '
        'they work correctly.',

    careerPaths: [
      {
        'title': 'Frontend Developer',
        'description':
            'Builds the parts of websites and web applications that users directly see and interact with.',
      },
      {
        'title': 'Backend Developer',
        'description':
            'Works on server-side logic, databases, APIs, and the systems behind a web application.',
      },
      {
        'title': 'Full-Stack Developer',
        'description':
            'Works on both the frontend and backend parts of a complete web application.',
      },
      {
        'title': 'Web Application Developer',
        'description':
            'Builds and maintains browser-based software applications.',
      },
      {
        'title': 'PHP Developer',
        'description':
            'Develops server-side web applications and backend features using PHP.',
      },
      {
        'title': 'Laravel Developer',
        'description':
            'Builds organized PHP applications using the Laravel framework.',
      },
      {
        'title': 'Web Systems Developer',
        'description':
            'Creates database-driven systems and services that run through the web.',
      },
      {
        'title': 'Junior Software Developer',
        'description':
            'Works on software projects using programming, databases, debugging, and application design skills.',
      },
      {
        'title': 'Web Support / Maintenance Developer',
        'description':
            'Maintains existing websites, fixes issues, and improves features over time.',
      },
    ],

    presentationUrl: webPresentationLink,
  );

  // ============================================================
  // MOBILE APPLICATIONS DEVELOPMENT
  // ============================================================

  static const _mobileContent = _SpecializationContent(
    title: 'Mobile Applications Development',
    subtitle:
        'Build the Future of Mobile — One Codebase, Infinite Possibilities.',

    whatIsIt:
        'Mobile Applications Development focuses on creating applications '
        'using Flutter and Dart. With Flutter, one codebase can be used to '
        'build applications for multiple platforms. The specialization '
        'covers user interface design, app logic, backend services, APIs, '
        'authentication, databases, maps, AI features, testing, and deployment.',

    whatWillILearn: [
      'Build mobile applications using Flutter and Dart.',
      'Create responsive and user-friendly interfaces.',
      'Work with widgets, navigation, forms, and animations.',
      'Manage data and app state.',
      'Connect apps to online APIs and backend services.',
      'Add login and user authentication.',
      'Connect apps to databases.',
      'Add maps and location-based features.',
      'Add AI and machine learning features.',
      'Test and organize larger applications.',
      'Prepare applications for deployment.',
    ],

    recommendedSkills: [
      'Basic programming fundamentals',
      'Basic Object-Oriented Programming',
      'Variables, functions, classes, and control structures',
      'Basic UI/UX awareness',
      'Basic Git and GitHub familiarity',
      'Problem-solving and debugging',
      'Willingness to learn Dart and Flutter',
      'Ability to work independently and in a team',
    ],

    targetTechnologies: [
      'Flutter',
      'Dart',
      'Provider',
      'Riverpod',
      'Supabase',
      'PostgreSQL',
      'REST APIs',
      'Dio',
      'Mapbox',
      'TensorFlow Lite',
      'Google ML Kit',
      'OpenAI API',
      'Firebase',
      'Git',
      'GitHub',
      'GitHub Actions',
    ],

    isItForMe:
        'This specialization may be a good fit if you enjoy creating '
        'applications that people can use on phones, designing interfaces, '
        'and building interactive features. You may especially enjoy Mobile '
        'Development if you like seeing your work run as a real app and want '
        'to build features such as login systems, maps, real-time updates, '
        'APIs, or AI-powered tools.',

    expectText:
        'Expect a project-heavy specialization. You will begin by learning '
        'Flutter and app interfaces, then connect apps to APIs, authentication, '
        'databases, and maps. Later, you will work with AI/ML features, '
        'architecture, testing, CI/CD, and deployment. The specialization '
        'includes individual work, group projects, and a production-ready '
        'capstone application.',

    careerPaths: [
      {
        'title': 'Flutter Developer',
        'description':
            'Builds cross-platform applications using Flutter and Dart.',
      },
      {
        'title': 'Mobile Application Developer',
        'description':
            'Designs, develops, tests, and maintains applications for mobile devices.',
      },
      {
        'title': 'Cross-Platform App Developer',
        'description':
            'Creates applications that can run on multiple platforms from one shared codebase.',
      },
      {
        'title': 'Junior Mobile Software Developer',
        'description':
            'Supports mobile app development through coding, debugging, testing, and feature implementation.',
      },
      {
        'title': 'Mobile UI Developer',
        'description':
            'Focuses on building responsive and user-friendly mobile interfaces.',
      },
      {
        'title': 'Mobile Frontend Developer',
        'description':
            'Builds the user-facing part of mobile applications and connects it to backend services.',
      },
      {
        'title': 'App Integration Developer',
        'description':
            'Connects mobile apps to APIs, authentication, databases, maps, and other services.',
      },
      {
        'title': 'Mobile Full-Stack Developer',
        'description':
            'Works on both the mobile application and its backend services.',
      },
      {
        'title': 'Mobile Solutions Developer',
        'description':
            'Creates mobile-based solutions for business, education, productivity, and other needs.',
      },
      {
        'title': 'Software Developer',
        'description':
            'Uses programming, architecture, testing, and development skills in broader software projects.',
      },
    ],

    presentationUrl: mobilePresentationLink,
  );

  // ============================================================
  // CYBERSECURITY
  // ============================================================

  static const _cyberContent = _SpecializationContent(
    title: 'Cybersecurity',
    subtitle: 'Think. Hack. Defend.',

    whatIsIt:
        'Cybersecurity is about protecting computers, networks, applications, '
        'and data from attacks. In this specialization, you will learn both '
        'how attackers find weaknesses and how defenders detect, investigate, '
        'and respond to threats. The track is highly hands-on and uses '
        'Capture The Flag challenges, vulnerable machines, and red-team/'
        'blue-team exercises in controlled environments.',

    whatWillILearn: [
      'Understand how attackers find weaknesses in systems.',
      'Practice ethical hacking in controlled environments.',
      'Scan networks and identify vulnerabilities.',
      'Test web applications for common security issues.',
      'Analyze network traffic.',
      'Monitor security alerts and logs.',
      'Investigate cybersecurity incidents.',
      'Perform basic digital forensics.',
      'Analyze suspicious files and malware.',
      'Respond to security incidents.',
      'Design safer and more secure systems.',
      'Automate security tasks using scripts.',
      'Explore security research and threat analysis.',
    ],

    recommendedSkills: [
      'Networking fundamentals',
      'Basic TCP/IP knowledge',
      'Basic understanding of the OSI model',
      'Basic network troubleshooting',
      'Linux command-line basics',
      'Basic scripting',
      'Python fundamentals',
      'Analytical thinking',
      'Problem-solving',
      'Attention to detail',
      'Strong sense of ethics and responsible system use',
    ],

    targetTechnologies: [
      'Kali Linux',
      'Metasploit',
      'Burp Suite',
      'Nmap',
      'Wireshark',
      'Splunk',
      'Wazuh',
      'Zeek',
      'NetworkMiner',
      'Autopsy',
      'Volatility',
      'Ghidra',
      'Hashcat',
      'John the Ripper',
      'Python',
      'Go',
      'Docker',
      'DVWA',
      'Metasploitable',
      'VulnHub',
    ],

    isItForMe:
        'This specialization may be a good fit if you enjoy solving technical '
        'problems, investigating how systems work, understanding how attacks '
        'happen, and learning how to defend against them. You may especially '
        'enjoy Cybersecurity if you like networking, Linux, troubleshooting, '
        'puzzles, CTFs, investigation, or hands-on lab work.',

    expectText:
        'Expect a very hands-on specialization. You will perform ethical '
        'hacking in controlled environments, investigate attacks, analyze logs '
        'and network traffic, work with forensic tools, participate in CTFs, '
        'and practice both offensive and defensive security. You should also '
        'expect strict ethical rules and only work on systems where testing is '
        'properly authorized.',

    careerPaths: [
      {
        'title': 'SOC Analyst',
        'description':
            'Monitors security alerts and investigates suspicious activity in a Security Operations Center.',
      },
      {
        'title': 'Cybersecurity Analyst',
        'description':
            'Helps identify risks, monitor systems, investigate threats, and protect digital assets.',
      },
      {
        'title': 'Junior Penetration Tester',
        'description':
            'Tests authorized systems for security weaknesses and reports what needs to be fixed.',
      },
      {
        'title': 'Vulnerability Assessment Analyst',
        'description':
            'Identifies and evaluates weaknesses in systems and applications.',
      },
      {
        'title': 'Incident Response Analyst',
        'description':
            'Investigates cybersecurity incidents and helps contain and recover from attacks.',
      },
      {
        'title': 'Digital Forensics Analyst',
        'description':
            'Examines digital evidence, devices, logs, memory, and other data during investigations.',
      },
      {
        'title': 'Security Operations Analyst',
        'description':
            'Supports monitoring, detection, investigation, and response activities.',
      },
      {
        'title': 'Threat Hunting Analyst',
        'description':
            'Searches systems and security data for threats that may not have been detected automatically.',
      },
      {
        'title': 'Junior Malware Analyst',
        'description':
            'Studies suspicious software to understand what it does and how it affects systems.',
      },
      {
        'title': 'Security Engineer',
        'description':
            'Builds and maintains tools and systems used to improve organizational security.',
      },
      {
        'title': 'Security Automation Engineer',
        'description':
            'Uses scripts and automation to make security monitoring and response more efficient.',
      },
      {
        'title': 'DevSecOps Security Analyst',
        'description':
            'Helps include security practices throughout the software development process.',
      },
      {
        'title': 'Security Researcher',
        'description':
            'Studies vulnerabilities, threats, attack methods, and new ways to improve security.',
      },
      {
        'title': 'Security Architect',
        'description':
            'Designs secure systems and helps organizations plan stronger security structures.',
      },
    ],

    presentationUrl: cybersecurityPresentationLink,
  );

  // ============================================================
  // PAGE BUILD
  // ============================================================

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
    return OutlinedButton.icon(
      onPressed: widget.onBack,
      icon: const Icon(
        Icons.arrow_back,
        size: 18,
        color: navy,
      ),
      label: Text(
        isMobile ? 'Back' : 'Back to Specializations',
        style: const TextStyle(
          color: navy,
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
        side: const BorderSide(
          color: Color(0xFFD9E2EC),
        ),
      ),
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
            content.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: navy,
              height: 1.15,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            content.subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: pink,
              height: 1.4,
            ),
          ),

          if (content.presentationUrl.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildPresentationButton(),
          ],
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIcon(),
        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content.title,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: navy,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                content.subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: pink,
                ),
              ),

              if (content.presentationUrl.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildPresentationButton(),
              ],
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
        color: navy,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(
        widget.spec.icon,
        color: const Color(0xFFFD73A6),
        size: 34,
      ),
    );
  }

  Widget _buildPresentationButton() {
    return OutlinedButton.icon(
      onPressed: () => _openLink(content.presentationUrl),
      icon: const Icon(
        Icons.slideshow_outlined,
        size: 18,
      ),
      label: const Text(
        'View Specialization Presentation',
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: pink,
        side: const BorderSide(color: pink),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ============================================================
  // WHAT IS IT
  // ============================================================

  Widget _buildWhatIsItSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 18 : 20),
      decoration: BoxDecoration(
        color: softBackground,
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
              color: navy,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            content.whatIsIt,
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
  // WHAT WILL I LEARN
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
            color: navy,
          ),
        ),

        const SizedBox(height: 16),

        _buildResponsiveListCards(
          content.whatWillILearn,
          isMobile,
        ),
      ],
    );
  }

  Widget _buildResponsiveListCards(
    List<String> items,
    bool isMobile,
  ) {
    if (isMobile) {
      return Column(
        children: items
            .map(
              (item) => Padding(
                padding:
                    const EdgeInsets.only(bottom: 10),
                child: _buildLearningCard(item),
              ),
            )
            .toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 14,
        mainAxisExtent: 92,
      ),
      itemBuilder: (_, index) {
        return _buildLearningCard(
          items[index],
        );
      },
    );
  }

  Widget _buildLearningCard(String item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: pink,
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
  // RECOMMENDED SKILLS + TECHNOLOGIES
  // ============================================================

  Widget _buildSkillsAndTechnologySection(
    bool isMobile,
  ) {
    final skills = _buildInfoCard(
      title: '🛠️ RECOMMENDED SKILLS',
      items: content.recommendedSkills,
      isTechnology: false,
    );

    final technologies = _buildInfoCard(
      title: '💻 TARGET TECHNOLOGIES',
      items: content.targetTechnologies,
      isTechnology: true,
    );

    if (isMobile) {
      return Column(
        children: [
          skills,
          const SizedBox(height: 14),
          technologies,
        ],
      );
    }

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Expanded(child: skills),
        const SizedBox(width: 16),
        Expanded(child: technologies),
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
        color: softBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textGray,
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isTechnology
                      ? lightPink
                      : const Color(0xFFF1F5F9),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w600,
                    color: isTechnology
                        ? pink
                        : const Color(
                            0xFF334155,
                          ),
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
  // IS IT FOR ME
  // ============================================================

  Widget _buildIsItForMeSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFCD34D),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
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
            content.isItForMe,
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
  // WHAT SHOULD I EXPECT
  // ============================================================

  Widget _buildExpectSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.all(isMobile ? 17 : 20),
      decoration: BoxDecoration(
        color: navy,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            '⚠️ WHAT SHOULD I EXPECT?',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFD73A6),
            ),
          ),

          const SizedBox(height: 9),

          Text(
            content.expectText,
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

  Widget _buildTrackDetailsSection(
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                '🔗 Explore Track Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
            ),

            if (!isMobile)
              const Text(
                'Select a tab below',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF94A3B8),
                ),
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

  Widget _buildTabs(bool isMobile) {
    final tabs = [
      (
        'Sample Projects',
        Icons.folder_open_outlined,
      ),
      (
        'Possible Career Paths',
        Icons.business_center,
      ),
      (
        'Student Insights',
        Icons.chat_bubble_outline,
      ),
      (
        'FAQs',
        Icons.help_outline,
      ),
    ];

    if (isMobile) {
      return GridView.builder(
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(),
        itemCount: tabs.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          mainAxisExtent: 48,
        ),
        itemBuilder: (_, index) {
          return _buildTabButton(
            index: index,
            label: tabs[index].$1,
            icon: tabs[index].$2,
          );
        },
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          tabs.asMap().entries.map((entry) {
        return _buildTabButton(
          index: entry.key,
          label: entry.value.$1,
          icon: entry.value.$2,
        );
      }).toList(),
    );
  }

  Widget _buildTabButton({
    required int index,
    required String label,
    required IconData icon,
  }) {
    final selected = _selectedTab == index;

    return TextButton.icon(
      onPressed: () {
        setState(() {
          _selectedTab = index;
        });
      },
      icon: Icon(
        icon,
        size: 15,
        color:
            selected ? Colors.white : textGray,
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color:
              selected ? Colors.white : textGray,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: selected
            ? navy
            : const Color(0xFFF1F5F9),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),
    );
  }

  Widget _buildTabContent(bool isMobile) {
    switch (_selectedTab) {
      case 0:
        return _buildSampleProjectsTab(
          isMobile,
        );
      case 1:
        return _buildCareerTab(isMobile);
      case 2:
        return _buildStudentInsightsTab();
      case 3:
        return _buildFaqTab();
      default:
        return _buildSampleProjectsTab(
          isMobile,
        );
    }
  }

  // ============================================================
  // POSSIBLE CAREER PATHS
  // ============================================================

  Widget _buildCareerTab(bool isMobile) {
    final paths = content.careerPaths;

    if (paths.isEmpty) {
      return _buildEmptyTab(
        'No possible career path information available yet.',
      );
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin:
              const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: lightPink,
            borderRadius:
                BorderRadius.circular(14),
            border: Border.all(
              color:
                  pink.withValues(alpha: .35),
            ),
          ),
          child: const Text(
            'These are possible career paths related to the skills developed '
            'in this specialization. Career opportunities may vary depending '
            'on experience, additional skills, certifications, and employer requirements.',
            style: TextStyle(
              color: Color(0xFF9D174D),
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ),

        ...paths.map((career) {
          final title =
              career['title'] ?? 'Career Path';

          final description =
              career['description'] ??
              career['desc'] ??
              'No description available.';

          return Container(
            width: double.infinity,
            margin:
                const EdgeInsets.only(bottom: 12),
            padding:
                EdgeInsets.all(isMobile ? 15 : 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(14),
              border:
                  Border.all(color: border),
            ),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: lightPink,
                    borderRadius:
                        BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.work_outline,
                    color: pink,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight:
                              FontWeight.bold,
                          color: navy,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: textGray,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
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
        'question':
            'Is this specialization required?',
        'answer':
            'Program requirements may vary. Please verify the latest official SCS curriculum and departmental guidelines.',
      },
      {
        'question':
            'What skills should I develop beforehand?',
        'answer':
            'Use the Recommended Skills section above as preparation guidance. '
            'These skills can help you prepare and should not automatically be '
            'treated as formal prerequisites unless specifically stated by SCS.',
      },
      {
        'question':
            'Can I change my specialization later?',
        'answer':
            'Changes may depend on program rules, prerequisites, available slots, '
            'and departmental approval. Confirm the current policy with SCS.',
      },
      {
        'question':
            'What technologies should I learn first?',
        'answer':
            'Use the Target Technologies section as a starting point. You do not '
            'need to master everything at once; focus first on the fundamentals.',
      },
      {
        'question':
            'Are the listed career paths guaranteed jobs?',
        'answer':
            'No. They are possible career directions related to the skills '
            'developed in the specialization. Actual opportunities depend on '
            'your experience, skills, portfolio, certifications, and employer requirements.',
      },
      {
        'question':
            'Are the sample projects official SCS projects?',
        'answer':
            'The projects shown here are sample project ideas intended to help '
            'students understand the kind of work they may encounter. They are '
            'not official SCS projects unless explicitly identified as such.',
      },
    ];

    return Column(
      children:
          List.generate(faqs.length, (index) {
        final faq = faqs[index];
        final expanded =
            _expandedFaqs.contains(index);

        return Padding(
          padding:
              const EdgeInsets.only(bottom: 10),
          child: Material(
            color: Colors.transparent,
            borderRadius:
                BorderRadius.circular(14),
            child: InkWell(
              onTap: () {
                setState(() {
                  expanded
                      ? _expandedFaqs
                          .remove(index)
                      : _expandedFaqs
                          .add(index);
                });
              },
              borderRadius:
                  BorderRadius.circular(14),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: expanded
                      ? softBackground
                      : Colors.white,
                  borderRadius:
                      BorderRadius.circular(14),
                  border: Border.all(
                    color: expanded
                        ? const Color(
                            0xFFFB9DBD,
                          )
                        : border,
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            faq['question']!,
                            style:
                                const TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.w600,
                              color: navy,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Icon(
                          expanded
                              ? Icons
                                  .keyboard_arrow_up_rounded
                              : Icons
                                  .keyboard_arrow_down_rounded,
                          size: 20,
                          color: textGray,
                        ),
                      ],
                    ),

                    if (expanded) ...[
                      const SizedBox(height: 10),

                      Text(
                        faq['answer']!,
                        style:
                            const TextStyle(
                          fontSize: 12,
                          color: textGray,
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
    );
  }

  // ============================================================
  // SAMPLE PROJECTS
  // ============================================================

  Widget _buildSampleProjectsTab(
    bool isMobile,
  ) {
    final projects =
        widget.spec.sampleProjects;

    if (projects.isEmpty) {
      return _buildEmptyTab(
        'No sample projects have been added for this specialization yet.',
      );
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: lightPink,
            borderRadius:
                BorderRadius.circular(14),
            border: Border.all(
              color:
                  const Color(0xFFFB9DBD),
            ),
          ),
          child: const Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: pink,
                size: 20,
              ),

              SizedBox(width: 10),

              Expanded(
                child: Text(
                  'These are sample project ideas that can help you understand '
                  'the kind of work you may encounter in this specialization.',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        Color(0xFF9D174D),
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        if (isMobile)
          Column(
            children: projects
                .map(_buildSampleProjectCard)
                .toList(),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 330,
            ),
            itemBuilder: (_, index) {
              return _buildSampleProjectCard(
                projects[index],
              );
            },
          ),
      ],
    );
  }

  Widget _buildSampleProjectCard(
    SampleProject project,
  ) {
    final hasImage =
        project.mediaType.toLowerCase() ==
                'image' &&
            project.imageUrl != null &&
            project.imageUrl!
                .trim()
                .isNotEmpty;

    return Container(
      width: double.infinity,
      height: 330,
      margin:
          const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 135,
            width: double.infinity,
            child: hasImage
                ? Image.network(
                    project.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, _, __) {
                      return _buildProjectMediaPlaceholder(
                        project.mediaType,
                      );
                    },
                  )
                : _buildProjectMediaPlaceholder(
                    project.mediaType,
                  ),
          ),

          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style:
                        const TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.bold,
                      color: navy,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    project.description,
                    maxLines: 3,
                    overflow:
                        TextOverflow.ellipsis,
                    style:
                        const TextStyle(
                      fontSize: 12,
                      color: textGray,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children:
                        project.technologies
                            .map((technology) {
                      return Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration:
                            BoxDecoration(
                          color: lightPink,
                          borderRadius:
                              BorderRadius
                                  .circular(8),
                        ),
                        child: Text(
                          technology,
                          style:
                              const TextStyle(
                            fontSize: 10,
                            fontWeight:
                                FontWeight.w600,
                            color: pink,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const Spacer(),

                  if ((project.githubUrl ?? '')
                          .trim()
                          .isNotEmpty ||
                      (project.demoUrl ?? '')
                          .trim()
                          .isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if ((project.githubUrl ??
                                '')
                            .trim()
                            .isNotEmpty)
                          OutlinedButton.icon(
                            onPressed: () {
                              _openLink(
                                project
                                    .githubUrl!,
                              );
                            },
                            icon: const Icon(
                              Icons.code,
                              size: 15,
                            ),
                            label:
                                const Text(
                              'GitHub',
                              style:
                                  TextStyle(
                                fontSize:
                                    11,
                              ),
                            ),
                          ),

                        if ((project.demoUrl ??
                                '')
                            .trim()
                            .isNotEmpty)
                          OutlinedButton.icon(
                            onPressed: () {
                              _openLink(
                                project.demoUrl!,
                              );
                            },
                            icon: const Icon(
                              Icons.open_in_new,
                              size: 15,
                            ),
                            label:
                                const Text(
                              'Demo',
                              style:
                                  TextStyle(
                                fontSize:
                                    11,
                              ),
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

  Widget _buildProjectMediaPlaceholder(
    String mediaType,
  ) {
    final video =
        mediaType.toLowerCase() == 'video';

    return Container(
      color: softBackground,
      child: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              video
                  ? Icons
                      .play_circle_outline_rounded
                  : Icons.image_outlined,
              size: 38,
              color:
                  const Color(0xFF94A3B8),
            ),

            const SizedBox(height: 7),

            Text(
              video
                  ? 'PROJECT VIDEO'
                  : 'PROJECT PREVIEW',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF94A3B8),
                letterSpacing: .5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // LINKS
  // ============================================================

  Future<void> _openLink(String link) async {
    if (link.trim().isEmpty) return;

    final uri = Uri.tryParse(link);

    if (uri == null) {
      _showLinkError();
      return;
    }

    final opened = await launchUrl(
      uri,
      webOnlyWindowName: '_blank',
    );

    if (!opened && mounted) {
      _showLinkError();
    }
  }

  void _showLinkError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Unable to open the link.',
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY
  // ============================================================

  Widget _buildEmptyTab(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: softBackground,
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: textGray,
          height: 1.5,
        ),
      ),
    );
  }
}

// ===============================================================
// LOCAL CONTENT MODEL
// ===============================================================

class _SpecializationContent {
  final String title;
  final String subtitle;
  final String whatIsIt;
  final List<String> whatWillILearn;
  final List<String> recommendedSkills;
  final List<String> targetTechnologies;
  final String isItForMe;
  final String expectText;
  final List<Map<String, String>> careerPaths;
  final String presentationUrl;

  const _SpecializationContent({
    required this.title,
    required this.subtitle,
    required this.whatIsIt,
    required this.whatWillILearn,
    required this.recommendedSkills,
    required this.targetTechnologies,
    required this.isItForMe,
    required this.expectText,
    required this.careerPaths,
    required this.presentationUrl,
  });
}