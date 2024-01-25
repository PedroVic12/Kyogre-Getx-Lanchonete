import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';

//TODO MESMA TELA COM BOAS PRATICAS DE GETX
//TODO RANDOM TOKEN
//TODO AUTH JVT

List usuarios = [
  {
    "USER":"Pedro Victor",
    "EMAIL":"pedrovictorveras@id.uff.br",
    "SENHA":"admin",
  },
  {
    "USER":"Alex Martins",
    "EMAIL":"",
    "SENHA":"admin",
  },
];

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void login(BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;

    // Verifica se o email e senha correspondem a algum usuário
    var user = usuarios.firstWhere(
          (user) => user['EMAIL'] == email && user['SENHA'] == password,
      orElse: () => null,
    );

    if (user != null) {
      // Usuário encontrado
      Get.to(DashboardPage());
    } else {
      // Usuário não encontrado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário ou senha inválidos')),
      );
    }
  }
}


class RegisterPage extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              controller: userController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => register(context),
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }

  void register(BuildContext context) {
    String user = userController.text;
    String email = emailController.text;
    String password = passwordController.text;

    // Adiciona o novo usuário à lista
    usuarios.add({
      "USER": user,
      "EMAIL": email,
      "SENHA": password,
    });

    Navigator.pop(context);
  }
}


