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
    return Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
            decoration: BoxDecoration(
              color: cor,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Center(
              child: IconButton(
                onPressed: onPressed,
                iconSize: 28,
                icon: Icon(
                  iconData,
                  color: Colors.white,
                ),
              ),
            )));
  }
}
