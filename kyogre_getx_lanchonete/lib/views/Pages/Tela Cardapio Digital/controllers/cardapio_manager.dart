import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

import '../../../../app/widgets/Custom/CustomText.dart';
import '../CardapioDigital/CadastroProdutos/widgets/photo_gallery_mongo.dart';

class CardapioManager extends GetxController {
  bool precoDescontoSelecionado = false;
  bool produtosAdicionais = false;
  RxBool imagemEnviada = false.obs;
  XFile? imagemSelecionada;
  final Dio dio = Dio();

  String urlMongo = "http://0.0.0.0:7070";
  //var imagemSelecionada;

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
        imagemEnviada.value = false; // Atualize o valor do RxBool
        update(); // Atualize o estado
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
            return Text("Photos: ${controller.photos.length}");
            // return CarouselSlider.builder(
            //   itemCount: controller.photos.length,
            //   itemBuilder: (context, index, _) {
            //     return Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
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
          }
        },
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
}
