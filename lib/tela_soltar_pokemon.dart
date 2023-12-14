import 'package:flutter/material.dart';
import 'pokemon_model.dart';
import 'tela_detalhes_pokemon.dart';

class TelaSoltarPokemon extends StatefulWidget {
  final Pokemon pokemon;

  TelaSoltarPokemon({required this.pokemon});

  @override
  _TelaSoltarPokemonState createState() => _TelaSoltarPokemonState();
}

class _TelaSoltarPokemonState extends State<TelaSoltarPokemon> {
  late Pokemon _pokemon;

  @override
  void initState() {
    super.initState();
    _pokemon = widget.pokemon;
  }

  void confirmarSoltura() {
    // Lógica para confirmar a soltura do Pokémon
    // Você pode acessar os detalhes do Pokémon, incluindo o ID, usando _pokemon.id
    // Adicione a lógica desejada aqui, como excluir o Pokémon do banco de dados
    // e, em seguida, navegar para a tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soltar Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalhes do Pokémon:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('ID: ${_pokemon.id}'),
            Text('Nome: ${_pokemon.name}'),
            Text('Tipo: ${_pokemon.type}'),
            Text('Experiência Base: ${_pokemon.baseExperience}'),
            Text('Altura: ${_pokemon.height}'),
            Text('Peso: ${_pokemon.weight}'),
            // Adicione mais informações conforme necessário
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: confirmarSoltura,
            tooltip: 'Confirmar Soltura',
            child: Icon(Icons.check),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: 'Cancelar',
            child: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
