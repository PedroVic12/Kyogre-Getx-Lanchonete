import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../GoogleMaps/google_maps_controller.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  final Completer<GoogleMapController> _mapController = Completer();
  final Location _locationController = Location();
  LatLng? _currentPosition;
  final controller = Get.put(GoogleMapsController());
  final trackingController = TrackingController();

// Dados
  static const LatLng sourceLocation = LatLng(-22.9510978, -43.1807461);
  static const LatLng destination = LatLng(-22.907662, -43.5659086);

  @override
  void initState() {
    super.initState();
    //_getLocationUpdates();
    controller.trackingController
        .simulateMovement(); // Inicia a simulação do movimento
    getLocationUpdates();
  }

  void getLocationUpdates() {
    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      setState(() {
        _currentPosition =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
  }

  Future<void> _getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      setState(() {
        _currentPosition =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {
      const Marker(
        markerId: MarkerId('source'),
        position: GoogleMapsController.sourceLocation,
        icon: BitmapDescriptor.defaultMarker,
      ),
      const Marker(
        markerId: MarkerId('destination'),
        position: GoogleMapsController.destination,
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        markerId: const MarkerId('moving'),
        position: controller.trackingController.currentMarkerPosition.value,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      ),
    };

    if (_currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('currentPosition'),
          position: _currentPosition!,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
            target: GoogleMapsController.sourceLocation, zoom: 13.5),
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
          trackingController.currentMarkerPosition.listen((position) {
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: position, zoom: 14.5)));
          });
        },
      ),
    );
  }
}
