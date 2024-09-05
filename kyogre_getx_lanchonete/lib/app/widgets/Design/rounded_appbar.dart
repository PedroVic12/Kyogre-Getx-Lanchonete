import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarRounded extends StatelessWidget {
  const AppBarRounded({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Appbar'),
    );
  }
}

class RoundedContainer extends StatelessWidget {
  RoundedContainer({super.key});

  double iconSize = 25.0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Positioned(
          top: 35,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.red,
            width: size.width,
            height: size.height / 6,
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                ),
                const Text('Ola mundo'),
                SizedBox(
                  height: size.height / 16,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            size: iconSize,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shop_rounded,
                            size: iconSize,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
