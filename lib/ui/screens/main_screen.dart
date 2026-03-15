import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const AboutTab(),
    const SkillsTab(),
    const ProjectsTab(),
    const ContactTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true, // Allows body to scroll behind the navigation bar
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF0F0C29), // Deep Space
                    const Color(0xFF302B63), // Purple/Blue metallic
                    const Color(0xFF24243E), // Dark slate
                  ]
                : [
                    const Color(0xFFFDFBFB), // Light pearl
                    const Color(0xFFEBEDEE), // Light gray
                  ],
          ),
        ),
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: SalomonBottomBar(
                currentIndex: _currentIndex,
                onTap: (i) => setState(() => _currentIndex = i),
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                items: [
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.space_dashboard_rounded),
                    title: const Text("Home"),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.account_circle_rounded),
                    title: const Text("About"),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.psychology_rounded),
                    title: const Text("Skills"),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.developer_mode_rounded),
                    title: const Text("Projects"),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.contact_mail_rounded),
                    title: const Text("Contact"),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
