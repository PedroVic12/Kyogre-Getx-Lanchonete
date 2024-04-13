import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

class FormularioField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controlador;

  const FormularioField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controlador});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        autocorrect: true,
        controller: controlador,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary),
            ),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
      ),
    );
  }
}

class LoginController {
  TextEditingController senhaController = TextEditingController();
  TextEditingController registroController = TextEditingController();

  TextEditingController emailController = TextEditingController();
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      backgroundColor: Colors.white10,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.message,
            size: 80, color: Theme.of(context).colorScheme.primary),
        const SizedBox(
          height: 50,
        ),
        CustomText(text: "BEM VINDO AO RUBY EXPRESS"),
        const SizedBox(
          height: 25,
        ),
        FormularioField(
            hintText: "EMAIL",
            obscureText: false,
            controlador: controller.emailController),
        const SizedBox(
          height: 20,
        ),
        FormularioField(
            hintText: "SENHA",
            obscureText: true,
            controlador: controller.senhaController),
        MyButton(text: "Login", onTap: () {}),
        MyButton(
          text: "Cadastrar seus dados",
          onTap: () {},
        )
      ]),
    );
  }
}

class MyButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  const MyButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Center(
          child:
              ElevatedButton(onPressed: onTap, child: CustomText(text: text))),
    );
  }
}
