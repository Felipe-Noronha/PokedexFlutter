import 'package:flutter/material.dart';
import 'tela_home.dart';
import 'tela_captura.dart';
import 'tela_pokemon_capturado.dart';
import 'tela_sobre.dart'; // Importe sua TelaSobre

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App Pokémon',
      theme: ThemeData(
        primarySwatch: Colors.red, // Cor primária (barra de navegação, etc.)
        hintColor: Colors.white, // Cor de destaque
        scaffoldBackgroundColor: Colors.white, // Cor de fundo do Scaffold
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int _currentIndex = 0;

  final List<Widget> _telas = [
    TelaHome(),
    TelaCaptura(),
    TelaPokemonCapturado(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu App Pokémon'),
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
      body: _telas[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Captura',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Capturados',
          ),
        ],
      ),
    );
  }
}
