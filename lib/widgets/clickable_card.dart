import 'package:flutter/material.dart';

class ClickableCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color textColor;
  final String title;
  final String description;
  final List<String> bulletPoints;
  final Color bulletColor;
  final String footerText;
  final Color footerColor;
  final VoidCallback onTap;

  const ClickableCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    this.textColor = const Color(0xFF0F172A),
    required this.title,
    required this.description,
    required this.bulletPoints,
    required this.bulletColor,
    required this.footerText,
    required this.footerColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color mutedTextColor = textColor == Colors.white
        ? Colors.white70
        : const Color(0xFF64748B);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),

      hoverColor: textColor == Colors.white
          ? Colors.white10
          : Colors.grey.shade50,

      child: Ink(
        padding: const EdgeInsets.all(30),

        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),

          border: textColor == Colors.white
              ? null
              : Border.all(
                  color: const Color(0xFFE2E8F0),
                ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(9),

              decoration: BoxDecoration(
                color: textColor == Colors.white
                    ? const Color(0xFFF55D95)
                    : const Color(0xFFF1F5F9),

                borderRadius: BorderRadius.circular(10),
              ),

              child: Icon(
                icon,
                color: iconColor,
                size: 26,
              ),
            ),

            const SizedBox(height: 22),

            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),

            const SizedBox(height: 14),

            Text(
              description,
              style: TextStyle(
                fontSize: 15,
                height: 1.55,
                color: mutedTextColor,
              ),
            ),

            const SizedBox(height: 28),

            ...bulletPoints.map(
              (point) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 7),

                      decoration: BoxDecoration(
                        color: bulletColor,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        point,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: mutedTextColor,
                          letterSpacing: 0.3,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 26),

            Text(
              footerText,
              style: TextStyle(
                color: footerColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}