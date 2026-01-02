import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF50C878),
      body: Stack(
        children: [
          Container(color: const Color(0xFF50C878)),

          Positioned.fill(
            top: MediaQuery.of(context).padding.top + 16,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  children: [
                    /// LOGO + VERSION
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/mainlogo.png",
                          height: 120,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Version 1.0.0",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
    Divider(color: Colors.black),
    
                    const SizedBox(height: 12),
                    /// ABOUT APP
                    _buildAnimatedCard(
                      child: _sectionCard(
                        title: "About Vibe Finder",
                        icon: Icons.emoji_emotions_outlined,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vibe Finder is a mood-based location discovery app that helps users find places matching their emotional state—whether relaxed, adventurous, social, or focused.",
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                height: 1.6,
                                color: const Color(0xFF666666),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: const [
                                _FeatureChip(
                                    icon: Icons.mood, text: "Mood-Based"),
                                _FeatureChip(
                                    icon: Icons.location_on,
                                    text: "Nearby Places"),
                                _FeatureChip(
                                    icon: Icons.map_outlined,
                                    text: "Google Maps"),
                                _FeatureChip(
                                    icon: Icons.thumb_up,
                                    text: "Easy to Use"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                     const SizedBox(height: 12),
    Divider(color: Colors.black),
    
                    const SizedBox(height: 12),

                    /// DEVELOPER
                    _buildAnimatedCard(
                      child: _sectionCard(
                        title: "Developer",
                        icon: Icons.person_outline,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amit Muni Bajracharya",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Flutter Developer",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: const Color(0xFF50C878),
                              ),
                            ),
                            const SizedBox(height: 20),

                            /// EMAIL
                            _emailTile(
                              email: "amitbajracharya4444@gmail.com",
                              onTap: _launchEmail,
                            ),

                            const SizedBox(height: 12),

                            /// GITHUB
                            _linkTile(
                              icon: Icons.code,
                              text: "github.com/Khon-Shu",
                              onTap: _launchGithub,
                            ),
                          ],
                        ),
                      ),
                    ),

                   const SizedBox(height: 12),
    Divider(color: Colors.black),
    
                    const SizedBox(height: 12),
                    /// EDUCATIONAL NOTICE
                    _buildAnimatedCard(
                      child: _sectionCard(
                        title: "Educational Project",
                        icon: Icons.school_outlined,
                        gradient: true,
                        child: Text(
                          "This application was created to demonstrate Flutter development skills, location services integration, and modern UI/UX design principles. It serves as an academic and portfolio project.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            height: 1.6,
                            color: const Color(0xFF666666),
                          ),
                        ),
                      ),
                    ),

               const SizedBox(height: 12),
    Divider(color: Colors.black),
    
                    const SizedBox(height: 12),

                    /// FEEDBACK
                    _buildAnimatedCard(
                      child: _sectionCard(
                        title: "Feedback & Support",
                        icon: Icons.feedback_outlined,
                        iconColor: Colors.blue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your feedback helps improve the app. Feel free to share suggestions or report issues.",
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                height: 1.6,
                                color: const Color(0xFF666666),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _emailTile(
                              email: "amitbajracharya4444@gmail.com",
                              onTap: _launchFeedbackEmail,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
    Divider(color: Colors.black),
    
                    const SizedBox(height: 12),

                    /// FOOTER
                    Text(
                      "© 2026 Vibe Finder • Built with Flutter",
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ANIMATION
  static Widget _buildAnimatedCard({required Widget child}) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0, end: 1),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 30),
          child: Opacity(opacity: value, child: child),
        );
      },
    );
  }

  /// EMAIL
  static Future<void> _launchEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'amitbajracharya4444@gmail.com',
      query: 'subject=Vibe Finder Contact',
    );
    await launchUrl(uri);
  }

  static Future<void> _launchFeedbackEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'amitbajracharya4444@gmail.com',
      query: 'subject=Vibe Finder Feedback',
    );
    await launchUrl(uri);
  }

  /// GITHUB
  static Future<void> _launchGithub() async {
    final uri = Uri.parse("https://github.com/Khon-Shu");
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

/// SECTION CARD
Widget _sectionCard({
  required String title,
  required IconData icon,
  required Widget child,
  Color iconColor = const Color(0xFF50C878),
  bool gradient = false,
}) {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: gradient
          ? LinearGradient(
              colors: [
                const Color(0xFF50C878).withOpacity(0.1),
                Colors.blue.withOpacity(0.1),
              ],
            )
          : null,
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    ),
  );
}

/// FEATURE CHIP
class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF50C878).withOpacity(0.08),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color(0xFF50C878).withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF50C878)),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF50C878),
            ),
          ),
        ],
      ),
    );
  }
}

/// EMAIL TILE
Widget _emailTile({
  required String email,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.email_outlined, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              email,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: Colors.blue.shade700,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const Icon(Icons.open_in_new, size: 16),
        ],
      ),
    ),
  );
}

/// LINK TILE (GITHUB)
Widget _linkTile({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: Colors.blue.shade700,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const Icon(Icons.open_in_new, size: 16),
        ],
      ),
    ),
  );
}
