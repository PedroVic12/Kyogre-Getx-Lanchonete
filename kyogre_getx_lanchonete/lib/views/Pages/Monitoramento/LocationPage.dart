import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late Location _location;
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _location = Location();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    // Verifica e pede permissões
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        // Se ainda não estiver habilitado, sair da função
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // Se a permissão ainda estiver negada, sair da função
        return;
      }
    }

    // Pega a localização atual
    _currentLocation = await _location.getLocation();

    // Configura o listener para atualizações contínuas
    _location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentLocation = currentLocation;
      });

      // Aqui você pode enviar a localização (_currentLocation) para o servidor
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localização em Tempo Real'),
      ),
      body: Center(
        child: _currentLocation == null
            ? CircularProgressIndicator()
            : Text(
          'Localização:\nLatitude: ${_currentLocation!.latitude}\nLongitude: ${_currentLocation!.longitude}',
        ),
      ),
    );
  }
}
