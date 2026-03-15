import 'package:flutter/material.dart';
import '../../widgets/projects_section.dart';

class ProjectsTab extends StatelessWidget {
  const ProjectsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 120),
        child: ProjectsSection(),
      ),
    );
  }
}
