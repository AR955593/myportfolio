import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/theme_provider.dart';
import 'tabs/about_tab.dart';
import 'tabs/contact_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/projects_tab.dart';
import 'tabs/skills_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  int _activeNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: isDark
            ? Colors.black.withValues(alpha: 0.25)
            : Colors.white.withValues(alpha: 0.75),
        elevation: 0,
        titleSpacing: 16,
        toolbarHeight: 76,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: const AssetImage('assets/images/profile.jpg'),
              backgroundColor: Theme.of(
                context,
              ).primaryColor.withValues(alpha: 0.15),
            ),
            const SizedBox(width: 12),
            const Text(
              'Ankit Rajput',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _navButton(context, 'Home', 0),
                    _navButton(context, 'About', 1),
                    _navButton(context, 'Skills', 2),
                    _navButton(context, 'Projects', 3),
                    _navButton(context, 'Contact', 4),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Tooltip(
                message: 'Install app',
                child: TextButton.icon(
                  onPressed: () => _handleInstallApp(context),
                  icon: const Icon(Icons.download_rounded, size: 18),
                  label: const Text('Install App'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return IconButton(
                  onPressed: themeProvider.toggleTheme,
                  icon: Icon(
                    themeProvider.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF0F0C29),
                    const Color(0xFF302B63),
                    const Color(0xFF24243E),
                  ]
                : [const Color(0xFFFDFBFB), const Color(0xFFEBEDEE)],
          ),
        ),
        child: IndexedStack(
          index: _pageIndex,
          children: [
            HomeTab(onSectionChanged: _handleSectionChanged),
            const AboutTab(),
            const SkillsTab(),
            const ProjectsTab(),
            const ContactTab(),
          ],
        ),
      ),
    );
  }

  void _handleNavSelection(int index) {
    setState(() {
      _activeNavIndex = index;
      _pageIndex = index;
    });
  }

  Future<void> _handleInstallApp(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);

    if (kIsWeb) {
      // NOTE: Replace this with your Google Drive / Firebase / GitHub Release direct link
      const String apkDownloadUrl = 'YOUR_APK_DOWNLOAD_LINK';

      final Uri uri;
      if (apkDownloadUrl != 'YOUR_APK_DOWNLOAD_LINK' && apkDownloadUrl.isNotEmpty) {
        uri = Uri.parse(apkDownloadUrl);
      } else {
        uri = Uri.parse('${Uri.base.origin}/app-release.apk');
      }

      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text(
              'APK download link is not available. Configure apkDownloadUrl or place app-release.apk in the web folder.',
            ),
          ),
        );
      }
      return;
    }

    final apkPath = Platform.isWindows
        ? r'C:\Users\ankit\Videos\Flutter\MY protfolio\portfolio_app\build\app\outputs\flutter-apk\app-release.apk'
        : '/storage/emulated/0/Download/portfolio_app-release.apk';

    final file = File(apkPath);
    if (!file.existsSync()) {
      messenger.showSnackBar(
        SnackBar(content: Text('APK not found at $apkPath')),
      );
      return;
    }

    final uri = Uri.file(apkPath);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      messenger.showSnackBar(
        SnackBar(content: Text('Unable to open APK at $apkPath')),
      );
    }
  }

  void _handleSectionChanged(int index) {
    if (!mounted) return;
    setState(() {
      _activeNavIndex = index;
    });
  }

  Widget _navButton(BuildContext context, String label, int index) {
    final isSelected = _activeNavIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: () => _handleNavSelection(index),
        style: TextButton.styleFrom(
          foregroundColor: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).textTheme.bodyMedium?.color,
          backgroundColor: isSelected
              ? Theme.of(context).primaryColor.withValues(alpha: 0.12)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
