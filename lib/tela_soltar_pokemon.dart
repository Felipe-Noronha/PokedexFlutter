import 'package:flutter/material.dart';
import 'pokemon_model.dart';
import 'package:terceira_prova/app_database.dart';

class TelaSoltarPokemon extends StatefulWidget {
  final Pokemon pokemon;

  TelaSoltarPokemon({required this.pokemon});

  @override
  _TelaSoltarPokemonState createState() => _TelaSoltarPokemonState();
}

class _TelaSoltarPokemonState extends State<TelaSoltarPokemon> {
  late Pokemon _pokemon;
  late AppDatabase _appDatabase;

  @override
  void initState() {
    super.initState();
    _pokemon = widget.pokemon;
    _initializeDatabase();
  }

  _initializeDatabase() async {
    _appDatabase = await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build() as AppDatabase;
  }

  String getHeroTag(String property) {
    return '${_pokemon.id}_$property';
  }

  void confirmarSoltura(BuildContext context) async {
    try {
      await _appDatabase.pokemonDao.deletePokemonById(_pokemon.id);

      Navigator.pop(context, true);
    } catch (e) {
      print('Erro ao soltar Pokémon: $e');
    }
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
            Hero(
              tag: getHeroTag('pokemon-details'),
              child: Text(
                'Detalhes do Pokémon:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Text('ID: ${_pokemon.id}'),
            Hero(
              tag: getHeroTag('pokemon-name'),
              child: Text('Nome: ${_pokemon.name}'),
            ),
            Hero(
              tag: getHeroTag('pokemon-type'),
              child: Text('Tipo: ${_pokemon.type}'),
            ),
            Hero(
              tag: getHeroTag('pokemon-exp'),
              child: Text('Experiência Base: ${_pokemon.baseExperience}'),
            ),
            Hero(
              tag: getHeroTag('pokemon-height'),
              child: Text('Altura: ${_pokemon.height}'),
            ),
            Hero(
              tag: getHeroTag('pokemon-weight'),
              child: Text('Peso: ${_pokemon.weight}'),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => confirmarSoltura(context),
            tooltip: 'Confirmar Soltura',
            child: Icon(Icons.check),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            tooltip: 'Cancelar',
            child: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
