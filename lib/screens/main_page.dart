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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 850;
    final isHome = _selectedIndex == 0 && _selectedSpecialization == null;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 76,
        titleSpacing: isMobile ? 14 : 32,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFFFFAFC),
                Color(0xFFFFF2F7),
                Color(0xFFFFDDEA),
              ],
            ),
          ),
        ),
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
        actions: [
          if (!isMobile) ...[
            _navItem(0, 'Home'),
            _navItem(1, 'GUIDE'),
            _navItem(2, 'COMPASS'),
            const SizedBox(width: 24),
          ],
        ],
      ),
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
                ],
              ),
            )
          : null,
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
                    if (isHome)
                      SizedBox(
                        width: double.infinity,
                        child: _buildBody(),
                      )
                    else
                      Container(
                        width: double.infinity,
                        color: _selectedIndex == 1 || _selectedIndex == 2
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

  Widget _navItem(int index, String label) {
    final isSelected =
        _selectedIndex == index && _selectedSpecialization == null;

    return TextButton(
      onPressed: () => _navigateToTab(index),
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
        overlayColor: WidgetStateProperty.all(
          pink.withValues(alpha: 0.08),
        ),
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

  Widget _drawerItem(int index, String label) {
    final isSelected = _selectedIndex == index;

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
      default:
        return HomeView(onNavigate: _navigateToTab);
    }
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: navy,
        border: Border(
          top: BorderSide(color: pink, width: 3),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1450),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 900;

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
                  Expanded(flex: 3, child: _buildFooterNavigate()),
                  const SizedBox(width: 30),
                  Expanded(flex: 4, child: _buildFooterSsc()),
                  const SizedBox(width: 30),
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
                style: TextStyle(
                  color: Color(0xFFB8C3D9),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

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
                'SSC 45th Congress',
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
                style: TextStyle(
                  color: Color(0xFF8FA0BF),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooterContacts() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _FooterInfo(
          icon: Icons.email_outlined,
          text: 'scs.ssc45th@gmail.com',
        ),
        SizedBox(height: 10),
        _FooterInfo(
          icon: Icons.facebook,
          text: 'SCS Core Page',
        ),
        SizedBox(height: 10),
        _FooterInfo(
          icon: Icons.location_on_outlined,
          text: 'University of San Jose-Recoletos, Cebu City',
        ),
      ],
    );
  }
}

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
