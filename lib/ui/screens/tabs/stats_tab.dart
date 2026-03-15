import 'package:flutter/material.dart';
import '../../widgets/github_stats_section.dart';
import '../../widgets/leetcode_stats_section.dart';
import '../../widgets/achievements_section.dart';

class StatsTab extends StatelessWidget {
  const StatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 40, 24, 120),
        child: Column(
          children: [
            GitHubStatsSection(),
            SizedBox(height: 40),
            LeetCodeStatsSection(),
            SizedBox(height: 40),
            AchievementsSection(),
          ],
        ),
      ),
    );
  }
}
