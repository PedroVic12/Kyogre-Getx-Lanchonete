import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';

class InfoCardSmall extends StatelessWidget {

  final String title;
  final String value;
  final bool isActive;
  final Function onTap;

  const InfoCardSmall({Key? key, required this.title, required this.value, required this.isActive, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isActive ? Colors.blueAccent : Colors.grey, width: .10 ),


        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: title,size: 24,weight: FontWeight.bold,)
          ],
        ),

      ),
    ));
  }
}
