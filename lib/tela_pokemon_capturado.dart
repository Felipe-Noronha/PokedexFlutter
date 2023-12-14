import 'package:flutter/material.dart';
import 'package:terceira_prova/app_database.dart';
import 'pokemon_model.dart';
import 'tela_detalhes_pokemon.dart';
import 'tela_soltar_pokemon.dart';

class TelaPokemonCapturado extends StatefulWidget {
  @override
  _TelaPokemonCapturadoState createState() => _TelaPokemonCapturadoState();
}

class _TelaPokemonCapturadoState extends State<TelaPokemonCapturado> {
  late List<Pokemon> _pokemonsCapturados;
  late AppDatabase _appDatabase;

  @override
  void initState() {
    super.initState();
    _pokemonsCapturados = [];
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    _appDatabase =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    await carregarPokemonsCapturados();
  }

  Future<void> carregarPokemonsCapturados() async {
    final listaCapturados = await _appDatabase.pokemonDao.findAllPokemons();
    setState(() {
      _pokemonsCapturados = listaCapturados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémons Capturados'),
      ),
      body: _pokemonsCapturados.isEmpty
          ? Center(
              child: Text('Nenhum Pokémon capturado ainda.'),
            )
          : ListView.builder(
              itemCount: _pokemonsCapturados.length,
              itemBuilder: (context, index) {
                final pokemon = _pokemonsCapturados[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TelaDetalhesPokemon(pokemon: pokemon),
                      ),
                    );
                  },
                  onLongPress: () {
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
