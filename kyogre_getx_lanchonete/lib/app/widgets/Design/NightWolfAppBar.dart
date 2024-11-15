import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

import '../../../views/Pages/DashBoard/AuthScreen/controllers/usuarios_admin_controllers.dart';

class NightWolfAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? drawerKey;

  const NightWolfAppBar({
    Key? key,
    this.drawerKey,
  }) : super(key: key);

  @override
  _NightWolfAppBarState createState() => _NightWolfAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NightWolfAppBarState extends State<NightWolfAppBar> {
  bool _isPurple = true;
  final ControleUsuariosCliente usuariosController =
      Get.put(ControleUsuariosCliente());

  @override
  Widget build(BuildContext context) {
    // todo controller login que vai fazer isso
    List<UserClients> user = usuariosController.usuarios;

    return AppBar(
      leading: widget.drawerKey != null
          ? IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: _isPurple ? Colors.purple : Colors.black,
              ),
              onPressed: () {
                widget.drawerKey!.currentState?.openDrawer();
              },
            )
          : null,
      elevation: 5,
      backgroundColor: Colors.black,
      title: Row(
        children: [
          Visibility(
            visible: _isPurple,
            child: CustomText(
              text: "${user[0].loja} Gestão de Pedidos APP",
              color: CupertinoColors.inactiveGray,
              size: 22,
              weight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isPurple = !_isPurple;
                });
              },
              child: Container(
                color: _isPurple ? Colors.purple : Colors.black,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: _isPurple ? Colors.white.withOpacity(.7) : Colors.white,
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_rounded,
                  color:
                      _isPurple ? Colors.white.withOpacity(.7) : Colors.white,
                ),
              ),
              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  width: 12,
                  height: 12,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: CupertinoColors.activeGreen,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: CupertinoColors.lightBackgroundGray,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 2,
            height: 22,
            padding: const EdgeInsets.all(2),
            color: CupertinoColors.systemGrey,
          ),
          CustomText(
            text: user[0].user,
            color: _isPurple ? CupertinoColors.inactiveGray : Colors.white,
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor:
                    _isPurple ? CupertinoColors.inactiveGray : Colors.white,
                child: Icon(
                  Icons.person,
                  color: _isPurple ? CupertinoColors.black : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      iconTheme: IconThemeData(color: _isPurple ? Colors.blue : Colors.white),
    );
  }
}
