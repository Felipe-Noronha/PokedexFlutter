import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:terceira_prova/app_database.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:terceira_prova/pokemon_model.dart';

class TelaCaptura extends StatefulWidget {
  @override
  _TelaCapturaState createState() => _TelaCapturaState();
}

class _TelaCapturaState extends State<TelaCaptura> {
  List<Pokemon> allPokemon = [];
  List<Pokemon> selectedPokemon = [];
  Set<String> pokemonsCapturados = {};

  late AppDatabase appDatabase;

  bool isLoading = true;
  bool hasConnection = true;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasConnection = false;
        isLoading = false;
      });
    } else {
      fetchData();
      initializeDatabase();
    }
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon/'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('results')) {
          final List<dynamic> results = data['results'];

          for (var result in results) {
            await fetchPokemonDetails(result['url']);
          }

          selectRandomPokemon();
        } else {
          print('Error: Response does not contain "results" key.');
        }
      } else {
        print('Error: Failed to load Pokemon data - ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      print('Error fetching data: $error\n$stackTrace');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchPokemonDetails(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Pokemon pokemon = Pokemon.fromJson(data);
      allPokemon.add(pokemon);
    } else {
      print('Error: Failed to load Pokemon details - ${response.statusCode}');
    }
  }

  void selectRandomPokemon() {
    final random = List<Pokemon>.from(allPokemon)..shuffle();
    selectedPokemon = random.sublist(0, 6);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> initializeDatabase() async {
    appDatabase = await $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build() as AppDatabase;
  }

  void capturarPokemon(Pokemon pokemon) async {
    if (!pokemonsCapturados.contains(pokemon.name)) {
      pokemonsCapturados.add(pokemon.name);

      try {
        await appDatabase.pokemonDao.insertPokemon(pokemon);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Capturado!'),
              content: Text('${pokemon.name} foi capturado!'),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await carregarPokemonsCapturados();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        print('Erro ao capturar Pokémon: $e');
      }
    }
  }

  Future<void> carregarPokemonsCapturados() async {
    final listaCapturados = await appDatabase.pokemonDao.findAllPokemons();
    setState(() {
      pokemonsCapturados =
          listaCapturados.map((pokemon) => pokemon.name).toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : !hasConnection
              ? Center(
                  child: Text('Sem conexão com a internet.'),
                )
              : ListView.builder(
                  itemCount: selectedPokemon.length,
                  itemBuilder: (context, index) {
                    final pokemon = selectedPokemon[index];
                    return ListTile(
                      title: Text(pokemon.name),
                      trailing: IconButton(
                        icon: Icon(Icons.catching_pokemon),
                        color: pokemonsCapturados.contains(pokemon.name)
                            ? Colors.grey.shade700
                            : Colors.red,
                        onPressed: () {
                          capturarPokemon(pokemon);
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: selectRandomPokemon,
        tooltip: 'Sortear Pokémon',
        child: Icon(Icons.casino),
      ),
    );
  }
}
