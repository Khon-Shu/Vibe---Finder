import 'package:flutter/material.dart';
import 'package:vibefinder/homepage.dart';

void main() {
  runApp( VibeFinder());
}

class VibeFinder extends StatelessWidget {
  const VibeFinder({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
     
      home: const Homepage(),
    );
  }
}

