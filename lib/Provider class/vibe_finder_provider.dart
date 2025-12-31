import 'package:flutter/material.dart';

class VibeFinderProvider extends ChangeNotifier{
  String? currentmood;

  void changeMood(String? mood){
    currentmood = mood;
    notifyListeners();
  }
}