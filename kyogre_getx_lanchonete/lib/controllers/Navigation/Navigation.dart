import 'package:delivery_kyogre_getx/pikachu/ResponsiveWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../app/widgets/CustomText.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text('Logo da Citta-RJ aqui'),
          ),
        ],
      )
          : IconButton(
        onPressed: () {
          key.currentState?.openDrawer();
        },
        icon: Icon(Icons.menu_rounded),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          Visibility(
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
                top: 7,
                right: 7,
              ),
            ],
          ),
          Container(
            width: 2,
            height: 22,
            padding: EdgeInsets.all(2),
            color: CupertinoColors.systemGrey,
          ),
          CustomText(
            text: 'Pedro Victor',
            color: CupertinoColors.inactiveGray,
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              child: CircleAvatar(
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
      iconTheme: IconThemeData(color: Colors.blue),
    );
