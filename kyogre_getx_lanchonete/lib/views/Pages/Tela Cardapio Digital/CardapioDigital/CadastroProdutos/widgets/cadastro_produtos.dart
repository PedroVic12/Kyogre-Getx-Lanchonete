import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/Views/galery_firebase.dart';
import 'package:kyogre_getx_lanchonete/controllers/DataBaseController/sqlite_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioDigital/CadastroProdutos/widgets/photo_gallery_mongo.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/widgets/forms_simples.dart';

class CadastroDialogWidget extends StatefulWidget {
  final String produto;
  const CadastroDialogWidget({super.key, required this.produto});

  @override
  State<CadastroDialogWidget> createState() => _CadastroDialogWidgetState();
}

class _CadastroDialogWidgetState extends State<CadastroDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final photoGallery = PhotoGalleryController();
  bool precoDescontoSelecionado = false;
  bool produtosAdicionais = false;
  bool imagemEnviada = false;
  XFile? imagemSelecionada;
  bool exibirCarrossel = true;

  // Instantiate FirebaseServices
  //final FirebaseServices firestore = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: AlertDialog.adaptive(
        title: Text('Preencha os campos para: ${widget.produto}'),
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TasksPage(),
                //if (exibirCarrossel) carrouselImagens(),
                FormSimples(
                  obscureText: false,
                  controlador: _controller1,
                  hintText: "NOME",
                ),
                Row(
                  children: [
                    const Text("Preco com desconto?"),
                    Switch(
                      value: precoDescontoSelecionado,
                      onChanged: (value) {
                        setState(() {
                          precoDescontoSelecionado = value;
                        });
                      },
                    ),
                  ],
                ),
                FormSimples(
                  obscureText: false,
                  controlador: _controller2,
                  hintText: "PRECO",
                ),
                if (precoDescontoSelecionado)
                  FormSimples(
                    obscureText: false,
                    controlador: _controller3,
                    hintText: "Preço com Desconto",
                  )
                else
                  Container(),
                FormSimples(
                  obscureText: false,
                  controlador: _controller3,
                  hintText: "IGREDIENTES",
                ),
                FormSimples(
                  obscureText: false,
                  controlador: _controller4,
                  hintText: "DESCRIÇÃO DO PRODUTO",
                ),
                Row(
                  children: [
                    const Text("ADICIONAIS?"),
                    Switch(
                      value: produtosAdicionais,
                      onChanged: (value) {
                        setState(() {
                          produtosAdicionais = value;
                        });
                      },
                    ),
                  ],
                ),
                if (produtosAdicionais)
                  FormSimples(
                    obscureText: false,
                    controlador: _controller5,
                    hintText: "ADICIONAIS?",
                  )
                else
                  Container(),
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
          TextButton(
              onPressed: () {
                //firestore.create();
                Get.to(CadastroProdutosPage());
              },
              child: Text("Create")),
          TextButton(
              onPressed: () {
                //Get.to(ProdutoScreen());
                //Get.to(PageAdminCardapio());
              },
              child: Text("Read"))
        ],
      ),
    );
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

  Future<void> escolherImagemGaleria() async {
    try {
      final ImagePicker seletorImagem = ImagePicker();
      final XFile? imagem =
          await seletorImagem.pickImage(source: ImageSource.gallery);

      if (imagem != null) {
        imagemSelecionada = imagem;
        imagemEnviada = false; // Atualize o valor do RxBool
      }
    } catch (error) {
      print("\nErro aqui: $error");
      //Get.show_snackbar('Erro', 'Falha ao enviar imagem : $error');
    }
  }

  Widget carrouselImagens() {
    return SizedBox(
      width: 200,
      height: 200, // Defina uma altura fixa para o carrossel
      child: GetBuilder<PhotoGalleryController>(
        builder: (controller) {
          if (controller.photos.isEmpty) {
            return SizedBox(
              height: 50,
              child: const Center(child: Text('Sem fotos selecionadas')),
            );
          } else {
            return Text(controller.photos[0].description);
          }
          // return CarouselSlider.builder(
          //   itemCount: controller.photos.length,
          //   itemBuilder: (context, index, _) {
          //     return Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         const SizedBox(height: 20),
          //         Expanded(
          //           child: Image.memory(
          //             controller.photos[index].imageBytes,
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //         const SizedBox(height: 10),
          //         Text(controller.photos[index].description),
          //       ],
          //     );
          //   },
          //   options: CarouselOptions(
          //     aspectRatio: 16 / 9,
          //     viewportFraction: 0.8,
          //     enlargeCenterPage: true,
          //   ),
          // );
        },
      ),
    );
  }
}
