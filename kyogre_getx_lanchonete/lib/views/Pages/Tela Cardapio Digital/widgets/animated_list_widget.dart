import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/models/DataBaseController/template/produtos_model.dart';

import '../views/cards/AnimatedCardWidget.dart';

class AnimatedListItem extends StatefulWidget {
  final ProdutoModel produto;
  final int index;

  AnimatedListItem({Key? key, required this.produto, required this.index})
      : super(key: key);

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Inicia a animação
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: _animation.drive(Tween(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        )),
        child: AnimatedProductCard(
        produto: widget.produto,
        duration: Duration(milliseconds: 500),// Ajuste a duração conforme necessário

        onTap: () {
          //Get.to(ItemDetailsPage(produto_selecionado: produto));
        },
      )
      // Seu widget de card aqui
      ),
    );
  }
}
