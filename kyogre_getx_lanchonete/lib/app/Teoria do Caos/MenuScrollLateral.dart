import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuLateralScroll extends StatefulWidget {
  const MenuLateralScroll({Key? key}) : super(key: key);

  @override
  State<MenuLateralScroll> createState() => _MenuLateralScrollState();
}

class _MenuLateralScrollState extends State<MenuLateralScroll> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                child: const Center(
                  child: Text('ListView 1'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                child: const Center(
                  child: Text('ListView 1'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: const Center(
                  child: Text('ListView 1'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: const Center(
                  child: Text('ListView 1'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Colors.pink,
                ),
                child: const Center(
                  child: Text('ListView 1'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
