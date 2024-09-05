import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

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
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        // Se ainda não estiver habilitado, sair da função
        return;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
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
        title: const Text('Localização em Tempo Real'),
      ),
      body: Center(
        child: _currentLocation == null
            ? const CircularProgressIndicator()
            : Text(
                'Localização:\nLatitude: ${_currentLocation!.latitude}\nLongitude: ${_currentLocation!.longitude}',
              ),
      ),
    );
  }
}
