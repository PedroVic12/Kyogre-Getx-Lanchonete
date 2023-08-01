import 'package:flutter/material.dart';

class BotoesIcone extends StatelessWidget {
  final VoidCallback onPressed;
  final Color cor;
  final IconData iconData;

  const BotoesIcone({
    Key? key,
    required this.onPressed,
    required this.cor,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(5),child: Container(
        decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(
          child: IconButton(
            onPressed: onPressed,
            iconSize: 25,
            icon: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        )
    ));
  }
}
