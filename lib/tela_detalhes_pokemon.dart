import 'package:flutter/material.dart';
import 'pokemon_model.dart';

class TelaDetalhesPokemon extends StatelessWidget {
  final Pokemon pokemon;

  TelaDetalhesPokemon({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pokémon'),
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
            Text('Nome: ${pokemon.name}'),
            Text('Tipo: ${pokemon.type}'),
            Text('Experiência Base: ${pokemon.baseExperience}'),
            Text('Altura: ${pokemon.height}'),
            Text('Peso: ${pokemon.weight}'),
          ],
        ),
      ),
    );
  }
}
