import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vibefinder/Provider%20class/vibe_finder_provider.dart';
import 'package:vibefinder/homepage.dart';
import 'package:vibefinder/launchpage.dart';

void main() {
  runApp( VibeFinder());
}

class VibeFinder extends StatelessWidget {
  const VibeFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> VibeFinderProvider())
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
       debugShowCheckedModeBanner: false,
       theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
  brightness: Brightness.light,
  
  // Primary colors
  primary: Color.fromARGB(255, 123, 198, 89),           // Olive Green
  onPrimary: Colors.white,
  primaryContainer: Color(0xFF8A9456),  // Lighter olive
  onPrimaryContainer: Color(0xFF1A1D0F),
  
  // Secondary colors
  secondary: Color(0xFF52B788),         // Changed to complementary green (was too light)
  onSecondary: Colors.white,
  secondaryContainer: Color(0xFFD8F3DC),
  onSecondaryContainer: Color(0xFF1B4332),
  
  // Tertiary colors
  tertiary: Color(0xFFFDFDF1),          // Your light beige as accent
  onTertiary: Color(0xFF1A1D0F),
  tertiaryContainer: Color(0xFFFFFDF7),
  onTertiaryContainer: Color(0xFF2D3319),
  
  // Error colors
  error: Color(0xFFEF4444),
  onError: Colors.white,
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),
  


  
  // Surface colors
  surface: Color(0xFFF9FAFB),           // Cards
  onSurface: Color(0xFF1F2937),

  onSurfaceVariant: Color(0xFF4B5563),
  
  // Other colors
  outline: Color(0xFF9CA3AF),
  outlineVariant: Color(0xFFD1D5DB),
  shadow: Colors.black,
  scrim: Colors.black,
  inverseSurface: Color(0xFF1F2937),
  onInverseSurface: Color(0xFFF9FAFB),
  inversePrimary: Color(0xFFA7C957),
),
          textTheme: GoogleFonts.montserratTextTheme().copyWith(
            titleLarge:GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),
            titleMedium: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          bodyLarge: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),
          bodySmall: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 16
          )
             )
          ),
          
        home: const Launchpage(),
      ),
    );
  }
}

