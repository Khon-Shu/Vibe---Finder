import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vibefinder/Provider%20class/vibe_finder_provider.dart';

class PlacesList extends StatelessWidget {
  final List<Map<String, dynamic>> nearbyplaces;
  final Color defaultColor;
  final Function(Map<String, dynamic>) onPlaceTap;
  final bool isLoading;

  const PlacesList({
    super.key,
    required this.nearbyplaces,
    required this.defaultColor,
    required this.onPlaceTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (nearbyplaces.isNotEmpty) ...[
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: defaultColor,
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
          child: isLoading
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
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: LottieBuilder.asset("assets/lottie/loading.json"),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Finding amazing places for you...",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "This might take a moment",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                )
              : nearbyplaces.isEmpty
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
                  itemCount: nearbyplaces.length,
                  itemBuilder: (context, index) {
                    final place = nearbyplaces[index];
                    final prop = place['properties'];
                    final name = prop['name'] ?? "Unknown";
                    
                    // Get distance from provider
                    final provider = context.read<VibeFinderProvider>();
                    final distance = provider.calculateDistanceForPlace(place);

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
                            color: defaultColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.place,
                            color: defaultColor,
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
                            color: defaultColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: defaultColor,
                            size: 16,
                          ),
                        ),
                        onTap: () => onPlaceTap(place),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
