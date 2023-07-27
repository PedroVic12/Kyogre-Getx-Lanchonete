import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartaoGridView extends StatelessWidget {
  const CartaoGridView({Key? key}) : super(key: key);


  Widget get_widget(Color _color, IconData _icon ){
    return Container(
      color: _color,
      child: Icon(_icon, size: 90,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          shrinkWrap: true,
          //scrollDirection: Axis.vertical,
          children: [


            get_widget(Colors.red, Icons.cabin),

            get_widget(Colors.green, Icons.settings),

            get_widget(Colors.purple, Icons.wifi),

            get_widget(CupertinoColors.activeBlue, Icons.access_alarm_rounded),


            CartaoGridBuilder()
          ],),

      ),
    );
  }
}


class CartaoGridBuilder extends StatelessWidget {
  CartaoGridBuilder({Key? key}) : super(key: key);

  Widget get_widget(Color _color, IconData _icon ) {
    return Container(
      color: _color,
      child: Icon(_icon, size: 90,),
    );
  }

  final List<IconData> icones = [
    Icons.man,
    Icons.car_crash,
    Icons.settings,
    Icons.bike_scooter_outlined,
    Icons.bluetooth,
    Icons.wifi
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GridView Builder'),),
      body: Center(

        // TODO -> Envolver com um container com padding e altura especidificada

        child: GridView.builder(
          itemCount: icones.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5

          ), itemBuilder: (context, index) =>
            get_widget(
                Colors.black, icones[index]
            ),
        ),
      ),
    );
  }
}
