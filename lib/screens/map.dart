import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  // List of marker locations in Davao City (Lanang)
  final List<Marker> _markers = <Marker>[
    Marker(
      point: LatLng(7.0731, 125.6128), // Location 1 in Lanang
      builder: (ctx) =>
          const Icon(Icons.location_on, color: Colors.red, size: 40),
    ),
    Marker(
      point: LatLng(7.0776, 125.6202), // Location 2 in Lanang
      builder: (ctx) =>
          const Icon(Icons.location_on, color: Colors.blue, size: 40),
    ),
    Marker(
      point:
          LatLng(7.067618130167255, 125.61457517187199), // Location 3 in Lanang
      builder: (ctx) =>
          const Icon(Icons.location_on, color: Colors.green, size: 40),
    ),
    Marker(
      point: LatLng(7.0861, 125.6155), // Location 4 in Lanang
      builder: (ctx) =>
          const Icon(Icons.location_on, color: Colors.purple, size: 40),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenStreetMap with Custom Markers - Lanang'),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        // Specify height and width for the map container
        height: MediaQuery.of(context).size.height * .8,
        width: MediaQuery.of(context).size.width * .8,
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(7.0800, 125.6200), // Center of Lanang
            zoom: 15.0, // Increased zoom level for more detail
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(markers: _markers),
          ],
        ),
      ),
    );
  }
}
