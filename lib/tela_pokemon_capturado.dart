// tela_pokemon_capturado.dart

import 'package:flutter/material.dart';
import 'pokemon_model.dart';
import 'tela_detalhes_pokemon.dart';
import 'tela_soltar_pokemon.dart';

class TelaPokemonCapturado extends StatefulWidget {
  final List<Pokemon> pokemonsCapturados;

  TelaPokemonCapturado({required this.pokemonsCapturados});

  @override
  _TelaPokemonCapturadoState createState() => _TelaPokemonCapturadoState();
}

class _TelaPokemonCapturadoState extends State<TelaPokemonCapturado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémons Capturados'),
      ),
      body: widget.pokemonsCapturados.isEmpty
          ? Center(
              child: Text('Nenhum Pokémon capturado ainda.'),
            )
          : ListView.builder(
              itemCount: widget.pokemonsCapturados.length,
              itemBuilder: (context, index) {
                final pokemon = widget.pokemonsCapturados[index];
                return GestureDetector(
                  onTap: () {
                    // Navegar para TelaDetalhesPokemon
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TelaDetalhesPokemon(pokemon: pokemon),
                      ),
                    );
                  },
                  onLongPress: () {
                    // Navegar para TelaSoltarPokemon
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TelaSoltarPokemon(pokemon: pokemon),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(pokemon.name),
                    // Adicione mais informações ou personalizações conforme necessário
                  ),
                );
              },
            ),
    );
  }
}
