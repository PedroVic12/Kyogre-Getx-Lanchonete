import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final dynamic id;

   CustomAppBar({super.key, this.id});

  List nomesLojas = ['Copacabana', 'Botafogo', 'Ipanema', 'Castelo'];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          CustomText(text: 'Citta RJ ${nomesLojas[1]} | Pedido: ${id}',color: Colors.white,size: 20)
        ],
      ),
      backgroundColor: CupertinoColors.black,
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 7.0,
      toolbarHeight: 72,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(48))),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // Você pode ajustar a altura conforme necessário
}
