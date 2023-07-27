import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PedidoChegandoAnimation extends StatefulWidget {
  @override
  _PedidoChegandoAnimationState createState() => _PedidoChegandoAnimationState();
}

class _PedidoChegandoAnimationState extends State<PedidoChegandoAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _pedidoChegou = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0, end: 100).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _startAnimation();
  }

  void _startAnimation() {
    _pedidoChegou = false;
    _animationController.forward().then((value) {
      setState(() {
        _pedidoChegou = true;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pedido Chegando',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 200,
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: FAProgressBar(
                  //currentValue: _animation.value.toInt(),
                  displayText: '%',
                ),
              ),
              if (!_pedidoChegou)
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icons/pedido.svg',
                    height: 100,
                    width: 100,
                  ),
                ),
              if (_pedidoChegou)
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Pedido Recebido!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _startAnimation,
          child: Text('Receber Pedido'),
        ),
      ],
    );
  }
}

class PedidoCard extends StatelessWidget {
  final String pedido;

  PedidoCard({required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalhes do Pedido',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(pedido),
          ],
        ),
      ),
    );
  }
}
