

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/AuthScreen/simple_auth_page.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/AuthScreen/widgets/input_text_field.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/DashBoard/AuthScreen/widgets/submit_button.dart';

import 'controllers/login_controller.dart';
import 'controllers/registrar_controller.dart';

class TelaAutenticacaoUsuarios extends StatefulWidget {
  const TelaAutenticacaoUsuarios({super.key});

  @override
  State<TelaAutenticacaoUsuarios> createState() => _TelaAutenticacaoUsuariosState();
}

class _TelaAutenticacaoUsuariosState extends State<TelaAutenticacaoUsuarios> {
  RegisterationController registerationController = Get.put(RegisterationController());
  LoginController loginController = Get.put(LoginController());
  var isLogin = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Center(
            child: Obx(
                  () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    ElevatedButton(onPressed: () => Get.to(LoginPage()), child: Text("Login Page")),


                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        'Ruby Saphire App',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
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
                          child: Text('Cadastrar'),
                        ),
                        MaterialButton(
                          color: isLogin.value ? Colors.white : Colors.amber,
                          onPressed: () {
                            isLogin.value = true;
                          },
                          child: Text('Login'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    isLogin.value ? loginWidget() : registerWidget()
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
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.emailController, 'email address'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.passwordController, 'password'),
        SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () {
            registerationController.registerWithEmail();
            // todo mandar email para confirmar novo usuario com token
          } ,
          title: 'Cadastrar novo Usuario',

        )
      ],
    );
  }

  Widget loginWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.emailController, 'email address'),
        SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.passwordController, 'password'),
        SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () => loginController.loginWithEmail(),
          title: 'Login',
        )
      ],
    );
  }
}
