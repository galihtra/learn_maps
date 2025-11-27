import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyPolygone extends StatefulWidget {
  const MyPolygone({super.key});

  @override
  State<MyPolygone> createState() => _MyPolygoneState();
}

class _MyPolygoneState extends State<MyPolygone> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(1.1548065209569573, 103.99747163388783),
    zoom: 18,
  );

  final Set<Polygon> _myPolygone = HashSet<Polygon>();

  List<LatLng> points = const [
    LatLng(1.1552694549538818, 103.99798628879371),
    LatLng(1.1550742619252345, 103.99803318235952),
    LatLng(1.1545987551455668, 103.99728812449585),
    LatLng(1.1547951695857843, 103.99718275153057),
  ];

  List<LatLng> points2 = const [
    LatLng(1.1545900290152453, 103.9968444469526),
    LatLng(1.1546013564719804, 103.99670282498873),
    LatLng(1.1562956504589887, 103.99687132908883),
    LatLng(1.156257696145522, 103.99700148466718),
  ];

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    _myPolygone.add(
      Polygon(
        polygonId: const PolygonId('First'),
        points: points2,
        fillColor: Colors.cyan.withOpacity(0.3),
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.redAccent,
      ),
    );

    // Menambahkan poligon kedua dengan warna berbeda
    _myPolygone.add(
      Polygon(
        polygonId: const PolygonId('Second'),
        points: points,
        fillColor: Colors.green.withOpacity(0.3), // Ubah warna sesuai kebutuhan
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.blueAccent, // Ubah warna stroke sesuai kebutuhan
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Polygone"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          polygons: _myPolygone,
          onMapCreated: _onMapCreated,
        ),
      ),
    );
  }
}
