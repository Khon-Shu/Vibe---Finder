import 'package:flutter/material.dart';

class VibeFinderProvider extends ChangeNotifier {


    String? currentmood;    

    void addMood({ required String mood} ) async{
      currentmood = mood;
      notifyListeners();
    }
}