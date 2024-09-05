import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthJvtScreen extends StatefulWidget {
  const AuthJvtScreen({super.key});

  @override
  State<AuthJvtScreen> createState() => _AuthJvtScreenState();
}

class _AuthJvtScreenState extends State<AuthJvtScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void _login() async {
    var response = await http.post(
      Uri.parse('http://seu_servidor/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': _emailController.text,
        'senha': _senhaController.text,
      }),
    );

    if (response.statusCode == 200) {
      var token = json.decode(response.body)['access_token'];
      print("Token recebido: $token");
      // Navegação para a próxima tela
    } else {
      print("Erro no login: ${response.body}");
      // Exibe um erro
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
