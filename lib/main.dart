import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibefinder/homepage.dart';

void main() {
  runApp( VibeFinder());
}

class VibeFinder extends StatelessWidget {
  const VibeFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
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
            fontSize: 20
          )
           )
        ),
        
      home: const Homepage(),
    );
  }
}

