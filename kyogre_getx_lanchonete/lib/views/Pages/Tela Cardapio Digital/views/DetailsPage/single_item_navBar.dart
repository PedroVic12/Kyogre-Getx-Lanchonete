import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

class SingleItemNavBar extends StatelessWidget {
  const SingleItemNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Column(
              children: [
                CustomText(text: 'Preço total:', size: 20, color: Colors.black,),
                SizedBox(height: 10),
                CustomText(text: 'R\$ 100 Reais', size: 20, color: Colors.black,)

              ],
            ),

          BotaoCarrinho2(),
        ],
      ),
    );
  }
}


class BotaoCarrinho2 extends StatelessWidget {
  const BotaoCarrinho2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
        ),
        child: InkWell(
          child: Row(
            children: [
              CustomText(text: 'Compre AGORA!', size: 20, color: Colors.white,),
              SizedBox(height: 10),
              Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
                size: 32,
              ),
            ],
          ),

          onLongPress: (){},
        )
    );
  }
}
