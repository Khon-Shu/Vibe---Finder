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
            primary: Color(0xFF02C57A),
      
            onPrimary: Colors.white,
            secondary: Color(0xFFF8FE06),
            onSecondary: Colors.white,
            error: Color(0xFFEF4444),
            onError: Colors.white,
           
            surface: Color(0xFFF9FAFB),       // Cards
            onSurface: Color(0xFF1F2937),
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

