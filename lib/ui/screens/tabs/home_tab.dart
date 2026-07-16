import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_app/services/resume_service.dart';

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
  late final Animation<double> _shift;
  late final ScrollController _scrollController;

  // Staggered Animations
  late final Animation<double> _profileFade;
  late final Animation<Offset> _profileSlide;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _statsFade;
  late final Animation<Offset> _statsSlide;
  late final Animation<double> _infoFade;
  late final Animation<Offset> _infoSlide;
  late final Animation<double> _socialFade;
  late final Animation<Offset> _socialSlide;
  late final Animation<double> _bodyFade;
  late final Animation<Offset> _bodySlide;

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
      duration: const Duration(milliseconds: 1600),
    )..forward();

    const curve = Curves.easeOutCubic;

    _profileFade = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.0, 0.4, curve: curve),
    );
    _profileSlide = Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _fadeController, curve: const Interval(0.0, 0.4, curve: curve)),
    );

    _titleFade = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.15, 0.55, curve: curve),
    );
    _titleSlide = Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _fadeController, curve: const Interval(0.15, 0.55, curve: curve)),
    );

    _statsFade = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.3, 0.7, curve: curve),
    );
    _statsSlide = Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _fadeController, curve: const Interval(0.3, 0.7, curve: curve)),
    );

    _infoFade = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.45, 0.85, curve: curve),
    );
    _infoSlide = Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _fadeController, curve: const Interval(0.45, 0.85, curve: curve)),
    );

    _socialFade = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.6, 1.0, curve: curve),
    );
    _socialSlide = Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _fadeController, curve: const Interval(0.6, 1.0, curve: curve)),
    );

    _bodyFade = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.7, 1.0, curve: curve),
    );
    _bodySlide = Tween<Offset>(begin: const Offset(0.0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _fadeController, curve: const Interval(0.7, 1.0, curve: curve)),
    );

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
                      Color(0xFF0F1115),
                      Color(0xFF16181D),
                    ],
                    begin: begin,
                    end: end,
                  )
                : LinearGradient(
                    colors: const [
                      Color(0xFFF8F9FA),
                      Color(0xFFF1F3F5),
                    ],
                    begin: begin,
                    end: end,
                  ),
          ),
          child: child,
        );
      },
      child: SafeArea(
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

                  // Staggered Profile Ring
                  FadeTransition(
                    opacity: _profileFade,
                    child: SlideTransition(
                      position: _profileSlide,
                      child: AnimatedBuilder(
                        animation: _pulse,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulse.value,
                            child: child,
                          );
                        },
                        child: _buildProfileRing(context),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Staggered Name + Badge + Tagline
                  FadeTransition(
                    opacity: _titleFade,
                    child: SlideTransition(
                      position: _titleSlide,
                      child: Column(
                        children: [
                          Text(
                            'Ankit Rajput',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              color: Theme.of(context).textTheme.displayLarge?.color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
                              border: Border.all(
                                color: Theme.of(context).primaryColor.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Text(
                              'Full Stack Developer · Data Science Student',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 14),
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
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  _buildSectionNav(),
                  const SizedBox(height: 24),

                  // Staggered Stats Pills
                  FadeTransition(
                    opacity: _statsFade,
                    child: SlideTransition(
                      position: _statsSlide,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _StatPill(
                            label: '150+',
                            sub: 'DSA Solved',
                            icon: Icons.code,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          _StatPill(
                            label: '4+',
                            sub: 'Projects',
                            icon: Icons.rocket_launch,
                            color: Theme.of(context).primaryColor,
                          ),
                          _StatPill(
                            label: '3★',
                            sub: 'HackerRank',
                            icon: Icons.star,
                            color: isDark ? const Color(0xFFF59E0B) : const Color(0xFFD97706),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Staggered Info Card
                  FadeTransition(
                    opacity: _infoFade,
                    child: SlideTransition(
                      position: _infoSlide,
                      child: _buildInfoCard(isDark),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Staggered Social Buttons
                  FadeTransition(
                    opacity: _socialFade,
                    child: SlideTransition(
                      position: _socialSlide,
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          _PremiumSocialButton(
                            text: 'Resume',
                            icon: Icons.description_rounded,
                            onTap: () async {
                              await ResumeService.generateAndDownload();
                            },
                            brandColor: Theme.of(context).primaryColor,
                          ),
                          _PremiumSocialButton(
                            text: 'GitHub',
                            icon: Icons.code,
                            url: 'https://github.com/AR955593',
                            brandColor: isDark ? Colors.white : Colors.black87,
                          ),
                          _PremiumSocialButton(
                            text: 'LinkedIn',
                            icon: Icons.work,
                            url: 'https://linkedin.com/in/ar955593',
                            brandColor: const Color(0xFF0077B5),
                          ),
                          _PremiumSocialButton(
                            text: 'LeetCode',
                            icon: Icons.leaderboard,
                            url: 'https://leetcode.com/u/AR955593',
                            brandColor: const Color(0xFFFFA116),
                          ),
                          _PremiumSocialButton(
                            text: 'HackerRank',
                            icon: Icons.star,
                            url: 'https://hackerrank.com/ARRAJPUT',
                            brandColor: const Color(0xFF00EA64),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Staggered Body Sections
                  FadeTransition(
                    opacity: _bodyFade,
                    child: SlideTransition(
                      position: _bodySlide,
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
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
    final primaryAccent = Theme.of(context).primaryColor;
    final secondaryAccent = Theme.of(context).colorScheme.secondary;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Premium subtle border ring
        Container(
          width: 176,
          height: 176,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [primaryAccent, secondaryAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // Inner gap matching theme background
        Container(
          width: 168,
          height: 168,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).scaffoldBackgroundColor,
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
        Icon(icon, color: Theme.of(context).primaryColor, size: 16),
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
class _StatPill extends StatefulWidget {
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
  State<_StatPill> createState() => _StatPillState();
}

class _StatPillState extends State<_StatPill> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.diagonal3Values(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0, 1.0)
          ..setTranslationRaw(0.0, _isHovered ? -4.0 : 0.0, 0.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: _isHovered ? 0.18 : 0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.color.withValues(alpha: _isHovered ? 0.6 : 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? widget.color.withValues(alpha: 0.15)
                    : Colors.transparent,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: widget.color, size: 20),
              const SizedBox(height: 4),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                widget.sub,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
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

// --- Premium Social Button ---
class _PremiumSocialButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final String? url;
  final VoidCallback? onTap;
  final Color brandColor;

  const _PremiumSocialButton({
    required this.text,
    required this.icon,
    this.url,
    this.onTap,
    required this.brandColor,
  });

  @override
  State<_PremiumSocialButton> createState() => _PremiumSocialButtonState();
}

class _PremiumSocialButtonState extends State<_PremiumSocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(0.0, _isHovered ? -3.0 : 0.0, 0.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () async {
            if (widget.onTap != null) {
              widget.onTap!();
            } else if (widget.url != null) {
              final Uri uri = Uri.parse(widget.url!);
              if (!await launchUrl(uri)) {
                throw Exception('Could not launch ${widget.url}');
              }
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            decoration: BoxDecoration(
              color: _isHovered
                  ? widget.brandColor.withValues(alpha: 0.08)
                  : theme.cardColor,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: _isHovered
                    ? widget.brandColor
                    : theme.dividerColor.withValues(alpha: 0.6),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? widget.brandColor.withValues(alpha: 0.15)
                      : (isDark ? Colors.black.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.03)),
                  blurRadius: _isHovered ? 8 : 4,
                  offset: _isHovered ? const Offset(0, 4) : const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, size: 17, color: widget.brandColor),
                const SizedBox(width: 8),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
