import 'package:flutter/material.dart';

class CardPedido extends StatelessWidget {
  final String nome;
  final String telefone;
  final List<Map<String, dynamic>> itensPedido; // Alterado para List<Map<String, dynamic>>
  final double totalPrecoPedido;
  final String formaPagamento;
  final String enderecoEntrega;
  final VoidCallback onTap;
  final VoidCallback onEnviarEntrega;

  const CardPedido({
    required this.nome,
    required this.telefone,
    required this.itensPedido,
    required this.totalPrecoPedido,
    required this.formaPagamento,
    required this.enderecoEntrega,
    required this.onTap,
    required this.onEnviarEntrega,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resumo do Pedido de: $nome',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('Telefone: $telefone'),
              SizedBox(height: 8),
              Text('Itens do Pedido: ${getItensPedidoText()}'),
              SizedBox(height: 8),
              Text('Total a pagar: R\$ ${totalPrecoPedido.toStringAsFixed(2)}'),
              SizedBox(height: 8),
              Text('Forma de Pagamento: $formaPagamento'),
              SizedBox(height: 8),
              Text('Endereço de Entrega: $enderecoEntrega'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: onEnviarEntrega,
                child: Text('Enviar para Entrega'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  String getItensPedidoText() {
    String itensText = '';
    for (var item in itensPedido) {
      String nomeItem = item['nome'];
      int quantidade = item['quantidade'];
      String itemText = '$nomeItem (Quantidade: $quantidade)';
      itensText += itemText + ', ';
    }
    itensText = itensText.trim().replaceAll(RegExp(r',\s*$'), '');
    return itensText;
  }
}
