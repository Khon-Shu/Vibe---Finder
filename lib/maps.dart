import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vibefinder/Provider%20class/vibe_finder_provider.dart';

class VibeFinderMap extends StatefulWidget {
  const VibeFinderMap({super.key});

  @override
  State<VibeFinderMap> createState() => _VibeFinderMapState();
}

class _VibeFinderMapState extends State<VibeFinderMap> {
  GoogleMapController? _mapController;
  

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(27.7172, 85.3240), // Kathmandu, Nepal
    zoom: 13,
  );

  @override
  Widget build(BuildContext context) {
    
    final provider = context.watch<VibeFinderProvider>();

if (provider.currentLatitude == null || provider.currentLongitude == null) {
  return const Center(child: CircularProgressIndicator());
}

final latitude = double.parse(provider.currentLatitude!);
final longitude = double.parse(provider.currentLongitude!);
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15
          ),
        onMapCreated: (controller) {
          _mapController = controller;
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
