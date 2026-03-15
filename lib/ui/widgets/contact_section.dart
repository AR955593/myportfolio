import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.contact_mail, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(width: 8),
            Text(
              'Get In Touch',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 600;
              
              if (isMobile) {
                return Column(
                  children: [
                    _buildContactInfo(context),
                    const SizedBox(height: 32),
                    _buildContactForm(context),
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildContactInfo(context),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 2,
                      child: _buildContactForm(context),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 20),
        _contactItem(context, Icons.email, 'ankitrajankitraj817@gmail.com', 'mailto:ankitrajankitraj817@gmail.com'),
        const SizedBox(height: 16),
        _contactItem(context, Icons.phone, '+91-9555937872', 'tel:+919555937872'),
        const SizedBox(height: 16),
        _contactItem(context, Icons.location_on, 'Kanpur, Uttar Pradesh, India', null),
        const SizedBox(height: 32),
        Row(
          children: [
            _socialIcon(context, Icons.link, 'https://linkedin.com/in/ar955593'),
            const SizedBox(width: 16),
            _socialIcon(context, Icons.code, 'https://github.com/AR955593'),
          ],
        )
      ],
    );
  }

  Widget _contactItem(BuildContext context, IconData icon, String text, String? url) {
    return InkWell(
      onTap: url != null ? () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      } : null,
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    decoration: url != null ? TextDecoration.underline : TextDecoration.none,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(BuildContext context, IconData icon, String url) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Theme.of(context).primaryColor),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Send a Message',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Message',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            // Add send logic here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Message sent successfully! (Demo)')),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text('Send Message'),
        ),
      ],
    );
  }
}
