import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bolt, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(width: 8),
            Text(
              'Skills & Expertise',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSkillCategory(context, 'Programming Languages', [
          'Python', 'Java', 'C', 'JavaScript', 'Dart'
        ]),
        const SizedBox(height: 16),
        _buildSkillCategory(context, 'Frontend Development', [
          'React.js', 'HTML5', 'CSS3', 'Tailwind CSS', 'Responsive Web Design'
        ]),
        const SizedBox(height: 16),
        _buildSkillCategory(context, 'Backend Development', [
          'Node.js', 'Flask', 'REST APIs', 'Server-Side Architecture'
        ]),
        const SizedBox(height: 16),
        _buildSkillCategory(context, 'Mobile & AI', [
          'Flutter', 'TensorFlow', 'OpenCV', 'Computer Vision', 'Deep Learning'
        ]),
        const SizedBox(height: 16),
        _buildSkillCategory(context, 'Database Technologies', [
          'MySQL', 'Firebase', 'SQL', 'CRUD Operations'
        ]),
        const SizedBox(height: 16),
        _buildSkillCategory(context, 'Tools & Platforms', [
          'Git', 'GitHub', 'Linux', 'VS Code', 'API Integration'
        ]),
      ],
    );
  }

  Widget _buildSkillCategory(BuildContext context, String title, List<String> skills) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: skills.map((skill) {
              return Chip(
                label: Text(skill),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                side: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
