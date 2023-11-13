import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class GlassCardWidget extends StatelessWidget {
  const GlassCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: 300,
      width: 400,
      gradient: LinearGradient(
        colors: [Colors.white.withOpacity(0.40), Colors.white.withOpacity(0.10)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderGradient: LinearGradient(
        colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.lightBlueAccent.withOpacity(0.05), Colors.lightBlueAccent.withOpacity(0.6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.39, 0.40, 1.0],
      ),
      blur: 15.0,
      borderWidth: 1.5,
      elevation: 3.0,
      isFrostedGlass: true,
      shadowColor: Colors.black.withOpacity(0.20),
      alignment: Alignment.center,
      frostedOpacity: 0.12,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: ListTile(
          title: Text('Meu Título'),
          subtitle: Text('Meu Subtítulo'),
          leading: Icon(Icons.star),
        ),
      ),
    );
  }
}