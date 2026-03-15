import 'package:flutter/material.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.emoji_events, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Achievements & Education',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              _buildTimelineItem(
                context,
                title: 'B.Tech - Computer Science Engineering (Data Science)',
                subtitle: 'Maharana Pratap Engineering College, Kanpur | 2023 – 2027 | CGPA: 7.1',
                icon: Icons.school,
                isLast: false,
              ),
              _buildTimelineItem(
                context,
                title: '120+ DSA Problems Solved',
                subtitle: 'LeetCode & HackerRank',
                icon: Icons.code,
                isLast: false,
              ),
              _buildTimelineItem(
                context,
                title: '5-Star Gold Badge in Python',
                subtitle: 'HackerRank (2024)',
                icon: Icons.star,
                isLast: false,
              ),
              _buildTimelineItem(
                context,
                title: '5-Star Gold Badge in SQL',
                subtitle: 'HackerRank (2024)',
                icon: Icons.star,
                isLast: false,
              ),
              _buildTimelineItem(
                context,
                title: 'PW Hackathon 2024 Participant',
                subtitle: 'Collaborated in a team to build innovative software solutions',
                icon: Icons.group,
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem(BuildContext context, {required String title, required String subtitle, required IconData icon, required bool isLast}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24), // spacing for the next item
            ],
          ),
        ),
      ],
    );
  }
}
