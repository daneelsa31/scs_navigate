import 'package:flutter/material.dart';
import 'home_view.dart';
import 'guide_view.dart';
import 'specialization_detail.dart';
import '../models/specialization.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  Specialization? _selectedSpecialization;

  static const Color navy = Color(0xFF00184D);
  static const Color pink = Color(0xFFF55D95);
  static const Color lightText = Color(0xFF64748B);
  static const Color background = Color(0xFFFFFCFD);

  void _navigateToTab(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedSpecialization = null;
    });
  }

  void _showSpecialization(Specialization spec) {
    setState(() {
      _selectedSpecialization = spec;
    });
  }

  void _closeSpecialization() {
    setState(() {
      _selectedSpecialization = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final bool isMobile = screenWidth < 850;

    return Scaffold(
      backgroundColor: background,

      // =========================================================
      // NAVIGATION BAR
      // =========================================================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        toolbarHeight: 76,
        titleSpacing: isMobile ? 14 : 28,
        surfaceTintColor: Colors.transparent,

        title: Row(
          children: [
            Image.asset(
              'assets/images/scs_navigate_logo.png',
              width: isMobile ? 44 : 52,
              height: isMobile ? 44 : 52,
              fit: BoxFit.contain,
            ),

            const SizedBox(width: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'SCS NAVIGATE',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: isMobile ? 16 : 19,
                    color: navy,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  'SCHOOL OF COMPUTER STUDIES',
                  style: TextStyle(
                    fontSize: isMobile ? 8 : 10,
                    fontWeight: FontWeight.w600,
                    color: lightText,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ],
        ),

        actions: [
          if (!isMobile) ...[
            _navItem(0, 'Home'),
            _navItem(1, 'GUIDE'),
            _navItem(2, 'COMPASS'),
            _navItem(3, 'About'),
            const SizedBox(width: 18),
          ],

          IconButton(
            tooltip: 'Search',
            icon: const Icon(
              Icons.search,
              color: lightText,
            ),
            onPressed: () => _showSearchDialog(context),
          ),

          const SizedBox(width: 12),
        ],
      ),

      // =========================================================
      // MOBILE DRAWER
      // =========================================================
      drawer: isMobile
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: navy,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/scs_navigate_logo.png',
                          width: 55,
                          height: 55,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'SCS NAVIGATE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _drawerItem(0, 'Home'),
                  _drawerItem(1, 'GUIDE'),
                  _drawerItem(2, 'COMPASS'),
                  _drawerItem(3, 'About'),
                ],
              ),
            )
          : null,

      // =========================================================
      // BODY
      //
      // SelectionArea = users can highlight/copy website text.
      //
      // LayoutBuilder + ConstrainedBox + IntrinsicHeight =
      // footer remains at the bottom on short pages.
      // =========================================================
      body: SelectionArea(
        child: LayoutBuilder(
          builder: (context, viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ===========================================
                      // MAIN CONTENT
                      // ===========================================
                      Expanded(
                        child: Center(
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 1280,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 18 : 40,
                              vertical: isMobile ? 28 : 44,
                            ),
                            child: _buildBody(),
                          ),
                        ),
                      ),

                      // ===========================================
                      // FOOTER
                      // ===========================================
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =============================================================
  // NAVIGATION ITEM
  // =============================================================

  Widget _navItem(int index, String label) {
    final bool isSelected = _selectedIndex == index;

    return TextButton(
      onPressed: () => _navigateToTab(index),
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
        ),
        overlayColor: WidgetStateProperty.all(
          pink.withValues(alpha: 0.08),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight:
              isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? pink : navy,
        ),
      ),
    );
  }

  // =============================================================
  // MOBILE DRAWER ITEM
  // =============================================================

  Widget _drawerItem(int index, String label) {
    final bool isSelected = _selectedIndex == index;

    return ListTile(
      selected: isSelected,
      selectedTileColor: pink.withValues(alpha: 0.10),

      leading: Container(
        width: 4,
        height: 25,
        decoration: BoxDecoration(
          color: isSelected ? pink : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? pink : navy,
          fontWeight:
              isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),

      onTap: () {
        _navigateToTab(index);
        Navigator.pop(context);
      },
    );
  }

  // =============================================================
  // BODY CONTENT
  // =============================================================

  Widget _buildBody() {
    if (_selectedSpecialization != null) {
      return SpecializationDetailScreen(
        spec: _selectedSpecialization!,
        onBack: _closeSpecialization,
      );
    }

    switch (_selectedIndex) {
      case 0:
        return HomeView(
          onNavigate: _navigateToTab,
        );

      case 1:
        return GuideView(
          onSpecializationTap: _showSpecialization,
        );

      case 2:
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 120,
              horizontal: 24,
            ),
            child: Text(
              'COMPASS View (Coming Soon)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: navy,
              ),
            ),
          ),
        );

      case 3:
      default:
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 120,
              horizontal: 24,
            ),
            child: Text(
              'About View (Coming Soon)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: navy,
              ),
            ),
          ),
        );
    }
  }

  // =============================================================
  // FOOTER
  // =============================================================

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: navy,
        border: Border(
          top: BorderSide(
            color: pink,
            width: 4,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 34,
      ),

      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1280,
          ),

          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isSmall = constraints.maxWidth < 760;

              // =================================================
              // MOBILE FOOTER
              // =================================================
              if (isSmall) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/scs_navigate_logo.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(width: 16),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SCS NAVIGATE',
                                style: TextStyle(
                                  color: pink,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                'School of Computer Studies',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Your centralized hub for academic pathways, '
                      'specializations, and technology opportunities.',
                      style: TextStyle(
                        color: Color(0xFFB8C3D9),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      height: 1,
                      color: pink.withValues(alpha: 0.6),
                    ),

                    const SizedBox(height: 24),

                    const _FooterInfo(
                      icon: Icons.email_outlined,
                      text: 'scs.navigate@usjr.edu.ph',
                    ),

                    const SizedBox(height: 14),

                    const _FooterInfo(
                      icon: Icons.language,
                      text: 'www.usjr.edu.ph',
                    ),

                    const SizedBox(height: 14),

                    const _FooterInfo(
                      icon: Icons.location_on_outlined,
                      text:
                          'P. del Rosario St., Cebu City, Philippines 6000',
                    ),
                  ],
                );
              }

              // =================================================
              // DESKTOP FOOTER
              // =================================================
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/scs_navigate_logo.png',
                          width: 76,
                          height: 76,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(width: 22),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SCS NAVIGATE',
                                style: TextStyle(
                                  color: pink,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                'School of Computer Studies',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              SizedBox(height: 12),

                              Text(
                                'Your centralized hub for academic pathways, '
                                'specializations, and technology opportunities.',
                                style: TextStyle(
                                  color: Color(0xFFB8C3D9),
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 1,
                    height: 115,
                    color: pink.withValues(alpha: 0.7),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 44,
                    ),
                  ),

                  const Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FooterInfo(
                          icon: Icons.email_outlined,
                          text: 'scs.navigate@usjr.edu.ph',
                        ),

                        SizedBox(height: 16),

                        _FooterInfo(
                          icon: Icons.language,
                          text: 'www.usjr.edu.ph',
                        ),

                        SizedBox(height: 16),

                        _FooterInfo(
                          icon: Icons.location_on_outlined,
                          text:
                              'P. del Rosario St., Cebu City, Philippines 6000',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // =============================================================
  // SEARCH DIALOG
  // =============================================================

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Search SCS Navigate',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search specializations, scholarships...',
            hintStyle: const TextStyle(
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(
                color: pink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// FOOTER INFO
// =============================================================

class _FooterInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FooterInfo({
    required this.icon,
    required this.text,
  });

  static const Color pink = Color(0xFFF55D95);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: pink,
          size: 21,
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFB8C3D9),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}