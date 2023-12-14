// pokemon_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pokemon_model.dart'; // Adicione esta linha

class PokemonApi {
  final String baseUrl = 'https://pokeapi.co/api/v2/pokemon/';

  Future<List<Pokemon>> getAllPokemon() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> results = jsonDecode(response.body)['results'];
      return results.map((json) => Pokemon.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }
}
