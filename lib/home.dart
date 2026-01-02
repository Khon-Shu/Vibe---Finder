import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:vibefinder/Provider%20class/vibe_finder_provider.dart';
import 'package:vibefinder/homepage.dart';

class vibeFinderHome extends StatefulWidget {
  const vibeFinderHome({super.key});

  @override
  State<vibeFinderHome> createState() => _vibeFinderHomeState();
}

class _vibeFinderHomeState extends State<vibeFinderHome> {
  
  List<Map<String, String>> _moodlist = [
    {"label": "😊 Happy", "key": "Happy", "color": "#FFD700"},
    {"label": "😔 Sad", "key": "Sad", "color": "#4A90E2"},
    {"label": "😟 Stressed", "key": "Stressed", "color": "#E94B3C"},
    {"label": "⚡ Energetic", "key": "Energetic", "color": "#FF6B35"},
    {"label": "😎 Relaxed", "key": "Relaxed", "color": "#50C878"},
  ];

  late String _dropdownvalue;
  double? _currentLatitude;  // Changed to double?
  double? _currentLongitude; // Changed to double?

  Future<void> getlocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location Denied By The User"))
      );
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLatitude = position.latitude;
        _currentLongitude = position.longitude;
      });
    }
  }

  // Helper method to calculate distance
  double calculateDistance(double placeLat, double placeLon) {
    if (_currentLatitude == null || _currentLongitude == null) {
      return 0.0;
    }
    
    return Geolocator.distanceBetween(
      _currentLatitude!,
      _currentLongitude!,
      placeLat,
      placeLon,
    );
  }

  void initState() {
    super.initState();
    _dropdownvalue = _moodlist.first["key"]!;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VibeFinderProvider>();
    final currentMoodData = _moodlist.firstWhere(
      (mood) => mood["key"] == provider.currentmood,
      orElse: () => _moodlist.first,
    );
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.grey.shade50,
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), 
          topRight: Radius.circular(30)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(int.parse(currentMoodData["color"]!.replaceFirst('#', '0xFF'))),
                    Color(int.parse(currentMoodData["color"]!.replaceFirst('#', '0xFF'))).withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(int.parse(currentMoodData["color"]!.replaceFirst('#', '0xFF'))).withOpacity(0.3),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.psychology,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "How are you feeling today?",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          currentMoodData["label"]!.split(' ')[0],
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            currentMoodData["label"]!.split(' ')[1],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 32),
            
            // Mood Selector
            Text(
              "Choose your vibe:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 16),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  prefixIcon: Icon(Icons.mood, color: Colors.grey.shade600),
                ),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(20),
                value: _dropdownvalue,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w500,
                ),
                items: _moodlist.map((mood) {
                  return DropdownMenuItem<String>(
                    value: mood["key"],
                    child: Row(
                      children: [
                        Text(
                          mood["label"]!.split(' ')[0],
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: 8),
                        Text(
                          mood["label"]!.split(' ')[1],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newvalue) {
                  setState(() {
                    _dropdownvalue = newvalue!;
                    context.read<VibeFinderProvider>().changeMood(newvalue);
                  });
                },
              ),
            ),
            
            SizedBox(height: 32),
            
            // Get Recommendations Button
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(int.parse(currentMoodData["color"]!.replaceFirst('#', '0xFF'))),
                    Color(int.parse(currentMoodData["color"]!.replaceFirst('#', '0xFF'))).withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Color(int.parse(currentMoodData["color"]!.replaceFirst('#', '0xFF'))).withOpacity(0.4),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () async {
                  await getlocation();
                  if (_currentLatitude != null && _currentLongitude != null) {
                    context.read<VibeFinderProvider>().getCurrentLocation(
                      _currentLatitude.toString(), 
                      _currentLongitude.toString()
                    );
                    await context.read<VibeFinderProvider>().fetchNearbyPlaces();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.error_outline, color: Colors.white),
                            SizedBox(width: 8),
                            Text("Unable to get location"),
                          ],
                        ),
                        backgroundColor: Colors.red.shade500,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.explore,
                      color: Colors.white,
                      size: 22,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Discover Places",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 32),
            
            // Places List
            if (provider.nearbyplaces.isNotEmpty) ...[
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color(int.parse(currentMoodData["color"]!.replaceFirst('#', '0xFF'))),
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Nearby Places",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
            
            Container(
              constraints: BoxConstraints(maxHeight: 400),
              child: provider.nearbyplaces.isEmpty
                  ? Container(
                      padding: EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "No places found yet",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Select your mood and tap Discover Places",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.nearbyplaces.length,
                      itemBuilder: (context, index) {
                        final place = provider.nearbyplaces[index];
                        final prop = place['properties'];
                        final name = prop['name'] ?? "Unknown";
                        
                        // Parse lat/lon as doubles and calculate distance
                        String distance = "N/A";
                        try {
                          if (prop['lat'] != null && prop['lon'] != null && 
                              _currentLatitude != null && _currentLongitude != null) {
                            
                            double placeLat = double.parse(prop['lat'].toString());
                            double placeLon = double.parse(prop['lon'].toString());
                            
                            double distanceInMeters = calculateDistance(placeLat, placeLon);
                            distance = "${(distanceInMeters / 1000).toStringAsFixed(2)} km";
                          }
                        } catch (e) {
                          print("Error calculating distance: $e");
                          distance = "N/A";
                        }
        
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            leading: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(int.parse(currentMoodData["color"]!.replaceFirst('#', '0xFF'))).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.place,
                                color: Color(int.parse(currentMoodData["color"]!.replaceFirst('#', '0xFF'))),
                                size: 24,
                              ),
                            ),
                            title: Text(
                              name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Icon(
                                  Icons.directions_walk,
                                  size: 16,
                                  color: Colors.grey.shade600,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  distance,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(int.parse(currentMoodData["color"]!.replaceFirst('#', '0xFF'))).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(int.parse(currentMoodData["color"]!.replaceFirst('#', '0xFF'))),
                                size: 16,
                              ),
                            ),
                            onTap: () {
                              provider.setPlace({
                                "name": name,
                                "lat": prop['lat'],
                                "lon": prop['lon'],
                              },
                            );
        
                              final parentState = context.findAncestorStateOfType<HomepageState>();
                              if (parentState != null) {
                                parentState.onTap(1);
                              }
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}