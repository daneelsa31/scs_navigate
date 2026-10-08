import 'package:flutter/material.dart';

// ============================================================
// MAIN SPECIALIZATION CARD
// ============================================================

class SpecCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String actionText;
  final String? imagePath;
  final VoidCallback? onTap;

  const SpecCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.actionText,
    this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage =
        imagePath != null && imagePath!.trim().isNotEmpty;

    return SizedBox(
      height: hasImage ? 340 : 240,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =================================================
                // IMAGE
                // =================================================

                if (hasImage)
                  SizedBox(
                    width: double.infinity,
                    height: 145,
                    child: Image.asset(
                      imagePath!,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),

                // =================================================
                // CARD CONTENT
                // =================================================

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // ICON
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDD9E5),
                            borderRadius:
                                BorderRadius.circular(8),
                          ),
                          child: Icon(
                            icon,
                            color: const Color(0xFFF55D95),
                            size: 18,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // TITLE
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 7),

                        // DESCRIPTION
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                            height: 1.4,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const Spacer(),

                        // ACTION
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                actionText,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      Color(0xFFF55D95),
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
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SMALL SPECIALIZATION CARD
// ============================================================

class MiniSpecCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const MiniSpecCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xFF0F172A),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            description,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF64748B),
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// STUDENT INSIGHT CARD
// ============================================================

class InsightCard extends StatelessWidget {
  final String quote;
  final String author;

  const InsightCard({
    super.key,
    required this.quote,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // QUOTE
          Text(
            '"$quote"',
            style: const TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: Color(0xFF334155),
              height: 1.4,
            ),
            softWrap: true,
          ),

          const SizedBox(height: 16),

          // AUTHOR
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall =
                  constraints.maxWidth < 300;

              if (isSmall) {
                return Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      author,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                      softWrap: true,
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      author,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}