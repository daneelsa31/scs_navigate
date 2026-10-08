import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/opportunity.dart';
import '../services/opportunity_service.dart';

class CompassView extends StatefulWidget {
  const CompassView({super.key});

  @override
  State<CompassView> createState() => _CompassViewState();
}

class _CompassViewState extends State<CompassView> {
  static const navy = Color(0xFF00184D);

  static const pink = Color(0xFFF55D95);

  static const lightPink = Color(0xFFFFF1F6);

  static const lightText = Color(0xFF64748B);

  static const borderColor = Color(0xFFE2E8F0);

  final OpportunityService _opportunityService = OpportunityService();

  // =============================================================

  // CHANGE THIS LATER TO YOUR ACTUAL GOOGLE FORM LINK

  // =============================================================

  static const proofFormLink = 'https://docs.google.com/forms/';

  String selectedCategory = 'All';

  String searchQuery = '';

  final categories = [
    'All',

    'Competitions',

    'Hackathons',

    'Seminars',

    'Trainings',

    'Certifications',

    'Scholarships',
  ];

  List<Opportunity> _filterOpportunities(List<Opportunity> opportunities) {
    final q = searchQuery.toLowerCase().trim();

    return opportunities.where((o) {
      final categoryMatch =
          selectedCategory == 'All' || o.category == selectedCategory;

      final searchMatch =
          q.isEmpty ||
          o.title.toLowerCase().contains(q) ||
          o.organizer.toLowerCase().contains(q) ||
          o.category.toLowerCase().contains(q) ||
          o.description.toLowerCase().contains(q);

      return categoryMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Opportunity>>(
      stream: _opportunityService.getPublicOpportunities(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Center(child: CircularProgressIndicator(color: pink)),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: pink,
                    size: 42,
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Unable to load COMPASS opportunities.',
                    style: TextStyle(
                      color: navy,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: lightText, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        }

        final opportunities = snapshot.data ?? [];

        final results = _filterOpportunities(opportunities);

        return LayoutBuilder(
          builder: (context, c) {
            final mobile = c.maxWidth < 700;
            final large = c.maxWidth >= 1100;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COMPASS',
                  style: TextStyle(
                    color: navy,
                    fontSize: mobile
                        ? 38
                        : large
                        ? 52
                        : 46,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.5,
                    height: 1,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  'Discover opportunities beyond the classroom. '
                  'Find competitions, hackathons, seminars, '
                  'trainings, certifications, and scholarships.',
                  style: TextStyle(
                    color: lightText,
                    fontSize: mobile ? 15 : 17,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 30),

                const Divider(color: borderColor, height: 1),

                const SizedBox(height: 38),

                _buildSearchPanel(mobile),

                const SizedBox(height: 42),

                Text(
                  'Showing ${results.length} '
                  '${results.length == 1 ? 'opportunity' : 'opportunities'}',
                  style: const TextStyle(
                    color: lightText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                if (results.isEmpty)
                  _buildEmptyState()
                else
                  _buildCards(results),

                const SizedBox(height: 50),

                _buildRecognitionBanner(),

                const SizedBox(height: 30),
              ],
            );
          },
        );
      },
    );
  }

  // =============================================================

  // SEARCH

  // =============================================================

  Widget _buildSearchPanel(bool mobile) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(mobile ? 18 : 28),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(color: borderColor),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .025),

            blurRadius: 18,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          TextField(
            onChanged: (value) {
              setState(() => searchQuery = value);
            },

            style: const TextStyle(fontSize: 15, color: navy),

            decoration: InputDecoration(
              hintText: 'Search opportunities by title, organizer, or topic...',

              hintStyle: const TextStyle(
                color: Color(0xFF94A3B8),

                fontSize: 15,
              ),

              prefixIcon: const Icon(
                Icons.search_rounded,

                color: Color(0xFF94A3B8),
              ),

              filled: true,

              fillColor: const Color(0xFFFFF8FA),

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,

                vertical: 18,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),

                borderSide: BorderSide(color: pink.withValues(alpha: .20)),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),

                borderSide: const BorderSide(color: pink, width: 1.5),
              ),
            ),
          ),

          const SizedBox(height: 22),

          Wrap(
            spacing: 10,

            runSpacing: 10,

            children: categories.map(_buildFilterChip).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String category) {
    final selected = selectedCategory == category;

    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },

      borderRadius: BorderRadius.circular(30),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),

        decoration: BoxDecoration(
          color: selected ? pink : lightPink,

          borderRadius: BorderRadius.circular(30),

          border: Border.all(
            color: selected ? pink : pink.withValues(alpha: .12),
          ),
        ),

        child: Text(
          category,

          style: TextStyle(
            color: selected ? Colors.white : navy,

            fontSize: 13,

            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // =============================================================

  // CARDS

  // =============================================================

  Widget _buildCards(List<Opportunity> results) {
    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth < 850) {
          return Column(
            children: results
                .map(
                  (o) => Padding(
                    padding: const EdgeInsets.only(bottom: 18),

                    child: _buildOpportunityCard(o),
                  ),
                )
                .toList(),
          );
        }

        final width = (c.maxWidth - 20) / 2;

        return Wrap(
          spacing: 20,

          runSpacing: 20,

          children: results
              .map(
                (o) => SizedBox(width: width, child: _buildOpportunityCard(o)),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildOpportunityCard(Opportunity o) {
    return Container(
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(color: borderColor),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .025),

            blurRadius: 14,

            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,

                  child: _pill(
                    o.category.toUpperCase(),

                    pink,

                    lightPink,

                    fontSize: 11,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,

                  child: _pill(
                    o.status,

                    pink,

                    lightPink,

                    dot: true,

                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Text(
            o.title,

            style: const TextStyle(
              color: navy,

              fontSize: 21,

              fontWeight: FontWeight.w800,

              height: 1.25,
            ),
          ),

          const SizedBox(height: 8),

          Text.rich(
            TextSpan(
              style: const TextStyle(color: lightText, fontSize: 13),

              children: [
                const TextSpan(text: 'Organizer: '),

                TextSpan(
                  text: o.organizer,

                  style: const TextStyle(
                    color: navy,

                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          Text(
            o.description,

            style: const TextStyle(
              color: lightText,

              fontSize: 14,

              height: 1.55,
            ),
          ),

          const SizedBox(height: 22),

          const Divider(color: borderColor),

          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(color: lightText, fontSize: 13),

                    children: [
                      const TextSpan(text: 'Deadline: '),

                      TextSpan(
                        text: o.deadline,

                        style: const TextStyle(
                          color: navy,

                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),

              _LearnMoreButton(
                onTap: () {
                  _showOpportunityDetails(o);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(
    String text,

    Color foreground,

    Color background, {

    bool dot = false,

    double fontSize = 12,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),

      decoration: BoxDecoration(
        color: background,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: pink.withValues(alpha: .2)),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          if (dot) ...[
            Container(
              width: 7,

              height: 7,

              decoration: BoxDecoration(
                color: foreground,

                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(width: 7),
          ],

          Flexible(
            child: Text(
              text,

              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                color: foreground,

                fontSize: fontSize,

                fontWeight: FontWeight.w800,

                letterSpacing: dot ? 0 : .4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================

  // EMPTY STATE

  // =============================================================

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(color: borderColor),
      ),

      child: const Column(
        children: [
          Icon(Icons.search_off_rounded, color: pink, size: 46),

          SizedBox(height: 16),

          Text(
            'No opportunities found',

            style: TextStyle(
              color: navy,

              fontSize: 20,

              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(height: 8),

          Text(
            'Try changing your search or selecting another category.',

            textAlign: TextAlign.center,

            style: TextStyle(color: lightText, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // =============================================================

  // RECOGNITION SECTION

  // =============================================================

  Widget _buildRecognitionBanner() {
    return LayoutBuilder(
      builder: (context, c) {
        final mobile = c.maxWidth < 700;

        return Container(
          width: double.infinity,

          padding: EdgeInsets.symmetric(
            horizontal: mobile ? 22 : 36,

            vertical: mobile ? 26 : 32,
          ),

          decoration: BoxDecoration(
            color: navy,

            borderRadius: BorderRadius.circular(26),

            border: Border.all(color: pink.withValues(alpha: .22)),

            boxShadow: [
              BoxShadow(
                color: navy.withValues(alpha: .10),

                blurRadius: 20,

                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              if (mobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    _buildRecognitionText(),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,

                      child: _buildSubmitProofButton(),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(child: _buildRecognitionText()),

                    const SizedBox(width: 30),

                    _buildSubmitProofButton(),
                  ],
                ),

              const SizedBox(height: 26),

              Container(
                width: double.infinity,

                height: 1,

                color: Colors.white.withValues(alpha: .14),
              ),

              const SizedBox(height: 22),

              const Text(
                'One Certificate of Recognition may be issued per student per semester.',

                style: TextStyle(
                  color: Color(0xFFCBD5E1),

                  fontSize: 13,

                  fontStyle: FontStyle.italic,

                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecognitionText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            Icon(Icons.workspace_premium_outlined, color: pink, size: 19),

            SizedBox(width: 8),

            Text(
              'ACADEMIC RECOGNITION',

              style: TextStyle(
                color: pink,

                fontSize: 12,

                fontWeight: FontWeight.w800,

                letterSpacing: 1.1,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        const Text(
          'Participated in a COMPASS Opportunity?',

          style: TextStyle(
            color: Colors.white,

            fontSize: 25,

            fontWeight: FontWeight.w800,

            height: 1.2,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          'Submit your proof of participation for verification.',

          style: TextStyle(
            color: Colors.white.withValues(alpha: .78),

            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitProofButton() {
    return _ActionButton(
      text: 'Submit Proof',

      icon: Icons.add_rounded,

      background: Colors.white,

      foreground: navy,

      trailing: Icons.arrow_forward_rounded,

      trailingColor: pink,

      onTap: () {
        _openLink(proofFormLink);
      },
    );
  }

  // =============================================================

  // LEARN MORE POPUP

  // =============================================================

  void _showOpportunityDetails(Opportunity o) {
    showDialog(
      context: context,

      barrierColor: Colors.black.withValues(alpha: .45),

      builder: (dialogContext) {
        final height = MediaQuery.sizeOf(dialogContext).height;

        return Dialog(
          backgroundColor: Colors.transparent,

          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,

            vertical: 30,
          ),

          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 760, maxHeight: height * .88),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),

              child: Material(
                color: Colors.white,

                child: Column(
                  children: [
                    // HEADER
                    Container(
                      color: navy,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,

                        vertical: 16,
                      ),

                      child: Row(
                        children: [
                          _pill(
                            o.category.toUpperCase(),

                            Colors.white,

                            pink,

                            fontSize: 11,
                          ),

                          const Spacer(),

                          IconButton(
                            tooltip: 'Close',

                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },

                            icon: const Icon(
                              Icons.close_rounded,

                              color: Color(0xFFB8C3D9),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // BODY
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(28),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              o.title,

                              style: const TextStyle(
                                color: navy,

                                fontSize: 27,

                                fontWeight: FontWeight.w800,

                                height: 1.2,
                              ),
                            ),

                            const SizedBox(height: 7),

                            Text.rich(
                              TextSpan(
                                style: const TextStyle(
                                  color: lightText,

                                  fontSize: 15,
                                ),

                                children: [
                                  const TextSpan(text: 'Organizer: '),

                                  TextSpan(
                                    text: o.organizer,

                                    style: const TextStyle(
                                      color: navy,

                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 26),

                            _buildInfoBox(o),

                            const SizedBox(height: 28),

                            _sectionTitle('About Opportunity'),

                            const SizedBox(height: 10),

                            Text(
                              o.description,

                              style: const TextStyle(
                                color: lightText,

                                fontSize: 15,

                                height: 1.6,
                              ),
                            ),

                            if (o.eligibility.isNotEmpty) ...[
                              const SizedBox(height: 28),

                              _sectionTitle('Eligibility Criteria'),

                              const SizedBox(height: 12),

                              ...o.eligibility.map(
                                (item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),

                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 1),

                                        width: 19,

                                        height: 19,

                                        decoration: BoxDecoration(
                                          color: lightPink,

                                          shape: BoxShape.circle,

                                          border: Border.all(color: pink),
                                        ),

                                        child: const Icon(
                                          Icons.check_rounded,

                                          size: 12,

                                          color: pink,
                                        ),
                                      ),

                                      const SizedBox(width: 10),

                                      Expanded(
                                        child: Text(
                                          item,

                                          style: const TextStyle(
                                            color: lightText,

                                            fontSize: 14,

                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],

                            if (o.perks.isNotEmpty) ...[
                              const SizedBox(height: 26),

                              _sectionTitle('Perks & Awards'),

                              const SizedBox(height: 12),

                              Wrap(
                                spacing: 8,

                                runSpacing: 8,

                                children: o.perks
                                    .map(
                                      (perk) => Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,

                                          vertical: 8,
                                        ),

                                        decoration: BoxDecoration(
                                          color: lightPink,

                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),

                                          border: Border.all(
                                            color: pink.withValues(alpha: .18),
                                          ),
                                        ),

                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,

                                          children: [
                                            const Icon(
                                              Icons.auto_awesome,

                                              color: pink,

                                              size: 14,
                                            ),

                                            const SizedBox(width: 6),

                                            Text(
                                              perk,

                                              style: const TextStyle(
                                                color: navy,

                                                fontSize: 13,

                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    // ACTIONS
                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,

                        vertical: 18,
                      ),

                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF8FA),

                        border: Border(top: BorderSide(color: borderColor)),
                      ),

                      child: LayoutBuilder(
                        builder: (context, c) {
                          final mobile = c.maxWidth < 600;

                          final proof = _ActionButton(
                            text: 'Submit Proof of Participation',

                            icon: Icons.workspace_premium_outlined,

                            background: pink,

                            foreground: Colors.white,

                            onTap: () {
                              _openLink(proofFormLink);
                            },
                          );

                          final register = _ActionButton(
                            text: 'Visit Official Site / Register',

                            icon: Icons.open_in_new_rounded,

                            background: navy,

                            foreground: Colors.white,

                            onTap: () {
                              _openLink(o.registrationLink);
                            },
                          );

                          if (mobile) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,

                              children: [
                                register,

                                const SizedBox(height: 10),

                                proof,
                              ],
                            );
                          }

                          return Row(
                            children: [
                              Expanded(child: proof),

                              const SizedBox(width: 20),

                              Expanded(child: register),
                            ],
                          );
                        },
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

  Widget _buildInfoBox(Opportunity o) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: lightPink,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: pink.withValues(alpha: .18)),
      ),

      child: LayoutBuilder(
        builder: (context, c) {
          final deadline = _PopupInfoItem(
            icon: Icons.calendar_month_outlined,

            label: 'Deadline',

            value: o.deadline,
          );

          final location = _PopupInfoItem(
            icon: Icons.location_on_outlined,

            label: 'Location',

            value: o.location,
          );

          if (c.maxWidth < 520) {
            return Column(
              children: [deadline, const SizedBox(height: 16), location],
            );
          }

          return Row(
            children: [
              Expanded(child: deadline),

              const SizedBox(width: 30),

              Expanded(child: location),
            ],
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,

      style: const TextStyle(
        color: navy,

        fontSize: 16,

        fontWeight: FontWeight.w800,
      ),
    );
  }

  // =============================================================

  // OPEN LINKS

  // =============================================================

  Future<void> _openLink(String link) async {
    final uri = Uri.parse(link);

    final opened = await launchUrl(uri, webOnlyWindowName: '_blank');

    if (!opened && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Unable to open the link.')));
    }
  }
}

// ===============================================================

// OPPORTUNITY MODEL

// ===============================================================

// ===============================================================

// POPUP INFO

// ===============================================================

class _PopupInfoItem extends StatelessWidget {
  final IconData icon;

  final String label;

  final String value;

  const _PopupInfoItem({
    required this.icon,

    required this.label,

    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Icon(icon, color: _CompassViewState.pink, size: 21),

        const SizedBox(width: 10),

        Expanded(
          child: Text.rich(
            TextSpan(
              style: const TextStyle(
                color: _CompassViewState.lightText,

                fontSize: 14,
              ),

              children: [
                TextSpan(text: '$label: '),

                TextSpan(
                  text: value,

                  style: const TextStyle(
                    color: _CompassViewState.navy,

                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ===============================================================

// LEARN MORE BUTTON

// ===============================================================

class _LearnMoreButton extends StatefulWidget {
  final VoidCallback onTap;

  const _LearnMoreButton({required this.onTap});

  @override
  State<_LearnMoreButton> createState() => _LearnMoreButtonState();
}

class _LearnMoreButtonState extends State<_LearnMoreButton> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => hovered = true);
      },

      onExit: (_) {
        setState(() => hovered = false);
      },

      child: InkWell(
        onTap: widget.onTap,

        borderRadius: BorderRadius.circular(30),

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 170),

          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),

          decoration: BoxDecoration(
            color: hovered ? _CompassViewState.pink : _CompassViewState.navy,

            borderRadius: BorderRadius.circular(30),
          ),

          child: const Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              Text(
                'LEARN MORE',

                style: TextStyle(
                  color: Colors.white,

                  fontSize: 12,

                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(width: 8),

              Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ===============================================================

// ACTION BUTTON

// ===============================================================

class _ActionButton extends StatefulWidget {
  final String text;

  final IconData icon;

  final IconData? trailing;

  final Color background;

  final Color foreground;

  final Color? trailingColor;

  final VoidCallback onTap;

  const _ActionButton({
    required this.text,

    required this.icon,

    required this.background,

    required this.foreground,

    required this.onTap,

    this.trailing,

    this.trailingColor,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => hovered = true);
      },

      onExit: (_) {
        setState(() => hovered = false);
      },

      child: InkWell(
        onTap: widget.onTap,

        borderRadius: BorderRadius.circular(30),

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),

          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),

          decoration: BoxDecoration(
            color: hovered ? _CompassViewState.pink : widget.background,

            borderRadius: BorderRadius.circular(30),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,

            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(
                widget.icon,

                color: hovered ? Colors.white : widget.foreground,

                size: 18,
              ),

              const SizedBox(width: 9),

              Flexible(
                child: Text(
                  widget.text,

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: hovered ? Colors.white : widget.foreground,

                    fontSize: 13,

                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              if (widget.trailing != null) ...[
                const SizedBox(width: 8),

                Icon(
                  widget.trailing,

                  color: hovered
                      ? Colors.white
                      : widget.trailingColor ?? widget.foreground,

                  size: 17,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
