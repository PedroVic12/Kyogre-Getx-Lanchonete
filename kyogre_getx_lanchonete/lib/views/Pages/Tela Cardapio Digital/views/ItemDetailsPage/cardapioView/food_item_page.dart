import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/themes/dark_mode.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Carrinho/controller/sacola_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/controllers/cardapio_form_controller.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/DetailsPage/single_item_navBar.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/views/cards/blur_card_widget.dart';
import 'package:kyogre_getx_lanchonete/views/Pages/Tela%20Cardapio%20Digital/widgets/carrousel_images_widget.dart';

import '../../../../../../app/widgets/Custom/CustomText.dart';
import '../../../../../../controllers/DataBaseController/template/produtos_model.dart';

class ProdutoSelectedDetalhesPage extends StatefulWidget {
  final ProdutoModel produto_selecionado;
  const ProdutoSelectedDetalhesPage(
      {super.key, required this.produto_selecionado});

  @override
  State<ProdutoSelectedDetalhesPage> createState() =>
      _ProdutoSelectedDetalhesPageState();
}

class _ProdutoSelectedDetalhesPageState
    extends State<ProdutoSelectedDetalhesPage> {
  final Map<String, bool> addSelecionados = {};
  final CarrinhoPedidoController carrinho =
      Get.find<CarrinhoPedidoController>();
  final CardapioFormController form_controller =
      Get.put(CardapioFormController());
  @override
  void initState() {
    super.initState();
    iniciarAdicionais();
  }

  void iniciarAdicionais() {
    widget.produto_selecionado.Adicionais!.forEach((key, value) {
      addSelecionados[key] = false;
    });
  }

  List<ProdutoModel> getProdutoAtualizado() {
    List<ProdutoModel> produtosAtualizados = [];

    // Adiciona o produto principal sem alterações
    produtosAtualizados.add(widget.produto_selecionado);

    // Adiciona os produtos com os adicionais selecionados
    widget.produto_selecionado.Adicionais!.forEach((key, value) {
      if (addSelecionados[key] == true) {
        var novoProduto = widget.produto_selecionado
            .copyWith(preco_1: widget.produto_selecionado.preco_1 + value);
        produtosAtualizados.add(novoProduto);
      }
    });

    return produtosAtualizados;
  }

  @override
  Widget build(BuildContext context) {
    var newPrice = getProdutoAtualizado();

    return Scaffold(
      //backgroundColor: lightMode.colorScheme.onBackground,
      backgroundColor: Colors.indigoAccent,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              botoesSuperior(widget.produto_selecionado),
              const SizedBox(height: 16),

              // food image

              CarrouselImagensWidget(
                  produto_selecionado: widget.produto_selecionado),

              detalhesInfoProduto(),

              // add itens importante com repository
              showProdutosComSubCategorias(widget.produto_selecionado),

              showAdicionaisProduto(widget.produto_selecionado),

              CustomText(
                  text: "Total: R\$ ${newPrice.last}", color: Colors.white),
              CaixaDeTexto(
                controller: form_controller.observacoesDique,
                labelText: "Observações",
                height: 30,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SingleItemNavBar(
        produto: widget.produto_selecionado,
      ),
    );
  }

  Widget detalhesInfoProduto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        // food name
        CustomText(
          text: widget.produto_selecionado.nome,
          //color: Colors.white,
          weight: FontWeight.bold,
          size: 26,
        ),
        CustomText(
          text: "R\$ ${widget.produto_selecionado.preco_1.toString()} reais",
          color: Colors.grey,
          weight: FontWeight.bold,
        ),
        const SizedBox(height: 16),

        // food description
        CustomText(
          text: widget.produto_selecionado.ingredientes!,
          weight: FontWeight.bold,
          size: 16,
        ),
        CustomText(
          text: widget.produto_selecionado.description!,
          weight: FontWeight.bold,
          size: 16,
        ),
        const Divider(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget showProdutosComSubCategorias(ProdutoModel produto) {
    if (produto.sub_categoria != null) {
      return Container(
        child: CustomText(
          text: "${widget.produto_selecionado.sub_categoria}",
          color: Colors.white,
          size: 30,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showAdicionaisProduto(ProdutoModel produto) {
    if (produto.Adicionais != null && produto.Adicionais!.isNotEmpty) {
      return Column(
        children: [
          CustomText(
            text: "Turbine seu ${produto.nome}",
            size: 24,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: produto.Adicionais!.length,
              itemBuilder: (context, index) {
                final adicionais = produto.Adicionais!;
                final chaves = adicionais.keys.toList();
                final adicional = chaves[index];
                final precoAdicional = adicionais[adicional];

                return Card(
                  child: CheckboxListTile(
                    title: CustomText(text: adicional),
                    subtitle: CustomText(
                      text: "Preço: R\$ $precoAdicional",
                      color: Colors.grey,
                      weight: FontWeight.bold,
                    ),
                    value: addSelecionados[adicional] ?? false,
                    onChanged: (value) {
                      setState(() {
                        addSelecionados[adicional] = value!;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Divider()
        ],
      );
    } else {
      return Text('Sem Adicionais Disponíveis');
    }
  }

  Widget botoesSuperior(produto) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withBlue(10),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          CustomText(
            text: produto.nome,
            color: Colors.white,
            size: 28,
          ),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.shopping_cart_rounded,
              color: Colors.white,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}
