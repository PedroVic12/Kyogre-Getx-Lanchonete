import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriaItem extends StatelessWidget {
  final String nome;
  final IconData iconPath;
  final bool isSelected;

  const CategoriaItem({
    required this.nome,
    required this.iconPath,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 110,
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.5, 1),
              blurRadius: 50,
              spreadRadius: 3,
              color: Colors.yellow.shade300,
            ),
          ],
          gradient: isSelected
              ? LinearGradient(
            colors: [
              Colors.deepPurple.shade100,
              CupertinoColors.activeBlue.highContrastElevatedColor
            ],
          )
              : null,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconPath, color: isSelected ? Colors.white : Colors.black),
              const SizedBox(height: 8),
              Text(
                nome,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              CategoriaItem(
                nome: 'Meu Nome',
                iconPath: Icons.star,
                isSelected: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

