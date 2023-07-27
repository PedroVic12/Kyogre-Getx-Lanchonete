import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

class NightWolfAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? drawerKey;
  final String title;

  const NightWolfAppBar({
    Key? key,
    this.drawerKey,
    this.title = 'Citta RJ Lanchonete',
  }) : super(key: key);

  @override
  _NightWolfAppBarState createState() => _NightWolfAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _NightWolfAppBarState extends State<NightWolfAppBar> {
  bool _isPurple = true;

  @override
  Widget build(BuildContext context) {
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
              text: widget.title,
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
              color: _isPurple ? Colors.black.withOpacity(.7) : Colors.white,
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_rounded,
                  color: _isPurple ? Colors.black.withOpacity(.7) : Colors.white,
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
            color: _isPurple ? CupertinoColors.inactiveGray : Colors.white,
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
                backgroundColor: _isPurple ? CupertinoColors.inactiveGray : Colors.white,
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
