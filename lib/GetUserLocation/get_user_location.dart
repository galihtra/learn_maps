import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserLocation extends StatefulWidget {
  const GetUserLocation({super.key});

  @override
  State<GetUserLocation> createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
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
  ];

  @override
  void initState() {
    super.initState();
    myMarker.addAll(listMarker);
    packData();
  }

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error ${error}");
    });
    return await Geolocator.getCurrentPosition();
  }

  packData() {
    getUserLocation().then((value) async {
      print("My  Location");
      print('${value.latitude} ${value.longitude}');

      myMarker.add(
        Marker(
          markerId: const MarkerId("Second"),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(
            title: "My Location",
          ),
        ),
      );

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 18,
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );

      setState(() {
        
      });
    });
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
        onPressed: () {
          packData();
        },
        child: const Icon(Icons.radio_button_off),
      ),
    );
  }
}
