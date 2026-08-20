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
    bool isMobile = MediaQuery.of(context).size.width < 850;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        toolbarHeight: 70,
        titleSpacing: 12,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/scs_navigate_logo.png',
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'SCS NAVIGATE',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  'SCHOOL OF COMPUTER STUDIES',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
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
            const SizedBox(width: 16),
          ],
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF64748B)),
            onPressed: () => _showSearchDialog(context),
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: isMobile
          ? Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(
                    child: Text(
                      'SCS NAVIGATE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1100),
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildBody(),
                if (_selectedIndex == 0 && _selectedSpecialization == null) ...[
                  const SizedBox(height: 48),
                  _buildFooter(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, String label) {
    bool isSelected = _selectedIndex == index;

    return TextButton(
      onPressed: () => _navigateToTab(index),
      style: TextButton.styleFrom(
        foregroundColor: isSelected
            ? const Color(0xFFF55D95)
            : const Color.fromARGB(255, 27, 68, 126),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected
              ? const Color(0xFFF55D95)
              : const Color.fromARGB(255, 21, 71, 140),
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _drawerItem(int index, String label) {
    return ListTile(
      title: Text(label),
      selected: _selectedIndex == index,
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
        return const Center(child: Text("COMPASS View (Coming Soon)"));
      case 3:
      default:
        return const Center(child: Text("About View (Coming Soon)"));
    }
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
      decoration: const BoxDecoration(
        color: Color(0xFF071E4B),
        border: Border(top: BorderSide(color: Color(0xFFF55D95), width: 4)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 650;
          final contact = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _FooterContact(icon: Icons.mail_outline, text: 'scs.navigate@usjr.edu.ph'),
              SizedBox(height: 12),
              _FooterContact(icon: Icons.language, text: 'www.usjr.edu.ph'),
              SizedBox(height: 12),
              _FooterContact(icon: Icons.location_on_outlined, text: 'P. del Rosario St., Cebu City, Philippines 6000'),
            ],
          );

          return Flex(
            direction: isCompact ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/scs_navigate_logo.png',
                      width: 78,
                      height: 78,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 18),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SCS NAVIGATE', style: TextStyle(color: Color(0xFFF55D95), fontSize: 21, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('School of Computer Studies', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                      SizedBox(height: 12),
                      SizedBox(
                        width: 270,
                        child: Text('Your centralized hub for academic pathways, specializations, and technology opportunities.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.45)),
                      ),
                    ],
                  ),
                ],
              ),
              if (!isCompact) const SizedBox(width: 48),
              if (!isCompact) Container(width: 1, height: 105, color: Color(0xFFF55D95)),
              if (!isCompact) const SizedBox(width: 48, height: 24),
              if (isCompact) const SizedBox(height: 24),
              contact,
            ],
          );
        },
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Search SCS Navigate',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search specializations, scholarships...',
            hintStyle: const TextStyle(fontSize: 13),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _FooterContact extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FooterContact({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFFF55D95), size: 20),
        const SizedBox(width: 14),
        Flexible(child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13))),
      ],
    );
  }
}
