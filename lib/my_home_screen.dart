import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(1.18376, 104.01703),
    zoom: 18,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  final List<Marker> myMarker = [];
  final List<Marker> listMarker = const [
    Marker(
      markerId: MarkerId("First"),
      position: LatLng(1.18376, 104.01703),
      infoWindow: InfoWindow(
        title: "My Position",
      ),
    ),
    Marker(
      markerId: MarkerId("Second"),
      position: LatLng(1.1852252827119503, 104.01805192264287),
      infoWindow: InfoWindow(
        title: "Indomaret Tg.Sengkuang",
      ),
    )
  ];

  @override
  void initState() {
    super.initState();
    myMarker.addAll(listMarker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          markers: Set<Marker>.of(myMarker),
          onMapCreated: _onMapCreated,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: LatLng(1.1852252827119503, 104.01805192264287),
                zoom: 18,
              ),
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}
