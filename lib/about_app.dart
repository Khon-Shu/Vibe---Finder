import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 180,
              backgroundColor: Color(0xFF50C878),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF50C878), Color(0xFF3BA66A)],
                    ),
                  ),
                  child: Center(
                    child: TweenAnimationBuilder(
                      duration: Duration(milliseconds: 1200),
                      tween: Tween<double>(begin: 0, end: 1),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.location_on_outlined,
                              size: 40,
                              color: Color(0xFF50C878),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Vibe Finder",
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            "Version 1.0.0",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              pinned: true,
              elevation: 0,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  children: [
                    // App Description Card with Animation
                    _buildAnimatedCard(
                      delay: 200,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: Color(0xFF50C878),
                                  size: 24,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  "Discover Your Perfect Vibe",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Vibe Finder is your personal mood-based location discovery app. Whether you're feeling adventurous, relaxed, social, or focused, we find places that perfectly match your emotional state.",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                height: 1.6,
                                color: Color(0xFF666666),
                              ),
                            ),
                            SizedBox(height: 20),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _buildFeatureChip(
                                  icon: Icons.mood,
                                  text: "Mood-Based",
                                ),
                                _buildFeatureChip(
                                  icon: Icons.location_on,
                                  text: "Nearby Places",
                                ),
                                _buildFeatureChip(
                                  icon: Icons.map_outlined,
                                  text: "Google Maps",
                                ),
                                _buildFeatureChip(
                                  icon: Icons.thumb_up,
                                  text: "Easy to Use",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
        
                    SizedBox(height: 24),
        
                    // Developer Profile with Animation
                    _buildAnimatedCard(
                      delay: 400,
                      child: Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF50C878).withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person_outline,
                                    color: Color(0xFF50C878),
                                    size: 28,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Amit Muni Bajracharya",
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1A1A1A),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Flutter Developer",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: Color(0xFF50C878),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Divider(
                              height: 1,
                              color: Colors.grey.shade200,
                            ),
                            SizedBox(height: 20),
                            // Email Section - Simple Display
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        color: Color(0xFF50C878),
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Email",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF50C878),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () => _launchEmail(),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "amitbajracharya4444@gmail.com",
                                            style: GoogleFonts.inter(
                                              fontSize: 15,
                                              color: Colors.blue.shade700,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.open_in_new,
                                          size: 16,
                                          color: Colors.blue.shade700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        
                    SizedBox(height: 24),
        
                    // Educational Notice with Animation
                    _buildAnimatedCard(
                      delay: 600,
                      child: Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF50C878).withOpacity(0.1),
                              Color(0xFF2196F3).withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xFF50C878).withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF50C878).withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.school_outlined,
                                    color: Color(0xFF50C878),
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  "Educational Project",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF50C878),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              "This app was developed to demonstrate mobile development skills, location services integration, and modern UI/UX design principles. It's a showcase of technical capabilities and user-centered design.",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                height: 1.6,
                                color: Color(0xFF666666),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
        
                    SizedBox(height: 24),
        
                    // Feedback Section with Animation
                    _buildAnimatedCard(
                      delay: 800,
                      child: Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2196F3).withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.feedback_outlined,
                                    color: Color(0xFF2196F3),
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  "Feedback & Support",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Your feedback helps improve Vibe Finder. Feel free to share your thoughts, suggestions, or report any issues you encounter.",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                height: 1.6,
                                color: Color(0xFF666666),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Feedback Email
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        color: Color(0xFF2196F3),
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Feedback Email",
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF2196F3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () => _launchFeedbackEmail(),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "amitbajracharya4444@gmail.com",
                                            style: GoogleFonts.inter(
                                              fontSize: 15,
                                              color: Colors.blue.shade700,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.open_in_new,
                                          size: 16,
                                          color: Colors.blue.shade700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        
                    SizedBox(height: 24),
        
                    // Copyright Footer
                    _buildAnimatedCard(
                      delay: 1000,
                      child: Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "🎯 Built with Flutter",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF666666),
                              ),
                            ),
                            SizedBox(height: 12),
                            Divider(
                              height: 1,
                              color: Colors.grey.shade200,
                            ),
                            SizedBox(height: 12),
                            Text(
                              "© 2024 Vibe Finder",
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Educational Project | Version 1.0.0",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedCard({
    required int delay,
    required Widget child,
  }) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 600),
    
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 30),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildFeatureChip({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFF50C878).withOpacity(0.08),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Color(0xFF50C878).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Color(0xFF50C878),
          ),
          SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF50C878),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'amitbajracharya4444@gmail.com',
      query: 'subject=Vibe%20Finder%20App%20Contact',
    );
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint('Could not launch email');
    }
  }

  Future<void> _launchFeedbackEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'amitbajracharya4444@gmail.com',
      query: 'subject=Vibe%20Finder%20Feedback&body=Hi%20Amit,%0A%0AI%20love%20your%20Vibe%20Finder%20app!%0A%0AHere%27s%20my%20feedback:',
    );
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint('Could not launch feedback email');
    }
  }
}