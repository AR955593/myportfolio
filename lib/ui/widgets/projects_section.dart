import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'responsive_layout.dart';

class ProjectsSection extends StatelessWidget {
  ProjectsSection({super.key});

  final List<Map<String, dynamic>> projects = [
    {
      'title': 'AgroScan',
      'subtitle': 'AI Crop Disease Detection Platform',
      'description': 'AI-powered smart agriculture platform enabling crop disease detection via plant leaf image scanning, achieving 92% model accuracy. Features soil analysis, weather prediction, fertilizer recommendation, and an e-commerce marketplace.',
      'tech': ['Flutter', 'TensorFlow', 'OpenCV', 'Flask', 'Node.js'],
      'github': 'https://github.com/AR955593/AgroScan',
      'icon': Icons.agriculture,
      'gradientColors': [Color(0xFF11998e), Color(0xFF38ef7d)],
    },
    {
      'title': 'Resume Job Matcher',
      'subtitle': 'NLP-based Screening Tool',
      'description': 'An NLP-based resume screening tool using Python keyword extraction and text similarity algorithms, improving resume-to-job matching accuracy by 35%.',
      'tech': ['Python', 'NLP'],
      'github': 'https://github.com/AR955593',
      'icon': Icons.description,
      'gradientColors': [Color(0xFF4776E6), Color(0xFF8E54E9)],
    },
    {
      'title': 'Weather Forecast App',
      'subtitle': 'Cross-Platform Weather App',
      'description': 'Cross-platform mobile app integrating real-time weather APIs to display temperature, humidity, wind speed, and 7-day forecasts.',
      'tech': ['Flutter', 'REST API'],
      'github': 'https://github.com/AR955593',
      'icon': Icons.wb_cloudy,
      'gradientColors': [Color(0xFF2980B9), Color(0xFF6DD5FA)],
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
            Icon(Icons.work_outline, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(width: 8),
            Text(
              'Featured Projects',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
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

class _ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gradient project banner
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: (project['gradientColors'] as List<Color>),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  project['icon'] as IconData,
                  size: 48,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox(height: 8),
                Text(
                  project['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project['title'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  project['subtitle'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  project['description'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (project['tech'] as List<String>).map((t) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
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
                      final Uri url = Uri.parse(project['github']);
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch url');
                      }
                    },
                    icon: const Icon(Icons.code),
                    label: const Text('View Source'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
