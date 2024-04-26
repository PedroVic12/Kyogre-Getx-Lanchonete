import 'package:flutter/material.dart';

class FormSimples extends StatelessWidget {
  final Function(String)? onTap;
  final bool obscureText;
  final TextEditingController controlador;
  final String hintText;
  FormSimples(
      {super.key,
      this.onTap,
      required this.obscureText,
      required this.controlador,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: TextFormField(
        onChanged: onTap,
        obscureText: obscureText,
        autocorrect: true,
        controller: controlador,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, preencha este campo';
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
