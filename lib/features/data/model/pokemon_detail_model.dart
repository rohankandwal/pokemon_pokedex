import 'package:json_annotation/json_annotation.dart';

part 'pokemon_detail_model.g.dart';

@JsonSerializable()
class PokemonDetailModel {
  final int id;
  final String name;
  final List<PokemonTypeObjectModel> types;
  final PokemonSpritesModel sprites;
  final List<PokemonStatsModel> stats;
  final int height;
  final int weight;

  PokemonDetailModel(
    this.id,
    this.name,
    this.types,
    this.sprites,
    this.stats,
    this.height,
    this.weight,
  );

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDetailModelToJson(this);
}

@JsonSerializable()
class PokemonTypeObjectModel {
  final PokemonTypeModel type;

  PokemonTypeObjectModel(
    this.type,
  );

  factory PokemonTypeObjectModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeObjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonTypeObjectModelToJson(this);
}

@JsonSerializable()
class PokemonTypeModel {
  final String name;

  PokemonTypeModel(
    this.name,
  );

  factory PokemonTypeModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonTypeModelToJson(this);
}

@JsonSerializable()
class PokemonSpritesModel {
  final PokemonSpritesOthersModel other;

  PokemonSpritesModel(
    this.other,
  );

  factory PokemonSpritesModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonSpritesModelToJson(this);
}

@JsonSerializable()
class PokemonSpritesOthersModel {
  @JsonKey(name: "official-artwork")
  final PokemonOfficialArtworkModel officialArtwork;

  PokemonSpritesOthersModel(
    this.officialArtwork,
  );

  factory PokemonSpritesOthersModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesOthersModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonSpritesOthersModelToJson(this);
}

@JsonSerializable()
class PokemonOfficialArtworkModel {
  @JsonKey(name: "front_default")
  final String? frontDefault;

  PokemonOfficialArtworkModel(
    this.frontDefault,
  );

  factory PokemonOfficialArtworkModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonOfficialArtworkModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonOfficialArtworkModelToJson(this);
}

@JsonSerializable()
class PokemonStatsModel {
  @JsonKey(name: "base_stat")
  final int baseStats;
  final int effort;
  final PokemonStatDetailModel stat;

  PokemonStatsModel(
    this.baseStats,
    this.effort,
    this.stat,
  );

  factory PokemonStatsModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonStatsModelToJson(this);
}

@JsonSerializable()
class PokemonStatDetailModel {
  final String name;

  PokemonStatDetailModel(
    this.name,
  );

  factory PokemonStatDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonStatDetailModelToJson(this);
}
