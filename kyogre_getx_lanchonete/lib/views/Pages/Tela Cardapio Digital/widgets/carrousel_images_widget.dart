import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class CarrouselImagensWidget extends StatelessWidget {
   CarrouselImagensWidget({super.key});

   final List<String> imageList = [
     'lib/repository/assets/app_bar.jpeg',
     'lib/repository/assets/card_produto.jpeg',
     'lib/repository/assets/Rio-de-Janeiro-CittaRJ-Catete-menu.jpg',
     // Adicione mais imagens conforme necessário
   ];

   @override
  Widget build(BuildContext context) {
     final screenSize = MediaQuery.of(context).size;

     return CarouselSlider(
      options: CarouselOptions(
        height: screenSize.height / 2,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16/9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: imageList.map((item) => Container(
        child: Center(
            child: Image.asset(item, fit: BoxFit.cover, width: 1000)
        ),
      )).toList(),
    );
  }
}
