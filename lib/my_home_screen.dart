import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  GoogleMapController? mapController;

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(1.18376, 104.01703),
    zoom: 14.4746,
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final List<Marker> myMarker = [];
  final List<Marker> listMarker = const [
    Marker(
      markerId: MarkerId("First"),
      position: LatLng(1.18376, 104.01703),
      infoWindow: InfoWindow(
        title: "My Position",
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
      )),
    );
  }
}
