import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/DashBoardPage.dart';
//TODO MESMA TELA COM BOAS PRATICAS DE GETX
//TODO RANDOM TOKEN
//TODO AUTH JVT

List usuarios = [
  {
    "USER":"Pedro Victor Veras",
    "EMAIL":"pedrovictorveras@id.uff.br",
    "SENHA":"admin",
    "token":"",
    "STATUS": "online",
    "LOJA":"Ruby",
  },

  {
    "USER":"Alex Martins",
    "EMAIL":"",
    "SENHA":"admin",
    "token":"",
    "STATUS": "offline",
    "LOJA":"Ruby"

  },
];


class ControleUsuariosCliente extends GetxController{

  //login
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  get getUsuarios => usuarios;

  void onReady(){
    print("Usuarios = $usuarios");
    getUsuariosDataBase();
  }

  void getUsuariosDataBase(){
    // ler excel

    //converte para objeto json

    // apresentar usuarios
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
      Get.to(DashboardPage());
    } else {
      // Usuário não encontrado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário ou senha inválidos')),
      );
    }
  }

  //cadastro
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailCadastroController = TextEditingController();
  final TextEditingController passwordCadastroController = TextEditingController();

  void register(BuildContext context) {
    String user = userController.text;
    String email = emailController.text;
    String password = passwordController.text;

    var token = generateRandomToken(12);

    // Adiciona o novo usuário à lista
    usuarios.add({
      "USER": user,
      "EMAIL": email,
      "SENHA": password,
      "token":token
    });

    Navigator.pop(context);
  }


  String generateRandomToken(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rnd = Random();
    return List.generate(length, (_) => chars[rnd.nextInt(chars.length)]).join();
  }

  String generateSecurityCode() {
    const chars = '0123456789';
    final rnd = Random();
    return List.generate(5, (_) => chars[rnd.nextInt(10)]).join();
  }

  String message = "";

  Future<void> sendEmail() async {
    final url = Uri.parse("https://rayquaza-citta-server.onrender.com/send-email");

    String msgEmail = """
      Codigo de acesso = ${generateRandomToken(2)}
    """;

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "recipient_email": "Kyogre x Rayquaza",
        "subject": "Novo Usuario cadastrado",
        "body":msgEmail,
      }),
    );

    if (response.statusCode == 200) {

        message = "Email sent successfully!";

        //retorna o token do cliente

    } else {

        message = "Error sending email: ${response.body}";

    }
  }
}