import 'package:flutter/material.dart';
import 'package:terceira_prova/app_database.dart'; // Importe o seu banco de dados
import 'package:terceira_prova/tela_soltar_pokemon.dart';
import 'pokemon_model.dart';
import 'tela_detalhes_pokemon.dart';

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
    _initializeDatabase();
  }

  // Método assíncrono para inicializar o banco de dados
  _initializeDatabase() async {
    _appDatabase = await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build() as AppDatabase;

    // Atualizar a lista de pokémons capturados sempre que a tela for exibida
    await carregarPokemonsCapturados();
  }

  // Método para carregar a lista de pokémons capturados
  Future<void> carregarPokemonsCapturados() async {
    final listaCapturados = await _appDatabase.pokemonDao.findAllPokemons();
    setState(() {
      _pokemonsCapturados = listaCapturados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
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
                    // Navegar para TelaDetalhesPokemon
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TelaDetalhesPokemon(pokemon: pokemon),
                      ),
                    );
                  },
                  onLongPress: () async {
                    // Navegar para TelaSoltarPokemon
                    final resultado = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TelaSoltarPokemon(pokemon: pokemon),
                      ),
                    );

                    if (resultado == true) {
                      // Se o resultado for true, recarregue a lista
                      await carregarPokemonsCapturados();
                    }
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
