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
    return Padding(padding: EdgeInsets.all(8), child: Column(
      children: [
        SizedBox(height: 20,),
        Text('Horizontal Scroll', style: TextStyle(
            fontSize: 20,
            color: CupertinoColors.white
        ),),
        Row(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.purple
                    ),
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text('texto'),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.purple
                    ),
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text('texto'),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.purple
                    ),
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text('texto'),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.purple
                    ),
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text('texto'),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.purple
                    ),
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text('texto'),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.purple
                    ),
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text('texto'),
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    ),);
  }
}
