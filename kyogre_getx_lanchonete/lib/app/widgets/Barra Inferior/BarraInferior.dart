import 'package:flutter/material.dart';

class BarraInferiorWidget extends StatelessWidget {
  const BarraInferiorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 70,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.redAccent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'R\$120',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(children: [
                  Icon(
                    Icons.add_shopping_cart_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Adicionar ao carrinho')
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
