import 'package:flutter/material.dart';
import 'package:vibefinder/home.dart';

import 'package:vibefinder/main.dart';
import 'package:vibefinder/userpage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vibefinder/Provider%20class/vibe_finder_provider.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  int _selectedindex = 0;
  List<Widget> optionWidgets =[
    vibeFinderHome(),
    VibeFinderMap(),
    Userpage()
  ];

    void onTap(int index){
      setState(() {
        _selectedindex = index;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
  toolbarHeight: 80,
  title: Text(
    "Vibe Finder",
    style: Theme.of(context).textTheme.titleLarge,
  ),
  leading: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          "assets/images/logoicon.png",
          fit: BoxFit.contain,
        ),
      ),
    ),
  ),
  backgroundColor: Theme.of(context).colorScheme.primary,
),
   body: Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary
    ),
    child: optionWidgets[_selectedindex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedindex,
        onTap: onTap,
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home"
           ),
            BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: "Location"),
           
        BottomNavigationBarItem(
          icon:Icon(Icons.people),
          label: "User"
          ),
         
           
           ])
    );
  }
}
class VibeFinderMap extends StatefulWidget {
  const VibeFinderMap({super.key});

  @override
  State<VibeFinderMap> createState() => _VibeFinderMapState();
}

class _VibeFinderMapState extends State<VibeFinderMap> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.read<VibeFinderProvider>();

    // If a place is selected, update marker and animate camera
    if (provider.selectedplace != null) {
      final place = provider.selectedplace!;
      final LatLng position = LatLng(place['lat'], place['lon']);

      _markers = {
        Marker(
          markerId: MarkerId(place['name']),
          position: position,
          infoWindow: InfoWindow(title: place['name']),
        ),
      };

      // Animate camera if controller is ready
      if (_mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLngZoom(position, 16));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VibeFinderProvider>();

    if (provider.currentLatitude == null || provider.currentLongitude == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final double latitude = double.parse(provider.currentLatitude!);
    final double longitude = double.parse(provider.currentLongitude!);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
      ),
      clipBehavior: Clip.antiAlias,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
      
          // If a place is already selected, animate camera
          if (provider.selectedplace != null) {
            final place = provider.selectedplace!;
            _mapController!.animateCamera(
              CameraUpdate.newLatLngZoom(
                LatLng(place['lat'], place['lon']),
                16,
              ),
            );
          }
        },
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
