import 'package:floor/floor.dart';
import 'pokemon_model.dart';

@dao
abstract class PokemonDao {
  @Query('SELECT * FROM pokemon')
  Future<List<Pokemon>> findAllPokemons();

  @Query('SELECT * FROM pokemon WHERE id = :id')
  Future<Pokemon?> findPokemonById(int id);

  @insert
  Future<void> insertPokemon(Pokemon pokemon);

  @update
  Future<void> updatePokemon(Pokemon pokemon);

  @delete
  Future<void> deletePokemon(Pokemon pokemon);

  @Query(
      'DELETE FROM pokemon WHERE id = :id') // Adicione esta linha para excluir por ID
  Future<void> deletePokemonById(int id);
}
