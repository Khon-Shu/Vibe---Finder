import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:vibefinder/Provider%20class/vibe_finder_provider.dart';
import 'package:vibefinder/homepage.dart';
import 'package:vibefinder/widgets/mood_header.dart';
import 'package:vibefinder/widgets/mood_selector.dart';
import 'package:vibefinder/widgets/discover_button.dart';
import 'package:vibefinder/widgets/places_list.dart';

class vibeFinderHome extends StatefulWidget {
  const vibeFinderHome({super.key});

  @override
  State<vibeFinderHome> createState() => _vibeFinderHomeState();
}

class _vibeFinderHomeState extends State<vibeFinderHome> {
  List<Map<String, String>> _moodlist = [
    {"label": "🤔 None", "key": "None"},
    {"label": "😊 Happy", "key": "Happy"},
    {"label": "😔 Sad", "key": "Sad"},
    {"label": "😟 Stressed", "key": "Stressed"},
    {"label": "⚡ Energetic", "key": "Energetic"},
    {"label": "😎 Relaxed", "key": "Relaxed"},
  ];

  late String _dropdownvalue;
  double? _currentLatitude;
  double? _currentLongitude;
  bool _isLoading = false;

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

  @override
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
    
    final defaultColor = Color(int.parse("#50C878".replaceFirst('#', '0xFF')));
    
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
            MoodHeader(
              currentMood: currentMoodData["label"]!,
              defaultColor: defaultColor,
            ),
            
            SizedBox(height: 32),
            
            MoodSelector(
              moodlist: _moodlist,
              selectedMood: _dropdownvalue,
              onMoodChanged: (String newvalue) {
                setState(() {
                  _dropdownvalue = newvalue;
                  context.read<VibeFinderProvider>().changeMood(newvalue);
                });
              },
            ),
            
            SizedBox(height: 32),
            
            DiscoverButton(
              defaultColor: defaultColor,
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                
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
                
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            
            SizedBox(height: 32),
            
            PlacesList(
              nearbyplaces: provider.nearbyplaces.cast<Map<String, dynamic>>(),
              defaultColor: defaultColor,
              isLoading: _isLoading,
              onPlaceTap: (place) {
                final prop = place['properties'];
                
                provider.setPlace({
                  "name": prop['name'],
                  "lat": prop['lat'],
                  "lon": prop['lon'],
                });

                final parentState = context.findAncestorStateOfType<HomepageState>();
                if (parentState != null) {
                  parentState.onTap(1);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
