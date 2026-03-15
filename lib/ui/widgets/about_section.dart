import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Theme.of(context).primaryColor, size: 28),
              const SizedBox(width: 8),
              Text(
                'About Me',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Computer Science and Data Science undergraduate with hands-on expertise in Full Stack Development, Machine Learning, and Data Structures and Algorithms. Skilled in building production-ready web and mobile applications using React.js, Flutter, Python, Node.js, and Flask. Experienced in developing AI-powered systems using TensorFlow and OpenCV for computer vision and image processing. Solved 120+ Data Structures and Algorithms problems on LeetCode and HackerRank. Passionate about creating scalable, intelligent software solutions combining artificial intelligence, data science, and full stack engineering.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
          const SizedBox(height: 24),
          const Text(
            'Key Technologies:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _BuildTechChip('Flutter'),
              _BuildTechChip('React.js'),
              _BuildTechChip('Python'),
              _BuildTechChip('Node.js'),
              _BuildTechChip('TensorFlow'),
              _BuildTechChip('OpenCV'),
              _BuildTechChip('SQL'),
              _BuildTechChip('Firebase'),
            ],
          )
        ],
      ),
    );
  }

  Widget _BuildTechChip(String label) {
    return Builder(
      builder: (context) {
        return Chip(
          label: Text(label),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.3)),
          labelStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w600,
          ),
        );
      }
    );
  }
}
