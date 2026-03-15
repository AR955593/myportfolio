import 'package:flutter/material.dart';
import '../../widgets/skills_section.dart';

class SkillsTab extends StatelessWidget {
  const SkillsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 40, 24, 120),
        child: SkillsSection(),
      ),
    );
  }
}
