import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/about_section.dart';
import '../../widgets/contact_section.dart';
import '../../widgets/projects_section.dart';
import '../../widgets/skills_section.dart';

class HomeTab extends StatefulWidget {
  final ValueChanged<int>? onSectionChanged;

  const HomeTab({super.key, this.onSectionChanged});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _fadeController;
  late final AnimationController _shiftController;
  late final Animation<double> _pulse;
  late final Animation<double> _fade;
  late final Animation<double> _shift;
  late final ScrollController _scrollController;

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _scrollViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleScroll());

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
    _fade = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);

    _shiftController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
    _shift = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _shiftController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _pulseController.dispose();
    _fadeController.dispose();
    _shiftController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _shift,
      builder: (context, child) {
        // Smoothly animate the gradient alignment
        final begin = Alignment(
          -1.0 + _shift.value * 0.6,
          -1.0 + _shift.value * 0.4,
        );
        final end = Alignment(
          1.0 - _shift.value * 0.4,
          1.0 - _shift.value * 0.6,
        );

        return Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? LinearGradient(
                    colors: const [
                      Color(0xFF0F0C29),
                      Color(0xFF302B63),
                      Color(0xFF24243E),
                    ],
                    begin: begin,
                    end: end,
                  )
                : LinearGradient(
                    colors: const [
                      Color(0xFFE8EAF6),
                      Color(0xFFF3E5F5),
                      Color(0xFFE3F2FD),
                    ],
                    begin: begin,
                    end: end,
                  ),
          ),
          child: child,
        );
      },
      child: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SingleChildScrollView(
            key: _scrollViewKey,
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),

                    // Glowing Pulsing Profile Ring
                    AnimatedBuilder(
                      animation: _pulse,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulse.value,
                          child: child,
                        );
                      },
                      child: _buildProfileRing(context),
                    ),

                    const SizedBox(height: 28),

                    // Gradient Name
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          const LinearGradient(
                            colors: [Color(0xFFBB86FC), Color(0xFF00FFCC)],
                          ).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      blendMode: BlendMode.srcIn,
                      child: const Text(
                        'Ankit Rajput',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Role Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFBB86FC), Color(0xFF6200EE)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6200EE).withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Full Stack Developer · Data Science Student',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Tagline
                    Text(
                      '"Building AI Powered Applications\n& Scalable Software Systems"',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: isDark ? Colors.white60 : Colors.black54,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),
                    _buildSectionNav(),
                    const SizedBox(height: 24),

                    // Stat Pills
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _StatPill(
                          label: '150+',
                          sub: 'DSA Solved',
                          icon: Icons.code,
                          color: const Color(0xFF00FFCC),
                        ),
                        _StatPill(
                          label: '4+',
                          sub: 'Projects',
                          icon: Icons.rocket_launch,
                          color: const Color(0xFFBB86FC),
                        ),
                        _StatPill(
                          label: '3★',
                          sub: 'HackerRank',
                          icon: Icons.star,
                          color: const Color(0xFFFFD700),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Glassmorphism Info Card
                    _buildInfoCard(isDark),

                    const SizedBox(height: 28),

                    // Gradient Social Buttons
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        _GradientSocialButton(
                          text: 'GitHub',
                          icon: Icons.code,
                          url: 'https://github.com/AR955593',
                          colors: const [Color(0xFF434343), Color(0xFF000000)],
                        ),
                        _GradientSocialButton(
                          text: 'LinkedIn',
                          icon: Icons.work,
                          url: 'https://linkedin.com/in/ar955593',
                          colors: const [Color(0xFF0077B5), Color(0xFF005580)],
                        ),
                        _GradientSocialButton(
                          text: 'LeetCode',
                          icon: Icons.leaderboard,
                          url: 'https://leetcode.com/u/AR955593',
                          colors: const [Color(0xFFFFA116), Color(0xFFE07B00)],
                        ),
                        _GradientSocialButton(
                          text: 'HackerRank',
                          icon: Icons.star,
                          url: 'https://hackerrank.com/ARRAJPUT',
                          colors: const [Color(0xFF00EA64), Color(0xFF00A844)],
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),
                    Container(
                      key: _aboutKey,
                      width: double.infinity,
                      child: const AboutSection(),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      key: _skillsKey,
                      width: double.infinity,
                      child: const SkillsSection(),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      key: _projectsKey,
                      width: double.infinity,
                      child: ProjectsSection(),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      key: _contactKey,
                      width: double.infinity,
                      child: const ContactSection(),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionNav() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        _SectionNavButton(
          key: const ValueKey('section-nav-about'),
          label: 'About',
          onTap: () {
            widget.onSectionChanged?.call(1);
            _scrollToSection(_aboutKey);
          },
        ),
        _SectionNavButton(
          key: const ValueKey('section-nav-skills'),
          label: 'Skills',
          onTap: () {
            widget.onSectionChanged?.call(2);
            _scrollToSection(_skillsKey);
          },
        ),
        _SectionNavButton(
          key: const ValueKey('section-nav-projects'),
          label: 'Projects',
          onTap: () {
            widget.onSectionChanged?.call(3);
            _scrollToSection(_projectsKey);
          },
        ),
        _SectionNavButton(
          key: const ValueKey('section-nav-contact'),
          label: 'Contact',
          onTap: () {
            widget.onSectionChanged?.call(4);
            _scrollToSection(_contactKey);
          },
        ),
      ],
    );
  }

  void _handleScroll() {
    final aboutOffset = _getOffset(_aboutKey);
    final skillsOffset = _getOffset(_skillsKey);
    final projectsOffset = _getOffset(_projectsKey);
    final contactOffset = _getOffset(_contactKey);
    const viewportThreshold = 220.0;

    if (contactOffset <= viewportThreshold + 120) {
      widget.onSectionChanged?.call(4);
    } else if (projectsOffset <= viewportThreshold + 120) {
      widget.onSectionChanged?.call(3);
    } else if (skillsOffset <= viewportThreshold + 120) {
      widget.onSectionChanged?.call(2);
    } else if (aboutOffset <= viewportThreshold + 120) {
      widget.onSectionChanged?.call(1);
    } else {
      widget.onSectionChanged?.call(0);
    }
  }

  double _getOffset(GlobalKey key) {
    final context = key.currentContext;
    final viewportContext = _scrollViewKey.currentContext;
    if (context == null || viewportContext == null) return double.infinity;

    final renderBox = context.findRenderObject() as RenderBox?;
    final viewportBox = viewportContext.findRenderObject() as RenderBox?;
    if (renderBox == null || viewportBox == null) return double.infinity;

    final sectionOffset = renderBox.localToGlobal(Offset.zero);
    final viewportOffset = viewportBox.localToGlobal(Offset.zero);
    return sectionOffset.dy - viewportOffset.dy;
  }

  void _scrollToSection(GlobalKey key) {
    final sectionContext = key.currentContext;
    if (sectionContext == null) return;
    Scrollable.ensureVisible(
      sectionContext,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0.1,
    );
  }

  Widget _buildProfileRing(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer glow ring
        Container(
          width: 180,
          height: 180,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: [
                Color(0xFFBB86FC),
                Color(0xFF00FFCC),
                Color(0xFFD400FF),
                Color(0xFFBB86FC),
              ],
            ),
          ),
        ),
        // Inner gap
        Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? const Color(0xFF0F0C29) : const Color(0xFFE8EAF6),
          ),
        ),
        // Profile image
        Container(
          width: 160,
          height: 160,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/profile.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.07)
                : Colors.black.withOpacity(0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.12)
                  : Colors.black.withOpacity(0.08),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoRow(
                Icons.location_on,
                'Kanpur, Uttar Pradesh, India',
                isDark,
              ),
              const SizedBox(height: 10),
              _infoRow(
                Icons.school,
                'B.Tech CSE (Data Science) · MPEC Kanpur · 2023–2027',
                isDark,
              ),
              const SizedBox(height: 10),
              _infoRow(Icons.email, 'ankitrajankitraj817@gmail.com', isDark),
              const SizedBox(height: 10),
              _infoRow(Icons.phone, '+91-9555937872', isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, bool isDark) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFBB86FC), size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

// --- Stat Pill ---
class _StatPill extends StatelessWidget {
  final String label;
  final String sub;
  final IconData icon;
  final Color color;

  const _StatPill({
    required this.label,
    required this.sub,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Text(sub, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _SectionNavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SectionNavButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.95),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }
}

// --- Gradient Social Button ---
class _GradientSocialButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final String url;
  final List<Color> colors;

  const _GradientSocialButton({
    required this.text,
    required this.icon,
    required this.url,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (!await launchUrl(uri)) {
          throw Exception('Could not launch $url');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: colors.last.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 17, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
