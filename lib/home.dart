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
    {"label": "😊 Happy", "key": "Happy"},
    {"label": "😔 Sad", "key": "Sad"},
    {"label": "😟 Stressed", "key": "Stressed"},
    {"label": "⚡ Energetic", "key": "Energetic"},
    {"label": "😎 Relaxed", "key": "Relaxed"},
  ];

  late String _dropdownvalue;
  late String _currentLatitude;
  late String _currentLongitude;

  Future<void> getlocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location Denied By The User"))
      );
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position position = await Geolocator.getCurrentPosition();
      _currentLatitude = position.latitude.toString();
      _currentLongitude = position.longitude.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    _dropdownvalue = _moodlist.first["key"]!;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VibeFinderProvider>();
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Enter Your Mood Today:",
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 250,
          height: 70,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: InputDecoration(border: OutlineInputBorder()),
            padding: EdgeInsets.all(8.0),
            focusColor: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(30),
            value: _dropdownvalue,
            icon: Icon(Icons.arrow_downward),
            items: _moodlist.map((mood) {
              return DropdownMenuItem<String>(
                value: mood["key"],
                child: Text(
                  mood["label"]!,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              );
            }).toList(),
            onChanged: (String? newvalue) {
              setState(() {
                _dropdownvalue = newvalue!;
                context.read<VibeFinderProvider>().changeMood(newvalue);
              });
            }
          ),
        ),
        const SizedBox(height: 25),
        Text(
          "Your current Mood is: ${context.watch<VibeFinderProvider>().currentmood}",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 25),
        ElevatedButton(
          onPressed: () async {
            await getlocation();
            await context.read<VibeFinderProvider>().fetchNearbyPlaces();
            setState(() {
              context.read<VibeFinderProvider>().getCurrentLocation(_currentLatitude, _currentLongitude);
            });
          },
          child: Text("Get The Place Recommendation")
        ),
        const SizedBox(height: 20),
        Expanded(
          child: provider.nearbyplaces.isEmpty
              ? Center(child: Text("No Places Found"))
              : ListView.builder(
                  itemCount: provider.nearbyplaces.length,
                  itemBuilder: (context, index) {
                    final place = provider.nearbyplaces[index];
                    final prop = place['properties'];
                    final name = prop['name'] ?? "Unknown";
                    final categories = (prop['categories'] as List?)?.join(", ") ?? "N/A";
                    final distance = prop['distance'] != null
                        ? "${(prop['distance'] / 1000).toStringAsFixed(2)} km"
                        : "N/A";

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      child: ListTile(
                        title: Text(name),
                        subtitle: Text("$categories • $distance"),
                        leading: Icon(Icons.location_on, color: Colors.blue),
                        onTap: () {
                          // 1. Set the selected place
                          provider.setPlace({
                            "name": name,
                            "lat": prop['lat'],
                            "lon": prop['lon'],
                          });

                          // 2. Switch to Map tab - CORRECTED
                          final parentState = context.findAncestorStateOfType<HomepageState>();
                          if (parentState != null) {
                            parentState.onTap(1); // Use the onTap method to switch to Map tab
                          }
                        },
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }
}