import 'package:flutter/material.dart';
import '../../widgets/contact_section.dart';

class ContactTab extends StatelessWidget {
  const ContactTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 40, 24, 120),
        child: ContactSection(),
      ),
    );
  }
}
