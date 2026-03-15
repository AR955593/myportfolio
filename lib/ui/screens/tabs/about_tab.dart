import 'package:flutter/material.dart';
import 'package:portfolio_app/services/resume_service.dart';
import '../../widgets/about_section.dart';
import '../../widgets/achievements_section.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              AboutSection(),
              SizedBox(height: 32),
              AchievementsSection(),
              SizedBox(height: 120), // Padding for FAB & nav bar
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton.extended(
          onPressed: () async {
            await ResumeService.generateAndDownload();
          },
          icon: const Icon(Icons.download),
          label: const Text('Download Resume'),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          elevation: 8,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
