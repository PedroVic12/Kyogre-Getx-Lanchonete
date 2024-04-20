import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/controller/sacola_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/DetailsPage/details_page.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/ItemDetailsPage/cardapioView/food_item_page.dart';

import '../../../../../app/widgets/Botoes/float_custom_button.dart';
import '../../../../../models/DataBaseController/template/produtos_model.dart';

class AnimatedProductCardWrapper extends StatefulWidget {
  final ProdutoModel produto;
  final Duration duration;
  final VoidCallback onTap;

  AnimatedProductCardWrapper({
    Key? key,
    required this.produto,
    required this.duration,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedProductCardWrapperState createState() =>
      _AnimatedProductCardWrapperState();
}

class _AnimatedProductCardWrapperState extends State<AnimatedProductCardWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: -1.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset:
                Offset(_animation.value * MediaQuery.of(context).size.width, 0),
            child: child,
          );
        },
        child: AnimatedProductCard(
          produto: widget.produto,
          duration: Duration(
              milliseconds: 500), // Ajuste a duração conforme necessário

          onTap: () {
            if (widget.produto.Adicionais != null) {
              Get.to(ProdutoSelectedDetalhesPage(
                produto_selecionado: widget.produto,
              ));
            } else {
              print(
                  "\n\nProduto selecionado não possui adicionais disponíveis.");
              Get.to(ItemDetailsPage(produto_selecionado: widget.produto));
            }
          },
        ));
  }
}

class AnimatedProductCard extends StatelessWidget {
  final ProdutoModel produto;
  final Duration duration;
  final VoidCallback onTap;
  final double startOffsetX;

  AnimatedProductCard({
    Key? key,
    required this.produto,
    required this.duration,
    required this.onTap,
    this.startOffsetX = -0.5, // Começa fora da tela à esquerda
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CardapioController cardapioController =
        Get.find<CardapioController>();
    final CarrinhoPedidoController carrinho =
        Get.put(CarrinhoPedidoController());
    String? pathImg;
    if (produto.imagem != null) {
      List<String>? imagens = produto.imagem?.split('|');
      pathImg = 'lib/repository/assets/FOTOS/${imagens?[0].trim()}';
      cardapioController.pikachu.cout("Img = $pathImg");
    }
    return AnimatedContainer(
      duration: duration,
      curve: Curves.fastOutSlowIn,
      transform: Matrix4.translationValues(
          startOffsetX * MediaQuery.of(context).size.width, 0, 0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(6),
          color: Colors.white24,
          height: 100,
          child: Card(
            elevation: 3,
            child: Row(
              children: [
                //Leading
                Expanded(
                  flex: 30,
                  child: pathImg != null
                      ? Padding(
                          padding: EdgeInsets.all(6),
                          child: Image.asset(
                            pathImg,
                            fit: BoxFit.fill,
                          ))
                      : Center(child: Icon(Icons.fastfood, size: 32)),
                ),

                //Title and Subtitle
                Expanded(
                    flex: 70,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Centraliza os filhos na vertical
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Alinha os filhos ao início na horizontal
                            children: [
                              CustomText(
                                text: '${produto.nome}',
                                size: 22,
                                weight: FontWeight.bold,
                              ),
                              CustomText(
                                text: 'R\$ ${produto.preco_1} Reais',
                                size: 16,
                                color: Colors.green,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),

                        //Trailing
                        Expanded(
                          flex: 10,
                          child: BotaoFloatArredondado(
                              icone: CupertinoIcons.plus_circle_fill,
                              onPress: () {
                                carrinho.adicionarCarrinho(produto);

                                cardapioController.repositoryController.pikachu
                                    .loadDataSuccess('Perfeito',
                                        'Item ${produto.nome} adicionado!');
                              }),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
