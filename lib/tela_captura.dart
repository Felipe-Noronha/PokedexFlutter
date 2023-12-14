import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:terceira_prova/tela_pokemon_capturado.dart';
import 'pokemon_model.dart';

class TelaCaptura extends StatefulWidget {
  @override
  _TelaCapturaState createState() => _TelaCapturaState();
}

class _TelaCapturaState extends State<TelaCaptura> {
  List<Pokemon> allPokemon = [];
  List<Pokemon> selectedPokemon = [];
  Set<String> pokemonsCapturados = {};

  @override
  void initState() {
    super.initState();
    fetchData();
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
    setState(() {});
  }

  void capturarPokemon(Pokemon pokemon) {
    if (!pokemonsCapturados.contains(pokemon.name)) {
      pokemonsCapturados.add(pokemon.name);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Capturado!'),
            content: Text('${pokemon.name} foi capturado!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {}); // Atualiza a interface
                  List<Pokemon> pokemonsCapturadosList = pokemonsCapturados
                      .map((name) => allPokemon
                          .firstWhere((pokemon) => pokemon.name == name))
                      .toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaPokemonCapturado(
                        pokemonsCapturados: pokemonsCapturadosList,
                      ),
                    ),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Captura'),
      ),
      body: selectedPokemon.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: selectedPokemon.length,
              itemBuilder: (context, index) {
                final pokemon = selectedPokemon[index];
                return ListTile(
                  title: Text(pokemon.name),
                  trailing: ElevatedButton(
                    onPressed: () {
                      capturarPokemon(pokemon);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: pokemonsCapturados.contains(pokemon.name)
                          ? Colors.grey
                          : null,
                    ),
                    child: Text('Capturar'),
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
