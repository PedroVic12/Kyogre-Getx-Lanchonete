import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/AuthScreen/controllers/usuarios_admin_controllers.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/AuthScreen/simple_auth_page.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/AuthScreen/widgets/input_text_field.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/AuthScreen/widgets/submit_button.dart';

import '../../../../app/widgets/Custom/CaixaDeTexto.dart';
import 'controllers/login_controller.dart';
import 'controllers/registrar_controller.dart';

class TelaAutenticacaoUsuarios extends StatefulWidget {
  const TelaAutenticacaoUsuarios({super.key});

  @override
  State<TelaAutenticacaoUsuarios> createState() =>
      _TelaAutenticacaoUsuariosState();
}

class _TelaAutenticacaoUsuariosState extends State<TelaAutenticacaoUsuarios> {
  RegisterationController registerationController =
      Get.put(RegisterationController());
  LoginController loginController = Get.put(LoginController());
  var isLogin = false.obs;
  final ControleUsuariosCliente usuariosClienteController =
      Get.put(ControleUsuariosCliente());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: Center(
            child: Obx(
              () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text(
                        'Bem vindo ao Ruby Delivery App',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: !isLogin.value ? Colors.white : Colors.amber,
                          onPressed: () {
                            isLogin.value = false;
                          },
                          child: const Text('Cadastrar'),
                        ),
                        MaterialButton(
                          color: isLogin.value ? Colors.white : Colors.amber,
                          onPressed: () {
                            isLogin.value = true;
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    isLogin.value ? LoginPageWidget() : CadastroPageWidget()
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerWidget() {
    return Column(
      children: [
        InputTextFieldWidget(registerationController.nameController, 'name'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.emailController, 'email address'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.passwordController, 'password'),
        const SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () {
            registerationController.registerWithEmail();
            // todo mandar email para confirmar novo usuario com token
          },
          title: 'Cadastrar',
        )
      ],
    );
  }

  Widget loginWidget() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.emailController, 'email address'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.passwordController, 'password'),
        const SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () => loginController.loginWithEmail(),
          title: 'Login',
        )
      ],
    );
  }

  Widget LoginPageWidget() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          CaixaDeTexto(
              controller: usuariosClienteController.emailController,
              labelText: 'Email'),
          CaixaDeTexto(
              controller: usuariosClienteController.passwordController,
              labelText: 'Senha'),
          const SizedBox(height: 20),
          SubmitButton(
            onPressed: () => usuariosClienteController.login(context),
            // loginController.loginWithEmail(),

            title: 'Login',
          ),
        ],
      ),
    );
  }

  Widget CadastroPageWidget() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          CaixaDeTexto(
              controller: usuariosClienteController.userController,
              labelText: 'Usuário de Acesso Restrito'),
          CaixaDeTexto(
              controller: usuariosClienteController.emailController,
              labelText: 'Email'),
          CaixaDeTexto(
              controller: usuariosClienteController.passwordController,
              labelText: 'Senha'),
          const SizedBox(height: 20),
          SubmitButton(
            onPressed: () {
              usuariosClienteController.register(context);
              usuariosClienteController.sendEmail();
              Get.snackbar("Email de acesso enviado", "Cadastro realizado");
            },
            title: 'Registrar',
          ),
        ],
      ),
    );
  }
}
