import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/CardapioDigital/CadastroProdutos/widgets/photo_gallery_mongo.dart';

class CadastroDialog extends StatefulWidget {
  final String produto;

  const CadastroDialog({Key? key, required this.produto}) : super(key: key);

  @override
  _CadastroDialogState createState() => _CadastroDialogState();
}

class _CadastroDialogState extends State<CadastroDialog> {
  bool exibirCarrossel = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();

  bool precoDescontoSelecionado = false;
  bool produtosAdicionais = false;
  bool imagemEnviada = false;
  XFile? imagemSelecionada;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Preencha os campos para: ${widget.produto}'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              cardButton(
                () {
                  setState(() {
                    escolherImagemGaleria();
                    exibirCarrossel = true;
                  });
                },
                Icons.photo,
                "Escolher Imagem",
              ),
              if (exibirCarrossel) carrouselImagens(),
              // Adicione os outros campos do formulário aqui
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

  Widget carrouselImagens() {
    final controller = Get.put(PhotoGalleryController());

    return Container(
      //width: MediaQuery.of(context).size.width * 0.8,
      //height: MediaQuery.of(context).size.height * 0.8,
      width: 200,
      height: 200,

      child: GetBuilder<PhotoGalleryController>(
        builder: (controller) {
          if (controller.photos.isEmpty) {
            return const Center(
              child: Text('No photos available'),
            );
          } else {
            return CarouselSlider.builder(
              itemCount: controller.photos.length,
              itemBuilder: (context, index, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.memory(
                        controller.photos[index].imageBytes,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(controller.photos[index].description),
                  ],
                );
              },
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
              ),
            );
          }
        },
      ),
    );
  }
}
