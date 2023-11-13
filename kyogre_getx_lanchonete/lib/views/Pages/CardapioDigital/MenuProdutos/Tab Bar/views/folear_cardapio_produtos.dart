

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

class FolearCardapioDigital extends StatelessWidget {
  const FolearCardapioDigital({super.key});

  @override
  Widget build(BuildContext context) {
    return TurnPageView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          height: 120,
          color: index == 0 ? Colors.blue : Colors.limeAccent,
          child: displayProdutos(index)
        );
      },
      overleafColorBuilder: (index) => index == 0 ? Colors.blue : Colors.green,
      animationTransitionPoint: 0.7,
    );
  }
  
  
  Widget displayProdutos (index){
    return Center(
      child: Text(
        index == 0 ? 'Blue Card' : 'Green Card',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
