import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class GitHubStatsSection extends StatefulWidget {
  const GitHubStatsSection({super.key});

  @override
  State<GitHubStatsSection> createState() => _GitHubStatsSectionState();
}

class _GitHubStatsSectionState extends State<GitHubStatsSection> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _githubData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _apiService.fetchGitHubStats();
    if (mounted) {
      setState(() {
        _githubData = data;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_githubData == null) {
      return const SizedBox.shrink(); // Hide if failed
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(width: 8),
            Text(
              'GitHub Stats',
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Public Repos', (_githubData!['public_repos'] ?? 0).toString()),
              _buildStatItem('Followers', (_githubData!['followers'] ?? 0).toString()),
              _buildStatItem('Following', (_githubData!['following'] ?? 0).toString()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
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
