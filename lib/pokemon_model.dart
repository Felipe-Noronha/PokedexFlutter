import 'package:floor/floor.dart';

@Entity(tableName: 'pokemon')
class Pokemon {
  @PrimaryKey(autoGenerate: false)
  final int id;
  final String name;
  final String url;
  final String type;
  final int baseExperience;
  final int height;
  final int weight;

  Pokemon({
    required this.id,
    required this.name,
    required this.url,
    required this.type,
    required this.baseExperience,
    required this.height,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      type: json['types'][0]['type']['name'] ?? 'Unknown',
      baseExperience: json['base_experience'] ?? 0,
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
    );
  }
}
