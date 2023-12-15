import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/template/produtos_model.dart';

class CarrouselImagensWidget extends StatelessWidget {
  final ProdutoModel produto_selecionado;
  CarrouselImagensWidget({super.key, required this.produto_selecionado});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    List<String>? imagens = produto_selecionado.imagem?.split('|').map((img) => 'lib/repository/assets/FOTOS/${img.trim()}').toList();

    if (imagens == null || imagens.isEmpty) {
      // Se não houver imagens, exiba um widget padrão
      return Center(child: Text('Nenhuma imagem disponível'));
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: screenSize.height / 2,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 1500),
        viewportFraction: 0.8,
      ),
      items: imagens.map((item) => Container(
        child: Center(
            child: Image.asset(item, fit: BoxFit.cover, width: 500)),
      )).toList(),
    );
  }
}
