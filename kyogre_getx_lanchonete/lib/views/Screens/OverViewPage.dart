import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/Custom/CustomText.dart';
import 'package:kyogre_getx_lanchonete/controllers/MenuController/MenuController.dart';
import 'package:kyogre_getx_lanchonete/views/Screens/OverViewCards/OverViewCardLarge.dart';
import 'package:kyogre_getx_lanchonete/views/Screens/OverViewCards/OverViewCardMedium.dart';
import 'package:kyogre_getx_lanchonete/views/Screens/OverViewCards/OverViewCardSmall.dart';
import 'package:kyogre_getx_lanchonete/views/responsividade/ResponsiveWidget.dart';


// TODO -> 1:51


class OverViewPage extends StatelessWidget {
  const OverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: CustomText(
                text: MenuControler.instance.activeItem.value,
                size: 20,
                weight: FontWeight.bold,
              ),

            )
          ],
        )),

        Expanded(child: ListView(
          children: [

            if(ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context))
              if (ResponsiveWidget.isCustomSize(context))
                OverviewCardsMediumScreen()
              else
                OverViewCardsLarge()
            else
              OverViewCardsSmallScreen()
          ],
        ))
      ],
    );
  }
}
