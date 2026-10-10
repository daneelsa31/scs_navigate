import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/opportunity.dart';
import '../../services/opportunity_service.dart';
import 'opportunity_form.dart';

class AdminDashboard extends StatefulWidget {
  final VoidCallback onLogout;

  const AdminDashboard({
    super.key,
    required this.onLogout,
  });

  @override
  State<AdminDashboard> createState() =>
      _AdminDashboardState();
}

class _AdminDashboardState
    extends State<AdminDashboard> {
  static const navy = Color(0xFF00184D);
  static const pink = Color(0xFFF55D95);
  static const lightPink = Color(0xFFFFF1F6);
  static const lightText = Color(0xFF64748B);
  static const borderColor = Color(0xFFE2E8F0);

  final OpportunityService _service =
      OpportunityService();

  String _filter = 'All';

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();

    widget.onLogout();
  }

  void _openForm({
    Opportunity? opportunity,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OpportunityForm(
          opportunity: opportunity,
        ),
      ),
    );
  }

  Future<void> _delete(
    Opportunity opportunity,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete opportunity?',
          ),
          content: Text(
            'Are you sure you want to permanently delete '
            '"${opportunity.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      await _service.deleteOpportunity(
        opportunity.id,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to delete: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCFD),
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        title: const Text(
          'COMPASS Admin',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: _logout,
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ),
            label: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: StreamBuilder<List<Opportunity>>(
        stream: _service.getAllOpportunities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: pink,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Unable to load opportunities.\n'
                '${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final all =
              snapshot.data ?? [];

          final opportunities =
              all.where((o) {
            switch (_filter) {
              case 'Published':
                return o.isPublished &&
                    !o.isArchived;

              case 'Drafts':
                return !o.isPublished &&
                    !o.isArchived;

              case 'Archived':
                return o.isArchived;

              default:
                return true;
            }
          }).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(
                  maxWidth: 1250,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder:
                          (context, constraints) {
                        final mobile =
                            constraints.maxWidth <
                                700;

                        if (mobile) {
                          return Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .stretch,
                            children: [
                              _headerText(),
                              const SizedBox(
                                height: 18,
                              ),
                              _addButton(),
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(
                              child: _headerText(),
                            ),
                            _addButton(),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        'All',
                        'Published',
                        'Drafts',
                        'Archived',
                      ].map((filter) {
                        final selected =
                            _filter == filter;

                        return ChoiceChip(
                          label: Text(filter),
                          selected: selected,
                          selectedColor: pink,
                          backgroundColor:
                              lightPink,
                          labelStyle: TextStyle(
                            color: selected
                                ? Colors.white
                                : navy,
                            fontWeight:
                                FontWeight.w700,
                          ),
                          onSelected: (_) {
                            setState(() {
                              _filter = filter;
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      '${opportunities.length} '
                      '${opportunities.length == 1 ? 'opportunity' : 'opportunities'}',
                      style: const TextStyle(
                        color: lightText,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 16),

                    if (opportunities.isEmpty)
                      _emptyState()
                    else
                      ...opportunities.map(
                        _opportunityCard,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _headerText() {
    return const Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'Manage COMPASS',
          style: TextStyle(
            color: navy,
            fontSize: 32,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Create, edit, publish, archive, and manage '
          'opportunities shown to students.',
          style: TextStyle(
            color: lightText,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _addButton() {
    return FilledButton.icon(
      onPressed: () {
        _openForm();
      },
      style: FilledButton.styleFrom(
        backgroundColor: pink,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 17,
        ),
      ),
      icon: const Icon(
        Icons.add_rounded,
      ),
      label: const Text(
        'ADD OPPORTUNITY',
        style: TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 70,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            color: pink,
            size: 42,
          ),
          SizedBox(height: 12),
          Text(
            'No opportunities here.',
            style: TextStyle(
              color: navy,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _opportunityCard(
    Opportunity opportunity,
  ) {
    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final mobile =
              constraints.maxWidth < 760;

          final info = Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _badge(
                    opportunity.category,
                    lightPink,
                    pink,
                  ),
                  _badge(
                    opportunity.status,
                    lightPink,
                    pink,
                  ),
                  if (opportunity.isArchived)
                    _badge(
                      'Archived',
                      const Color(0xFFF1F5F9),
                      lightText,
                    )
                  else if (opportunity
                      .isPublished)
                    _badge(
                      'Published',
                      const Color(0xFFECFDF5),
                      const Color(0xFF047857),
                    )
                  else
                    _badge(
                      'Draft',
                      const Color(0xFFFFF7ED),
                      const Color(0xFFC2410C),
                    ),
                ],
              ),

              const SizedBox(height: 14),

              Text(
                opportunity.title,
                style: const TextStyle(
                  color: navy,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                opportunity.organizer,
                style: const TextStyle(
                  color: lightText,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Deadline: '
                '${opportunity.deadline}',
                style: const TextStyle(
                  color: navy,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );

          final actions = Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  _openForm(
                    opportunity: opportunity,
                  );
                },
                icon: const Icon(
                  Icons.edit_outlined,
                ),
                label: const Text('Edit'),
              ),

              OutlinedButton(
                onPressed: () async {
                  await _service
                      .changePublication(
                    opportunity.id,
                    !opportunity.isPublished,
                  );
                },
                child: Text(
                  opportunity.isPublished
                      ? 'Unpublish'
                      : 'Publish',
                ),
              ),

              OutlinedButton(
                onPressed: () async {
                  await _service
                      .archiveOpportunity(
                    opportunity.id,
                    !opportunity.isArchived,
                  );
                },
                child: Text(
                  opportunity.isArchived
                      ? 'Restore'
                      : 'Archive',
                ),
              ),

              IconButton(
                tooltip: 'Delete',
                color: Colors.redAccent,
                onPressed: () {
                  _delete(opportunity);
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                ),
              ),
            ],
          );

          if (mobile) {
            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                info,
                const SizedBox(height: 20),
                actions,
              ],
            );
          }

          return Row(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: [
              Expanded(child: info),
              const SizedBox(width: 24),
              actions,
            ],
          );
        },
      ),
    );
  }

  Widget _badge(
    String text,
    Color background,
    Color foreground,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}