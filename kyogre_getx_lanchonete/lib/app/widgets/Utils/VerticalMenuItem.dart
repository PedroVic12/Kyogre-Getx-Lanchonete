import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/controllers/MenuController/MenuController.dart';


class VerticalMenuItem extends StatelessWidget {
  final String itemName;
  final Function onTap;

  const VerticalMenuItem({super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      //onTap: onTap,
        onHover: (value) {
          value
              ? MenuControler.instance.onHover(itemName)
              : MenuControler.instance.onHover("not hovering");
        },
        child: Obx(() => Container(
          color: MenuControler.instance.isPassandoNaTela(itemName)
              ? Colors.blueGrey.withOpacity(.1)
              : Colors.transparent,
          child: Row(
            children: [
              Visibility(
                visible: MenuControler.instance.isPassandoNaTela(itemName) ||
                    MenuControler.instance.isActive(itemName),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  width: 3,
                  height: 72,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: MenuControler.instance.returnIconFor(itemName),
                      ),
                      if (!MenuControler.instance.isActive(itemName))
                        Flexible(
                            child: CustomText(
                              text: itemName,
                              color: MenuControler.instance.isPassandoNaTela(itemName)
                                  ? Colors.white
                                  : Colors.greenAccent,
                            ))
                      else
                        Flexible(
                            child: CustomText(
                              text: itemName,
                              color: Colors.white,
                              size: 18,
                              weight: FontWeight.bold,
                            ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}