import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/CarrinhoPage.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/TelaCardapioDigital.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/DetailsPage/single_item_navBar.dart';

import '../../../../../controllers/DataBaseController/template/produtos_model.dart';
import '../../../Carrinho/controller/sacola_controller.dart';
import '../../controllers/cardapio_form_controller.dart';
import '../../widgets/RadioButton.dart';
import '../../widgets/carrousel_images_widget.dart';
import '../ItemDetailsPage/cardapioView/food_item_page.dart';

class ItemDetailsPage extends StatelessWidget {
  final ProdutoModel produto_selecionado;
  ItemDetailsPage({super.key, required this.produto_selecionado});
  final CarrinhoPedidoController carrinho =
      Get.find<CarrinhoPedidoController>();
  final CardapioFormController form_controller =
      Get.put(CardapioFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ListView(
            children: [
              botoesSuperior(produto_selecionado),
              const SizedBox(
                height: 10,
              ),
              CarrouselImagensWidget(produto_selecionado: produto_selecionado),
              const SizedBox(
                height: 10,
              ),
              detalhesProdutos("Conheça mais sobre o produto "),
              showProdutosComSubCategorias(produto_selecionado),
              CaixaDeTexto(
                controller: form_controller.observacoesDique,
                labelText: "Observações",
                height: 30,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(ProdutoSelectedDetalhesPage(
            produto_selecionado: ProdutoModel(
              nome: "HAMBÚRGUER",
              preco_1: 32.0,
              ingredientes: "Pão, carne, queijo, alface, tomate",
              sub_categoria: "SIM",
              categoria: "ARTESANAL",
              Adicionais: {
                "Bacon": 5.0,
                "Ovo": 3.0,
                "Queijo": 2.0,
                "Molho especial": 1.0
              },
            ),
          ));
        },
      ),
      bottomNavigationBar: SingleItemNavBar(
        produto: produto_selecionado,
      ),
    );
  }

  Widget showProdutosComSubCategorias(ProdutoModel produto) {
    if (produto.sub_categoria != null) {
      print(produto.sub_categoria);
      print('\n\nProduto com varias categorias para o cliente selecionar');
      print("Details page é diferente");

      return Column(
        children: [
          Container(
            child: CustomText(
              text: "Item = ${produto.nome} ${produto.sub_categoria}",
              color: Colors.white,
              size: 30,
            ),
          ),
          RadioButtonGroup(
            niveis: form_controller.niveis,
            nivelSelecionado: form_controller.nivelSelecionado,
          ),
        ],
      );
    } else {
      return const Text('Sem descrição');
    }
  }

  Widget botoesSuperior(produto) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          CustomText(
            text: produto_selecionado.nome,
            color: Colors.white,
            size: 28,
          ),
          InkWell(
            onTap: () => Get.to(CarrinhoPage()),
            child: const Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white,
              size: 32,
            ),
          )
        ],
      ),
    );
  }

  Widget btnQuantidade() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            carrinho.removerProduto(produto_selecionado);
          },
          child: Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const Icon(CupertinoIcons.minus_circle_fill, size: 32),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Obx(() {
          final quantidade = carrinho.SACOLA[produto_selecionado] ?? 0;
          return CustomText(
            text: ' $quantidade',
            size: 28,
            color: Colors.white,
            weight: FontWeight.bold,
          );
        }),
        const SizedBox(
          width: 12,
        ),
        InkWell(
          onTap: () {
            carrinho.adicionarCarrinho(produto_selecionado);
          },
          child: Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              CupertinoIcons.plus_circle_fill,
              size: 32,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget detalhesProdutos(String txt) {
    //final produto = carrinho.SACOLA.keys.toList()[index];
    //final quantidade = carrinho.SACOLA[produto] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          //end crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              text:
                  "$txt ${produto_selecionado.nome}\nQue tal matar a fome com ele? hmmm",
              size: 18,
              color: Colors.white,
              weight: FontWeight.bold,
            ),
            const SizedBox(
              width: 30,
            ),
            //btnQuantidade()
          ],
        ),
        CustomText(
          text: '\nIngredientes: ${produto_selecionado.ingredientes ?? 'N/A'}',
          size: 18,
          color: Colors.white,
          weight: FontWeight.bold,
        )
      ],
    );
  }
}
