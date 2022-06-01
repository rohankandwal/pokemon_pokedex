import 'package:json_annotation/json_annotation.dart';

part 'pokemon_list_model.g.dart';

@JsonSerializable()
class PokemonListModel {
  final List<PokemonListResultModel> results;

  PokemonListModel(this.results);

  factory PokemonListModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonListModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonListModelToJson(this);
}

@JsonSerializable()
class PokemonListResultModel {
  final String name;
  final String url;

  PokemonListResultModel(this.name, this.url);

  factory PokemonListResultModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonListResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonListResultModelToJson(this);
}
