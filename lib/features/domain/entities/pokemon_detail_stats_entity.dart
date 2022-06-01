import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'pokemon_detail_stats_entity.g.dart';

@HiveType(typeId: 1)
class PokemonDetailStatsEntity extends Equatable {
  @HiveField(0)
  final int baseStat;
  @HiveField(1)
  final int effort;
  @HiveField(2)
  final String name;

  const PokemonDetailStatsEntity(
      {required this.baseStat, required this.effort, required this.name});

  @override
  List<Object?> get props => [baseStat, effort, name];
}
