import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        const DrawerHeader(
          padding: EdgeInsets.all(10),
          child: UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.purple),
            accountName: Text(
              'Programmer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text('pedrovictorveras@id.uff.br'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('Imagens/avatar.jpg'),
            ),
          ),
        ),

        //! Parte da navegação do meu aplicativo

        ListTile(
          leading: const Icon(
            CupertinoIcons.home,
            color: Colors.red,
          ),
          title: const Text(
            'Home Page',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),

        ListTile(
          leading: const Icon(
            CupertinoIcons.person,
            color: Colors.red,
          ),
          title: const Text(
            'Meu Salão de Beleza',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),

        ListTile(
          leading: const Icon(
            CupertinoIcons.cart_fill,
            color: Colors.red,
          ),
          title: const Text(
            'Meus Pedidos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),

        ListTile(
          leading: const Icon(
            CupertinoIcons.settings,
            color: Colors.red,
          ),
          title: const Text(
            'Configurações',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),

        ListTile(
          leading: const Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
          title: const Text(
            'Logout do app',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ]),
    );
  }
}
