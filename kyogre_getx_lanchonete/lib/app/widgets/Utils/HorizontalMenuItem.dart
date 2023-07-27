import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/controllers/MenuController/MenuController.dart';

class HorizontalMenuItem extends StatelessWidget {

  final String itemName;
  final Function onTap;

  const HorizontalMenuItem({Key? key, required this.itemName, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return InkWell(
      //onTap: onTap,
      onHover: (value){
        value ?
        MenuControler.instance.onHover(itemName) :
        MenuControler.instance.onHover('not hovering');
      },
      child: Obx(()=> Container(
        color: MenuControler.instance.isPassandoNaTela(itemName) ?
        Colors.lightBlueAccent.withOpacity(.1) : Colors.transparent,
        child: Row(
          children: [
            Visibility(visible: MenuControler.instance.isPassandoNaTela(itemName) || MenuControler.instance.isActive(itemName),
                child: Container(
                    width: 6,
                    height: 40,
                    color: Colors.black
                )),
            SizedBox(width: _width/80),

            Padding(padding: EdgeInsets.all(16),
              child: MenuControler.instance.returnIconFor(itemName),),

            // Verificando se ele ta usando o Menu
            if (!MenuControler.instance.isActive(itemName))
              Flexible(child: CustomText(
                text: itemName,
                color: MenuControler.instance.isPassandoNaTela(itemName) ? Colors.black : Colors.blue,
              ))
            else
              Flexible(child: CustomText(
                text: itemName,
                color: Colors.black,
                size: 20,
                weight: FontWeight.bold,
              ))
          ],
        ),
      )),
    );
  }
}
