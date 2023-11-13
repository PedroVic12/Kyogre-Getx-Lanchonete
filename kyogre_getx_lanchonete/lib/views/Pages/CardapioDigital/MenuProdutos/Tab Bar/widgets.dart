

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomTab extends StatelessWidget {
  final String text;
  final Icon iconPath;
  final bool isSelected;

  const CustomTab({
    required this.text,
    required this.iconPath,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(
          colors: [Colors.deepPurple.shade100, CupertinoColors.activeBlue.highContrastElevatedColor],
        )
            : null,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Tab(
        icon: Icon(Icons.star, color: isSelected ? Colors.white : Colors.black),
        text: text,
        iconMargin: const EdgeInsets.all(2),
      ),
    );
  }
}


class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color , required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _CirclePainter(
        color: color,
        radius: radius
    );
  }

}

class _CirclePainter extends BoxPainter{
  final double radius;
  late Color color;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;

    final Offset circleOffSet = offset + Offset(cfg.size!.width/2, cfg.size!.height- radius);
    canvas.drawCircle(circleOffSet, radius, _paint);
  }

}