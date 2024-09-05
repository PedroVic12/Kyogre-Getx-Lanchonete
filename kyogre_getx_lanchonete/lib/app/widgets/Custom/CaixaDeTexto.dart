import 'package:flutter/material.dart';

class CaixaDeTexto extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isReadOnly;
  final Function()? onTap;
  final double? height; // Adicione o parâmetro opcional

  const CaixaDeTexto({
    super.key,
    required this.controller,
    required this.labelText,
    this.isReadOnly = false,
    this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
          style: const TextStyle(),
          controller: controller,
          readOnly: isReadOnly,
          onTap: onTap,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.purple[50],
            border: const OutlineInputBorder(),
            label: Padding(
              padding:
                  const EdgeInsets.only(left: 12.0), // Seu valor de padding
              child: Text(
                labelText,
                style: const TextStyle(
                  color: Colors.purple,
                ),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: (height ?? 10.0), horizontal: 10.0),
          )),
    );
  }
}
