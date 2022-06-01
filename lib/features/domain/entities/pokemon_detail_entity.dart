import 'package:byzat_pokemon/features/domain/entities/pokemon_detail_stats_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'pokemon_detail_entity.g.dart';

@HiveType(typeId: 0)
class PokemonDetailEntity extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String type;
  @HiveField(3)
  final String? imageUrl;
  @HiveField(4)
  final List<PokemonDetailStatsEntity> stats;
  @HiveField(5)
  final int height;
  @HiveField(6)
  final int weight;

  PokemonDetailEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.stats,
    required this.height,
    required this.weight,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, type, imageUrl, stats, height, weight];
}
