import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/widgets/forms_simples.dart';

import '../../../../app/widgets/Custom/CustomText.dart';

class CardapioManager extends GetxController {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();

  bool precoDescontoSelecionado = false;
  bool produtosAdicionais = false;
  RxBool imagemEnviada = false.obs;
  //XFile? imagemSelecionada;
  var imagemSelecionada;

  criarCategoria() {
    //todo criar collection mongodb
    //
    //return array de categorias
  }

  categoriaToTabBar() {}

  Future<void> escolherImagemGaleria() async {
    try {
      final ImagePicker seletorImagem = ImagePicker();
      final XFile? imagem =
          await seletorImagem.pickImage(source: ImageSource.gallery);

      if (imagem != null) {
        imagemSelecionada = imagem;
        imagemEnviada = false.obs;
        update();

        try {
          //await sendImageServer(imagemSelecionada!);
        } catch (e) {
          print('Erro = $e');
        }
      }
    } catch (error) {
      print("\nErro aqui: $error");

      //Get.show_snackbar('Erro', 'Falha ao enviar imagem : $error');
    }
  }

  Widget cardButton(function, IconData icone, String texto) {
    return InkWell(
      onTap: function,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 100,
          width: 160,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(icone), CustomText(text: texto)],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget CardImagem() {
    if (imagemSelecionada != null) {
      return Column(
        children: [
          CustomText(
            text: imagemSelecionada!.path,
            size: 10,
          ),
          SizedBox(
            height: 160,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Image.network(imagemSelecionada!.path),
                onLongPress: () {
                  PopupMenuButton(
                      itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: "Trocar Foto",
                              child: Text("Trocar Foto"),
                            ),
                            const PopupMenuItem(
                              value: "Deletar Foto",
                              child: Text("Deletar Foto"),
                            ),
                          ],
                      onSelected: (String newValue) {});
                },
              ),
            ),
          )
        ],
      );
    } else {
      return const Center(
        child: CustomText(
          text: 'Nenhuma imagem selecionada',
        ),
      );
    }
  }

  void showAlertDialog(BuildContext context, produto) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: Text('VOCE REALMENTE DESEJA EXCLUIR $produto ?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  showCadastroDialog(BuildContext context, produto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Preencha os campos para: $produto'),
          content: SingleChildScrollView(
            // Adicionando SingleChildScrollView para rolagem vertical
            child: Form(
              key: _formKey,
              child: Column(
                // Trocando ListView por Column
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  cardButton(
                      escolherImagemGaleria, Icons.photo, "Escolher Imagem"),
                  // Exibindo a imagem
                  if (imagemSelecionada != null)
                    const Center(child: CircularProgressIndicator())
                  else
                    CardImagem(),

                  FormSimples(
                      obscureText: false,
                      controlador: _controller1,
                      hintText: "NOME"),
                  FormSimples(
                      obscureText: false,
                      controlador: _controller2,
                      hintText: "PRECO"),
                  // PRECO COM DESCONTO
                  Row(children: [
                    const Text("Preco com desconto?"),
                    Switch(
                        value: precoDescontoSelecionado,
                        onChanged: (value) {
                          precoDescontoSelecionado = value;
                          // abrir novo campo
                        }),
                  ]),
                  if (precoDescontoSelecionado) ...[
                    FormSimples(
                        obscureText: false,
                        controlador: _controller3,
                        hintText: "Preço com Desconto"),
                  ] else ...[
                    Container()
                  ],
                  FormSimples(
                      obscureText: false,
                      controlador: _controller3,
                      hintText: "IGREDIENTES"),
                  FormSimples(
                      obscureText: false,
                      controlador: _controller4,
                      hintText: "DESCRIÇÃO DO PRODUTO"),
                  Row(children: [
                    const Text("ADICIONAIS?"),
                    Switch(
                        value: produtosAdicionais,
                        onChanged: (value) {
                          produtosAdicionais = value;
                          // abrir novo campo
                        }),
                  ]),
                  if (produtosAdicionais) ...[
                    FormSimples(
                        obscureText: false,
                        controlador: _controller5,
                        hintText: "ADICIONAIS?"),

                    //form builder para cada campo de adicional com nomeADD e precoADD
                  ] else ...[
                    Container()
                  ],
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print("salvando...");
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Salvar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
