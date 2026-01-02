import 'package:flutter/material.dart';
import 'package:vibefinder/about_app.dart';
import 'package:vibefinder/firstpage.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vibefinder/Provider%20class/vibe_finder_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
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
    AboutApp()
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
  elevation: 0,
  backgroundColor: Theme.of(context).colorScheme.primary,
  centerTitle: true,

  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 42,
        height: 42,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Image.asset(
          "assets/images/app_icon.png",
          fit: BoxFit.contain,
        ),
      ),
      const SizedBox(width: 12),
      Text(
        "Vibe Finder",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
      ),
    ],
  ),
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
            label: "Map"),
           
        BottomNavigationBarItem(
          icon:Icon(Icons.app_settings_alt_rounded),
          label: "About App"
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
  bool _isLoading = true;
  double? _currentLat;
  double? _currentLng;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check if provider already has location
      final provider = context.read<VibeFinderProvider>();
      if (provider.currentLatitude != null && provider.currentLongitude != null) {
        setState(() {
          _currentLat = double.parse(provider.currentLatitude!);
          _currentLng = double.parse(provider.currentLongitude!);
          _isLoading = false;
        });
        return;
      }

      // Get current location if not available in provider
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLat = position.latitude;
        _currentLng = position.longitude;
        _isLoading = false;
      });

      // Update provider with current location
      provider.getCurrentLocation(
        position.latitude.toString(), 
        position.longitude.toString()
      );
    } catch (e) {
      print("Error getting location: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _openGoogleMaps(double destinationLat, double destinationLng, String placeName) async {
    if (_currentLat == null || _currentLng == null) return;

    try {
      // Try the most basic Google Maps URL format
      final String url = 'https://maps.google.com/maps?q=$destinationLat,$destinationLng';
      
      print("Trying to open: $url"); // Debug print
      
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        // Try alternative format
        final fallbackUrl = 'https://www.google.com/maps/search/$placeName';
        print("Trying fallback: $fallbackUrl");
        
        if (await canLaunch(fallbackUrl)) {
          await launch(fallbackUrl);
        } else {
          // Last resort - just coordinates
          final lastResortUrl = 'geo:$destinationLat,$destinationLng';
          print("Trying last resort: $lastResortUrl");
          
          if (await canLaunch(lastResortUrl)) {
            await launch(lastResortUrl);
          } else {
            throw Exception("Could not launch any Google Maps URL");
          }
        }
      }
    } catch (e) {
      print("Error opening Google Maps: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Unable to open Google Maps. Please ensure Google Maps is installed."),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = context.read<VibeFinderProvider>();

    // Add current location marker
    if (_currentLat != null && _currentLng != null) {
      _markers = {
        Marker(
          markerId: MarkerId('current_location'),
          position: LatLng(_currentLat!, _currentLng!),
          infoWindow: InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      };
    }

    // If a place is selected, update marker
    if (provider.selectedplace != null) {
      final place = provider.selectedplace!;
      final LatLng position = LatLng(place['lat'], place['lon']);

      // Add destination marker with tap handler
      _markers = {
        ..._markers,
        Marker(
          markerId: MarkerId(place['name']),
          position: position,
          infoWindow: InfoWindow(
            title: place['name'],
            snippet: 'Tap for directions in Google Maps',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () {
            _openGoogleMaps(place['lat'], place['lon'], place['name']);
          },
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

    // Show loading indicator while getting location
    if (_isLoading || _currentLat == null || _currentLng == null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                "Getting your location...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
      ),
      clipBehavior: Clip.antiAlias,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(_currentLat!, _currentLng!),
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
