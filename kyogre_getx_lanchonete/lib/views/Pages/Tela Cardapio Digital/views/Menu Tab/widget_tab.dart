

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';



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
      child: Tab(
        icon: CircleAvatar(child: Icon(iconPath.icon, color: isSelected ? CupertinoColors.systemBlue : Colors.black)),
        text: text,
        iconMargin: const EdgeInsets.all(6),
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