import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/rotas/routes.dart';

// TODO 1:15


class MenuControler extends GetxController{
  static MenuControler instance = Get.find();
  var activeItem = PaginaOverViewDisplayName.obs;
  var hoverItem = ''.obs;

  changeActiveItemTo(String itemName){
    activeItem.value = itemName;

  }

  onHover(String itemName){
    if (!isActive(itemName)) hoverItem.value = itemName;

  }

  isActive(String itemName) => activeItem.value ==itemName;

  isPassandoNaTela(String itemName) => hoverItem.value = itemName;

  Widget returnIconFor(String itemName){
    switch (itemName){
      case overviewPageRoute:
        return _customIcon(Icons.trending_up_outlined, itemName);

      case driversPageRoute:
        return _customIcon(Icons.drive_eta, itemName);

      case clientsPageRoute:
        return _customIcon(Icons.people_alt_outlined, itemName);

      case authenticationPageRoute:
        return _customIcon(Icons.exit_to_app_outlined, itemName);
      default:
        return _customIcon(Icons.exit_to_app_outlined, itemName);


    }
  }

  Widget _customIcon(IconData icon, String itemName){
    if (isActive(itemName)) return Icon(icon, size: 22, color: Colors.black);

    return Icon(icon, color: isPassandoNaTela(itemName) ? Colors.deepPurpleAccent: CupertinoColors.inactiveGray);
  }

}