import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String githubUrl = 'https://api.github.com/users/AR955593';
  static const String leetcodeUrl = 'https://leetcode.com/graphql';

  // Fetch GitHub User Data
  Future<Map<String, dynamic>?> fetchGitHubStats() async {
    try {
      final response = await http.get(Uri.parse(githubUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      print('Error fetching GitHub stats: \$e');
      return null;
    }
  }

  // Fetch LeetCode Stats (using public GraphQL)
  Future<Map<String, dynamic>?> fetchLeetCodeStats() async {
    try {
      const String query = '''
      {
        matchedUser(username: "AR955593") {
          username
          submitStats: submitStatsGlobal {
            acSubmissionNum {
              difficulty
              count
              submissions
            }
          }
        }
      }
      ''';
      
      final response = await http.post(
        Uri.parse(leetcodeUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'query': query}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      print('Error fetching LeetCode stats: \$e');
      return null;
    }
  }
}
