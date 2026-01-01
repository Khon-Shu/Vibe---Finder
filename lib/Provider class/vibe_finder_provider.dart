import 'package:flutter/material.dart';

class VibeFinderProvider extends ChangeNotifier{
  String? currentmood;
  String? currentLatitude;
  String? currentLongitude;

  void changeMood(String? mood){
    currentmood = mood;
    notifyListeners();
  }

  void getCurrentLocation(String? latititude, String? longitude){
    currentLatitude = latititude;
    currentLongitude = longitude;
    notifyListeners();
  }
}