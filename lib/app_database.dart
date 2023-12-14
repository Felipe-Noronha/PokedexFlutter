// app_database.dart

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:terceira_prova/pokemon_dao.dart';
import 'pokemon_model.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [Pokemon])
abstract class AppDatabase extends FloorDatabase {
  PokemonDao get pokemonDao;
}
