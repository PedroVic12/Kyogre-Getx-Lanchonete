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
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Padding(padding: EdgeInsets.all(12),child: InkWell(
            onTap: (){},
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Center(
                child: Text('ListView 1'),
              ),
            ),
          ),),

          Padding(padding: EdgeInsets.all(12),child: InkWell(
            onTap: (){},
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Center(
                child: Text('ListView 1'),
              ),
            ),
          ),),

          Padding(padding: EdgeInsets.all(12),child: InkWell(
            onTap: (){},
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Center(
                child: Text('ListView 1'),
              ),
            ),
          ),),

          Padding(padding: EdgeInsets.all(12),child: InkWell(
            onTap: (){},
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Center(
                child: Text('ListView 1'),
              ),
            ),
          ),),

          Padding(padding: EdgeInsets.all(12),child: InkWell(
            onTap: (){},
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              child: Center(
                child: Text('ListView 1'),
              ),
            ),
          ),),
        ],
      ),
    );
  }
}
