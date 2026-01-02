import 'dart:convert';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class VibeFinderProvider extends ChangeNotifier{
  String? currentmood;
  String? placedistance;
  String? currentLatitude;
  String? currentLongitude;
  final String geoapifykey ="b4dd186c2bcb42289ae48a29bfbb0c96";
  List<String> selectedcategories = [];
  List<dynamic> nearbyplaces = [];
  Map<String, dynamic>? selectedplace;
  Map<String, String> placeDistances = {}; // Store distances for each place

 Map<String, List<String>> moodToCategory = {
    "Happy": ["catering.cafe", "catering.restaurant", "leisure.park"],
    "Sad": ["leisure.park", "tourism.museum", "amenity.library"],
    "Stressed": ["leisure.park", "activity.community_center"],
    "Energetic": ["commercial.outdoor_and_sport"], // Futsal/Gym/Sports
    "Relaxed": ["catering.cafe", "leisure.park", "tourism.lake"],
  };




  Future<void> fetchNearbyPlaces() async{
    if(currentLatitude == null || currentLongitude ==  null || selectedcategories.isEmpty) return;

    String category =selectedcategories.first;
    final url = "https://api.geoapify.com/v2/places?categories=$category&filter=circle:$currentLongitude,$currentLatitude,3000&limit=20&apiKey=$geoapifykey";

    final response = await http.get(Uri.parse(url));
      print("Fetching URL: $url");

    if(response.statusCode ==200){
      final data = jsonDecode(response.body);
      nearbyplaces =data['features'];
      print("Nearby Places Count ${nearbyplaces.length}");
      
      // Calculate distances for all places
      calculateAllDistances();
      
      notifyListeners();
    }
    else{
      print("Error Fetching The data");
       print(response.body);
    }
  }  void changeMood(String? mood){
    currentmood = mood;
    selectedcategories =moodToCategory[mood] ?? [];
    notifyListeners();
  }

  void getCurrentLocation(String? latitude, String? longitude){
    currentLatitude = latitude;
    currentLongitude = longitude;
    notifyListeners();
  }

  void setPlace(Map<String, dynamic> place){
    selectedplace = place;
   
    notifyListeners();
  }

  // Calculate distance for a specific place
  String calculateDistanceForPlace(Map<String, dynamic> place) {
    if (currentLatitude == null || currentLongitude == null) return "N/A";
    
    final prop = place['properties'];
    if (prop['lat'] == null || prop['lon'] == null) return "N/A";
    
    final placeId = prop['name'] ?? 'unknown';
    
    // Check if distance already calculated
    if (placeDistances.containsKey(placeId)) {
      return placeDistances[placeId]!;
    }
    
    try {
      double placeLat = double.parse(prop['lat'].toString());
      double placeLon = double.parse(prop['lon'].toString());
      double currentLat = double.parse(currentLatitude!);
      double currentLon = double.parse(currentLongitude!);
      
      double distanceInMeters = Geolocator.distanceBetween(
        currentLat, currentLon, placeLat, placeLon
      );
      
      String distance = "${(distanceInMeters / 1000).toStringAsFixed(2)} km";
      
      // Store the distance
      placeDistances[placeId] = distance;
      notifyListeners();
      
      return distance;
    } catch (e) {
      print("Error calculating distance: $e");
      return "N/A";
    }
  }

  // Calculate distances for all places at once
  void calculateAllDistances() {
    if (currentLatitude == null || currentLongitude == null) return;
    
    for (var place in nearbyplaces) {
      calculateDistanceForPlace(place);
    }
  }

  // Get stored distance for a place
  String getDistanceForPlace(String placeName) {
    return placeDistances[placeName] ?? "N/A";
  }
}