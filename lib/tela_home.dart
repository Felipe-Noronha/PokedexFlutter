import 'package:flutter/material.dart';
import 'tela_sobre.dart'; // Importe sua TelaSobre

class TelaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaSobre()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Conteúdo da Tela Inicial'),
      ),
    );
  }
}
