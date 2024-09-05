import 'package:flutter/material.dart';
import 'package:kyogre_getx_lanchonete/app/widgets/InfoCards/InfoCard.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  const OverviewCardsMediumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              title: "Rides in progress",
              value: "7",
              onTap: () {},
              isActive: true,
            ),
            SizedBox(
              width: width / 64,
            ),
            InfoCard(
              title: "Packages delivered",
              value: "17",
              onTap: () {},
              isActive: true,
            ),
          ],
        ),
        SizedBox(
          height: width / 64,
        ),
        Row(
          children: [
            InfoCard(
              title: "Cancelled delivery",
              value: "3",
              onTap: () {},
              isActive: true,
            ),
            SizedBox(
              width: width / 64,
            ),
            InfoCard(
              title: "Scheduled deliveries",
              value: "32",
              onTap: () {},
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }
}
