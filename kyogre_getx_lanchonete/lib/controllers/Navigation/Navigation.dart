import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/views/responsividade/ResponsiveWidget.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text('Logo da Citta-RJ aqui'),
                ),
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu_rounded),
            ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          const Visibility(
            child: CustomText(
              text: 'Meu Dashboard Small Screen',
              color: CupertinoColors.inactiveGray,
              size: 22,
              weight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: CupertinoColors.black.withOpacity(.7),
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_rounded,
                  color: CupertinoColors.black.withOpacity(.7),
                ),
              ),
              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  width: 12,
                  height: 12,
                  padding: EdgeInsets.all(4),
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
          const CustomText(
            text: 'Pedro Victor Veras',
            color: CupertinoColors.inactiveGray,
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
              child: const CircleAvatar(
                backgroundColor: CupertinoColors.inactiveGray,
                child: Icon(
                  Icons.person,
                  color: CupertinoColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      iconTheme: const IconThemeData(color: Colors.blue),
    );
