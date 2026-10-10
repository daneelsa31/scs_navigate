import 'package:flutter/material.dart';

import 'home_view.dart';
import 'guide_view.dart';
import 'specialization_detail.dart';
import 'compass_view.dart';

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

  // =============================================================
  // NAVIGATION
  // =============================================================

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

  // =============================================================
  // BUILD
  // =============================================================

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    final bool isMobile = screenWidth < 850;

    final bool isHome = _selectedIndex == 0 && _selectedSpecialization == null;

    return Scaffold(
      backgroundColor: background,

      // =========================================================
      // NAVIGATION BAR
      // =========================================================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 76,
        titleSpacing: isMobile ? 14 : 32,
        surfaceTintColor: Colors.transparent,

        // =======================================================
        // NAVBAR BACKGROUND
        // =======================================================
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: isHome
                  ? [
                      const Color(0xFFFFFAFC),
                      const Color(0xFFFFF2F7),
                      const Color(0xFFFFDDEA),
                    ]
                  : [Colors.white, Colors.white],
            ),
          ),
        ),

        // =======================================================
        // LOGO
        // =======================================================
        title: Row(
          children: [
            Image.asset(
              'assets/images/scs_navigate_logo.png',
              width: isMobile ? 46 : 54,
              height: isMobile ? 46 : 54,
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

        // =======================================================
        // NAVIGATION ITEMS
        // =======================================================
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
            icon: const Icon(Icons.search_rounded, color: lightText),
            onPressed: () {
              _showSearchDialog(context);
            },
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
                    decoration: const BoxDecoration(color: navy),
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
      // =========================================================
      body: SelectionArea(
        child: LayoutBuilder(
          builder: (context, viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ============================================
                    // HOME
                    // Full width
                    // ============================================
                    if (isHome)
                      SizedBox(width: double.infinity, child: _buildBody())
                    // ============================================
                    // OTHER PAGES
                    // ============================================
                    else
                      Container(
                        width: double.infinity,
                        color: _selectedIndex == 1
                            ? const Color(0xFFFFF7FA)
                            : background,
                        child: Center(
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(maxWidth: 1280),
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 18 : 40,
                              vertical: isMobile ? 28 : 44,
                            ),
                            child: _buildBody(),
                          ),
                        ),
                      ),

                    // ============================================
                    // FOOTER
                    // ============================================
                    _buildFooter(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =============================================================
  // NAVIGATION BUTTON
  // =============================================================

  Widget _navItem(int index, String label) {
    final bool isSelected =
        _selectedIndex == index && _selectedSpecialization == null;

    return TextButton(
      onPressed: () {
        _navigateToTab(index);
      },
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
        overlayColor: WidgetStateProperty.all(pink.withValues(alpha: 0.08)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? pink : navy,
        ),
      ),
    );
  }

  // =============================================================
  // MOBILE DRAWER BUTTON
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
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),

      onTap: () {
        _navigateToTab(index);

        Navigator.pop(context);
      },
    );
  }

  // =============================================================
  // BUILD CURRENT PAGE
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
        return HomeView(onNavigate: _navigateToTab);

      case 1:
        return GuideView(onSpecializationTap: _showSpecialization);

      case 2:
        return const CompassView();

      case 3:
      default:
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 120, horizontal: 24),
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

  // =============================================================
  // FOOTER
  // =============================================================

  // =============================================================
  // FOOTER
  // =============================================================

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: navy,
        border: Border(top: BorderSide(color: pink, width: 3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1450),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isMobile = constraints.maxWidth < 900;

              if (isMobile) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterNavigate(),

                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.white12,
                    ),

                    const SizedBox(height: 24),

                    _buildFooterSsc(),

                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.white12,
                    ),

                    const SizedBox(height: 22),

                    _buildFooterContacts(),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // LEFT - SCS NAVIGATE
                  Expanded(flex: 3, child: _buildFooterNavigate()),

                  const SizedBox(width: 30),

                  // CENTER - SCS SSC
                  Expanded(flex: 4, child: _buildFooterSsc()),

                  const SizedBox(width: 30),

                  // RIGHT - CONTACT INFO
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _buildFooterContacts(),
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
  // FOOTER LEFT - SCS NAVIGATE
  // =============================================================

  Widget _buildFooterNavigate() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/scs_navigate_logo.png',
          width: 78,
          height: 78,
          fit: BoxFit.contain,
        ),

        const SizedBox(width: 18),

        Container(width: 1, height: 62, color: Colors.white24),

        const SizedBox(width: 18),

        const Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SCS NAVIGATE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),

              SizedBox(height: 5),

              Text(
                'Explore. Plan. Advance.',
                style: TextStyle(color: Color(0xFFB8C3D9), fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =============================================================
  // FOOTER CENTER - SCS SSC
  // =============================================================

  Widget _buildFooterSsc() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/scs_ssc_logo.png',
          width: 120,
          height: 120,
          fit: BoxFit.contain,
        ),

        const SizedBox(width: 20),

        Container(width: 1, height: 78, color: Colors.white24),

        const SizedBox(width: 20),

        const Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SCS Supreme Student Council',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: 6),

              Text(
                'Serving and supporting the SCS student community.',
                style: TextStyle(
                  color: Color(0xFFB8C3D9),
                  fontSize: 13,
                  height: 1.4,
                ),
              ),

              SizedBox(height: 4),

              Text(
                'University of San Jose-Recoletos',
                style: TextStyle(color: Color(0xFF8FA0BF), fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =============================================================
  // FOOTER RIGHT - CONTACTS
  // =============================================================

  Widget _buildFooterContacts() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _FooterInfo(icon: Icons.email_outlined, text: 'YOUR SCS SSC EMAIL'),

        SizedBox(height: 10),

        _FooterInfo(icon: Icons.facebook, text: 'SCS Supreme Student Council'),

        SizedBox(height: 10),

        _FooterInfo(
          icon: Icons.location_on_outlined,
          text: 'University of San Jose-Recoletos, Cebu City',
        ),
      ],
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search specializations, scholarships...',
            hintStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close', style: TextStyle(color: pink)),
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

  const _FooterInfo({required this.icon, required this.text});

  static const Color pink = Color(0xFFF55D95);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: pink, size: 19),

        const SizedBox(width: 10),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 330),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFB8C3D9),
              fontSize: 13,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}
