import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'responsive_layout.dart';

class ProjectsSection extends StatelessWidget {
  ProjectsSection({super.key});

  final List<Map<String, dynamic>> projects = [
    {
      'title': 'Agro Setu ',
      'subtitle': 'AI Crop Disease Detection Platform',
      'description':
          'AI-powered smart agriculture platform enabling crop disease detection via plant leaf image scanning, achieving 92% model accuracy. Features soil analysis, weather prediction, fertilizer recommendation, and an e-commerce marketplace.',
      'tech': ['Flutter', 'TensorFlow', 'OpenCV', 'Flask', 'Node.js'],
      'github': 'https://github.com/AR955593/AgroSetu',
      'icon': Icons.agriculture,
      'brandColor': const Color(0xFF0D9488), // Teal Accent
    },
    {
      'title': 'PharmaGuard AI',
      'subtitle': 'AI-Powered Pharmacogenomics Platform',
      'description':
          'AI-powered clinical decision support web application that analyzes patient genomic data (VCF files) to predict personalized drug response risks and generate personalized treatment recommendations based on established pharmacogenomic guidelines, helping improve medication safety and precision healthcare.',
      'tech': ['Flutter', 'Python', 'AI', 'Machine Learning', 'NLP'],
      'github': 'https://github.com/AR955593/Pharmaguard_AI',
      'icon': Icons.medical_services,
      'brandColor': const Color(0xFF0F766E), // Deep Teal
    },
    {
      'title': 'Music Player',
      'subtitle': 'Modern Audio Streaming App',
      'description':
          'A feature-rich Flutter music player with an intuitive UI, playlist management, background playback, media controls, and smooth audio streaming experience designed for seamless music listening across Android devices.',
      'tech': ['Flutter', 'Dart', 'Audio Player'],
      'github': 'https://github.com/AR955593/music-player',
      'icon': Icons.music_note,
      'brandColor': const Color(0xFF4F46E5), // Indigo Accent
    },
    {
      'title': 'Personal Portfolio',
      'subtitle': 'Responsive Developer Portfolio',
      'description':
          'A modern, responsive Flutter portfolio showcasing my skills, projects, technical expertise, education, certifications, and achievements with elegant animations, interactive UI, and seamless navigation. Designed to highlight my experience in Flutter, AI/ML, Python, and full-stack application development.',
      'tech': ['Flutter', 'Dart', 'Responsive UI'],
      'github': 'https://github.com/AR955593/myportfolio',
      'icon': Icons.person,
      'brandColor': const Color(0xFF6366F1), // Iris/Indigo Accent
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.work_outline,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'Featured Projects',
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(fontSize: 24),
            ),
          ],
        ),
        const SizedBox(height: 24),

        MasonryGridView.count(
          crossAxisCount: isMobile ? 1 : 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return _ProjectCard(project: projects[index]);
          },
        ),
      ],
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final brandColor = widget.project['brandColor'] as Color;

    final bannerBg = isDark
        ? [brandColor.withValues(alpha: 0.18), brandColor.withValues(alpha: 0.05)]
        : [brandColor.withValues(alpha: 0.10), brandColor.withValues(alpha: 0.03)];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(_isHovered ? 1.015 : 1.0, _isHovered ? 1.015 : 1.0, 1.0)
          ..setTranslationRaw(0.0, _isHovered ? -5.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? brandColor.withValues(alpha: 0.5)
                : Theme.of(context).dividerColor.withValues(alpha: 0.4),
            width: _isHovered ? 1.2 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? (isDark ? Colors.black.withValues(alpha: 0.3) : brandColor.withValues(alpha: 0.08))
                  : (isDark ? Colors.black.withValues(alpha: 0.15) : Colors.black.withValues(alpha: 0.03)),
              blurRadius: _isHovered ? 16 : 8,
              offset: _isHovered ? const Offset(0, 8) : const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Premium subtle brand banner
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: bannerBg,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: AnimatedScale(
                  scale: _isHovered ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.black.withValues(alpha: 0.25)
                          : Colors.white.withValues(alpha: 0.75),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.project['icon'] as IconData,
                      size: 36,
                      color: brandColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project['title'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.project['subtitle'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.project['description'],
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (widget.project['tech'] as List<String>).map((t) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          t,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () async {
                        final Uri url = Uri.parse(widget.project['github']);
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch url');
                        }
                      },
                      icon: const Icon(Icons.code),
                      label: const Text('View Source'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
