import 'package:flutter/material.dart';

import '../../models/opportunity.dart';
import '../../services/opportunity_service.dart';

class OpportunityForm extends StatefulWidget {
  final Opportunity? opportunity;

  const OpportunityForm({
    super.key,
    this.opportunity,
  });

  @override
  State<OpportunityForm> createState() => _OpportunityFormState();
}

class _OpportunityFormState extends State<OpportunityForm> {
  static const navy = Color(0xFF00184D);
  static const pink = Color(0xFFF55D95);
  static const lightText = Color(0xFF64748B);
  static const borderColor = Color(0xFFE2E8F0);

  final _formKey = GlobalKey<FormState>();
  final OpportunityService _service = OpportunityService();

  late final TextEditingController _titleController;
  late final TextEditingController _organizerController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _deadlineController;
  late final TextEditingController _locationController;
  late final TextEditingController _registrationLinkController;
  late final TextEditingController _eligibilityController;
  late final TextEditingController _perksController;

  String _category = 'Competitions';
  String _status = 'Registration Open';

  bool _isPublished = true;
  bool _isArchived = false;
  bool _saving = false;

  bool get _isEditing => widget.opportunity != null;

  final List<String> _categories = const [
    'Competitions',
    'Hackathons',
    'Seminars',
    'Trainings',
    'Certifications',
    'Scholarships',
  ];

  final List<String> _statuses = const [
    'Registration Open',
    'Applications Open',
    'Registration Closed',
    'Applications Closed',
    'Coming Soon',
  ];

  @override
  void initState() {
    super.initState();

    final opportunity = widget.opportunity;

    _titleController = TextEditingController(
      text: opportunity?.title ?? '',
    );

    _organizerController = TextEditingController(
      text: opportunity?.organizer ?? '',
    );

    _descriptionController = TextEditingController(
      text: opportunity?.description ?? '',
    );

    _deadlineController = TextEditingController(
      text: opportunity?.deadline ?? '',
    );

    _locationController = TextEditingController(
      text: opportunity?.location ?? '',
    );

    _registrationLinkController = TextEditingController(
      text: opportunity?.registrationLink ?? '',
    );

    _eligibilityController = TextEditingController(
      text: opportunity?.eligibility.join('\n') ?? '',
    );

    _perksController = TextEditingController(
      text: opportunity?.perks.join('\n') ?? '',
    );

    if (opportunity != null) {
      _category = opportunity.category;
      _status = opportunity.status;
      _isPublished = opportunity.isPublished;
      _isArchived = opportunity.isArchived;
    }
  }

  List<String> _linesToList(String value) {
    return value
        .split('\n')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _saving = true;
    });

    final opportunity = Opportunity(
      id: widget.opportunity?.id ?? '',
      title: _titleController.text.trim(),
      organizer: _organizerController.text.trim(),
      category: _category,
      description: _descriptionController.text.trim(),
      deadline: _deadlineController.text.trim(),
      status: _status,
      location: _locationController.text.trim(),
      registrationLink: _registrationLinkController.text.trim(),
      eligibility: _linesToList(
        _eligibilityController.text,
      ),
      perks: _linesToList(
        _perksController.text,
      ),
      isPublished: _isPublished,
      isArchived: _isArchived,
    );

    try {
      if (_isEditing) {
        await _service.updateOpportunity(opportunity);
      } else {
        await _service.addOpportunity(opportunity);
      }

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to save opportunity: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _organizerController.dispose();
    _descriptionController.dispose();
    _deadlineController.dispose();
    _locationController.dispose();
    _registrationLinkController.dispose();
    _eligibilityController.dispose();
    _perksController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCFD),
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        title: Text(
          _isEditing
              ? 'Edit Opportunity'
              : 'Add Opportunity',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'COMPASS Opportunity',
                      style: TextStyle(
                        color: navy,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      _isEditing
                          ? 'Update the information shown to students.'
                          : 'Create a new opportunity for COMPASS.',
                      style: const TextStyle(
                        color: lightText,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 28),

                    _section(
                      title: 'Basic Information',
                      child: Column(
                        children: [
                          _textField(
                            controller: _titleController,
                            label: 'Title',
                            requiredField: true,
                          ),

                          const SizedBox(height: 16),

                          _textField(
                            controller:
                                _organizerController,
                            label: 'Organizer',
                            requiredField: true,
                          ),

                          const SizedBox(height: 16),

                          LayoutBuilder(
                            builder: (
                              context,
                              constraints,
                            ) {
                              final mobile =
                                  constraints.maxWidth <
                                      650;

                              final categoryField =
                                  _dropdown(
                                label: 'Category',
                                value: _category,
                                items: _categories,
                                onChanged: (value) {
                                  if (value == null) return;

                                  setState(() {
                                    _category = value;
                                  });
                                },
                              );

                              final statusField =
                                  _dropdown(
                                label: 'Status',
                                value: _status,
                                items: _statuses,
                                onChanged: (value) {
                                  if (value == null) return;

                                  setState(() {
                                    _status = value;
                                  });
                                },
                              );

                              if (mobile) {
                                return Column(
                                  children: [
                                    categoryField,
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    statusField,
                                  ],
                                );
                              }

                              return Row(
                                children: [
                                  Expanded(
                                    child: categoryField,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: statusField,
                                  ),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          _textField(
                            controller:
                                _descriptionController,
                            label: 'Description',
                            requiredField: true,
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    _section(
                      title: 'Event Details',
                      child: Column(
                        children: [
                          LayoutBuilder(
                            builder: (
                              context,
                              constraints,
                            ) {
                              final mobile =
                                  constraints.maxWidth <
                                      650;

                              final deadlineField =
                                  _textField(
                                controller:
                                    _deadlineController,
                                label: 'Deadline',
                                requiredField: true,
                                hint:
                                    'Example: October 30, 2026',
                              );

                              final locationField =
                                  _textField(
                                controller:
                                    _locationController,
                                label: 'Location',
                                requiredField: true,
                              );

                              if (mobile) {
                                return Column(
                                  children: [
                                    deadlineField,
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    locationField,
                                  ],
                                );
                              }

                              return Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Expanded(
                                    child:
                                        deadlineField,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child:
                                        locationField,
                                  ),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          _textField(
                            controller:
                                _registrationLinkController,
                            label:
                                'Official Site / Registration Link',
                            requiredField: true,
                            hint:
                                'https://example.com',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    _section(
                      title: 'Eligibility & Perks',
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          _textField(
                            controller:
                                _eligibilityController,
                            label:
                                'Eligibility Criteria',
                            hint:
                                'Enter one criterion per line',
                            maxLines: 5,
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Example:\nOpen to all SCS students\nParticipants may join individually or as a team',
                            style: TextStyle(
                              color: lightText,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 18),

                          _textField(
                            controller:
                                _perksController,
                            label: 'Perks / Awards',
                            hint:
                                'Enter one perk per line',
                            maxLines: 5,
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Example:\nCertificate of Participation\nNetworking Opportunities\nPrizes for Winning Teams',
                            style: TextStyle(
                              color: lightText,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    _section(
                      title: 'Visibility',
                      child: Column(
                        children: [
                          SwitchListTile(
                            value: _isPublished,
                            activeThumbColor: pink,
                            title: const Text(
                              'Published',
                              style: TextStyle(
                                color: navy,
                                fontWeight:
                                    FontWeight.w700,
                              ),
                            ),
                            subtitle: const Text(
                              'Published opportunities are visible on the public COMPASS page.',
                            ),
                            onChanged: (value) {
                              setState(() {
                                _isPublished = value;
                              });
                            },
                          ),

                          const Divider(),

                          SwitchListTile(
                            value: _isArchived,
                            activeThumbColor: pink,
                            title: const Text(
                              'Archived',
                              style: TextStyle(
                                color: navy,
                                fontWeight:
                                    FontWeight.w700,
                              ),
                            ),
                            subtitle: const Text(
                              'Archived opportunities are hidden from students.',
                            ),
                            onChanged: (value) {
                              setState(() {
                                _isArchived = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    LayoutBuilder(
                      builder: (
                        context,
                        constraints,
                      ) {
                        final mobile =
                            constraints.maxWidth < 520;

                        final cancelButton =
                            OutlinedButton(
                          onPressed: _saving
                              ? null
                              : () {
                                  Navigator.pop(
                                    context,
                                  );
                                },
                          style:
                              OutlinedButton.styleFrom(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                          ),
                        );

                        final saveButton =
                            FilledButton.icon(
                          onPressed:
                              _saving ? null : _save,
                          style:
                              FilledButton.styleFrom(
                            backgroundColor: pink,
                            foregroundColor:
                                Colors.white,
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              vertical: 16,
                              horizontal: 26,
                            ),
                          ),
                          icon: _saving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color:
                                        Colors.white,
                                  ),
                                )
                              : const Icon(
                                  Icons
                                      .save_outlined,
                                ),
                          label: Text(
                            _saving
                                ? 'SAVING...'
                                : _isEditing
                                ? 'SAVE CHANGES'
                                : 'PUBLISH OPPORTUNITY',
                            style: const TextStyle(
                              fontWeight:
                                  FontWeight.w800,
                            ),
                          ),
                        );

                        if (mobile) {
                          return Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .stretch,
                            children: [
                              saveButton,
                              const SizedBox(
                                height: 12,
                              ),
                              cancelButton,
                            ],
                          );
                        }

                        return Row(
                          mainAxisAlignment:
                              MainAxisAlignment.end,
                          children: [
                            cancelButton,
                            const SizedBox(
                              width: 12,
                            ),
                            saveButton,
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _section({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: navy,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    bool requiredField = false,
    String? hint,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: requiredField
          ? (value) {
              if (value == null ||
                  value.trim().isEmpty) {
                return '$label is required.';
              }

              return null;
            }
          : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        alignLabelWithHint: maxLines > 1,
        filled: true,
        fillColor:
            const Color(0xFFFFFCFD),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: pink,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor:
            const Color(0xFFFFFCFD),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: pink,
            width: 1.5,
          ),
        ),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}