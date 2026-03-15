import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class LeetCodeStatsSection extends StatefulWidget {
  const LeetCodeStatsSection({super.key});

  @override
  State<LeetCodeStatsSection> createState() => _LeetCodeStatsSectionState();
}

class _LeetCodeStatsSectionState extends State<LeetCodeStatsSection> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _leetcodeData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _apiService.fetchLeetCodeStats();
    if (mounted) {
      setState(() {
        if (data != null && data['data'] != null) {
          _leetcodeData = data['data']['matchedUser'];
        }
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_leetcodeData == null) {
      return const SizedBox.shrink(); // Hide if failed
    }

    // Extracting stats
    final stats = _leetcodeData!['submitStats']['acSubmissionNum'] as List;
    int all = 0, easy = 0, medium = 0, hard = 0;

    for (var stat in stats) {
      if (stat['difficulty'] == 'All') all = stat['count'];
      if (stat['difficulty'] == 'Easy') easy = stat['count'];
      if (stat['difficulty'] == 'Medium') medium = stat['count'];
      if (stat['difficulty'] == 'Hard') hard = stat['count'];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.leaderboard, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(width: 8),
            Text(
              'LeetCode Stats',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Total Solved: \$all',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDifficultyStat('Easy', easy, Colors.green),
                  _buildDifficultyStat('Medium', medium, Colors.orange),
                  _buildDifficultyStat('Hard', hard, Colors.red),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDifficultyStat(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          '\$value',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
