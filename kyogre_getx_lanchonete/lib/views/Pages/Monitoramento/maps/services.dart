import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService extends GetxService {
  final Location _location = Location();
  Rx<LatLng> currentPosition = LatLng(0, 0).obs;

  Future<LocationService> init() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) return this;
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return this;
    }

    _location.onLocationChanged.listen((LocationData currentLocation) {
      currentPosition.value = LatLng(currentLocation.latitude ?? 0, currentLocation.longitude ?? 0);
    });

    return this;
  }
}
