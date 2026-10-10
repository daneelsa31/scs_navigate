import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/sample_project.dart';

class SampleProjectSection extends StatelessWidget {
  final List<SampleProject> projects;
  final bool isMobile;

  const SampleProjectSection({
    super.key,
    required this.projects,
    required this.isMobile,
  });

  static const Color navy = Color(0xFF071E4B);
  static const Color pink = Color(0xFFF55D95);
  static const Color lightPink = Color(0xFFFFF1F6);
  static const Color lightText = Color(0xFF64748B);
  static const Color borderColor = Color(0xFFDCE5EF);

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
        ),
        child: const Text(
          'No sample projects have been added for this specialization yet.',
          style: TextStyle(
            fontSize: 13,
            color: lightText,
            height: 1.5,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF7FA),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: pink.withValues(alpha: 0.18),
            ),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.touch_app_outlined,
                color: pink,
                size: 20,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Click a project to view its preview, description, tools used, demo link, and GitHub repository.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9D174D),
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
                .map(
                  (project) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _ProjectPreviewCard(
                      project: project,
                      onTap: () => _showProjectDialog(context, project),
                    ),
                  ),
                )
                .toList(),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 255,
            ),
            itemBuilder: (context, index) {
              final project = projects[index];
              return _ProjectPreviewCard(
                project: project,
                onTap: () => _showProjectDialog(context, project),
              );
            },
          ),
      ],
    );
  }

  void _showProjectDialog(BuildContext context, SampleProject project) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (dialogContext) {
        final screen = MediaQuery.sizeOf(dialogContext);

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 28,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 820,
              maxHeight: screen.height * 0.88,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Material(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 16,
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF071E4B), Color(0xFF0B2A66)],
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.folder_open_rounded,
                            color: Color(0xFFFD73A6),
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Sample Project',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            icon: const Icon(
                              Icons.close_rounded,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: _ProjectMedia(project: project),
                              ),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              project.title,
                              style: const TextStyle(
                                color: navy,
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              project.description,
                              style: const TextStyle(
                                color: lightText,
                                fontSize: 14,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 22),
                            const Text(
                              'TOOLS USED',
                              style: TextStyle(
                                color: navy,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: project.technologies
                                  .map(
                                    (tool) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 11,
                                        vertical: 7,
                                      ),
                                      decoration: BoxDecoration(
                                        color: lightPink,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: pink.withValues(alpha: 0.14),
                                        ),
                                      ),
                                      child: Text(
                                        tool,
                                        style: const TextStyle(
                                          color: pink,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 24),
                            _ProjectLinks(project: project),
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
      },
    );
  }
}

class _ProjectPreviewCard extends StatelessWidget {
  final SampleProject project;
  final VoidCallback onTap;

  const _ProjectPreviewCard({
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: SampleProjectSection.borderColor,
            ),
            boxShadow: [
              BoxShadow(
                color: SampleProjectSection.navy.withValues(alpha: 0.035),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 130,
                child: _ProjectMedia(project: project),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: SampleProjectSection.navy,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            project.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: SampleProjectSection.lightText,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: SampleProjectSection.lightPink,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: SampleProjectSection.pink.withValues(alpha: 0.16),
                        ),
                      ),
                      child: const Icon(
                        Icons.open_in_full_rounded,
                        color: SampleProjectSection.pink,
                        size: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectMedia extends StatelessWidget {
  final SampleProject project;

  const _ProjectMedia({required this.project});

  @override
  Widget build(BuildContext context) {
    final image = project.imageUrl?.trim() ?? '';

    if (image.isEmpty) {
      return _placeholder();
    }

    if (image.startsWith('http://') || image.startsWith('https://')) {
      return Image.network(
        image,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }

    return Image.asset(
      image,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_outlined,
              color: Color(0xFF94A3B8),
              size: 42,
            ),
            SizedBox(height: 7),
            Text(
              'PROJECT PREVIEW',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectLinks extends StatelessWidget {
  final SampleProject project;

  const _ProjectLinks({required this.project});

  @override
  Widget build(BuildContext context) {
    final github = project.githubUrl?.trim() ?? '';
    final demo = project.demoUrl?.trim() ?? '';

    if (github.isEmpty && demo.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Demo and GitHub links have not been added yet.',
          style: TextStyle(
            color: SampleProjectSection.lightText,
            fontSize: 12,
          ),
        ),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        if (demo.isNotEmpty)
          _ProjectLinkButton(
            label: 'Open Demo',
            icon: Icons.open_in_new_rounded,
            url: demo,
            filled: true,
          ),
        if (github.isNotEmpty)
          _ProjectLinkButton(
            label: 'View GitHub',
            icon: Icons.code_rounded,
            url: github,
            filled: false,
          ),
      ],
    );
  }
}

class _ProjectLinkButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String url;
  final bool filled;

  const _ProjectLinkButton({
    required this.label,
    required this.icon,
    required this.url,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _openUrl(context, url),
      icon: Icon(icon, size: 17),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: filled
            ? Colors.white
            : SampleProjectSection.navy,
        backgroundColor: filled
            ? SampleProjectSection.navy
            : Colors.white,
        side: BorderSide(
          color: filled
              ? SampleProjectSection.navy
              : SampleProjectSection.borderColor,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 13,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;

    final opened = await launchUrl(
      uri,
      webOnlyWindowName: '_blank',
    );

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open this link.'),
        ),
      );
    }
  }
}
