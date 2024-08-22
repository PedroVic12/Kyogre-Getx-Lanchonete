import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlayerPage(),
    );
  }
}

// Model - Representa os dados dos jogadores
class Player {
  final String name;
  final String position;
  final int rating;

  Player(this.name, this.position, this.rating);
}

// Controller - Controla a lógica do jogo
class PlayerController {
  final List<Player> players = [
    Player('A. Griezmann', 'ST', 0),
    Player('M. Depay', 'LW', 0),
    Player('C. Ronaldo', 'RW', 0),
    Player('N. Fekir', 'CAM', 0),
    Player('S. Busquets', 'CDM', 0),
    Player('E. Pérez', 'CM', 0),
    Player('S. Mustafi', 'CB', 0),
    Player('C. Bravo', 'GK', 0),
    Player('E. Mangala', 'CB', 0),
    Player('J. Navas', 'RB', 1), // Exemplo com um valor diferente
  ];

  List<Player> getPlayerList() {
    return players;
  }
}

// View - Interface do usuário
class PlayerPage extends StatelessWidget {
  final PlayerController controller = PlayerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliação do Jogador'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: controller.getPlayerList().map((player) {
                return PlayerWidget(player: player);
              }).toList(),
            ),
          ),
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.sports_soccer),
                SizedBox(width: 10),
                Text(
                  'Melhor em campo: J. Navas',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Interno para exibir as informações do jogador
class PlayerWidget extends StatelessWidget {
  final Player player;

  PlayerWidget({required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            player.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(player.position),
          SizedBox(height: 5),
          Text('Rating: ${player.rating}'),
        ],
      ),
    );
  }
}
