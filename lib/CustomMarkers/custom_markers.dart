import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_app/resources/assets_app.dart';

class CustomMarkers extends StatefulWidget {
  const CustomMarkers({super.key});

  @override
  State<CustomMarkers> createState() => _CustomMarkersState();
}

class _CustomMarkersState extends State<CustomMarkers> {

  List<String> images = [
    AppImages.indianWoman,
    AppImages.chineseWoman,
    AppImages.man,
    AppImages.arabMan,
  ];

  final List<LatLng> latLngForImages = <LatLng> [
    const LatLng(1.1838684132848298, 104.01565935835673),
    const LatLng(1.183413172132675, 104.01779356303109),
    const LatLng(1.1825584334410717, 104.01759532050693),
    const LatLng(1.184388895908477, 104.01726398941294),
  ];

  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(1.18376, 104.01703),
    zoom: 18,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  final List<Marker> myMarker = [];

  @override
  void initState() {
    super.initState();
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
