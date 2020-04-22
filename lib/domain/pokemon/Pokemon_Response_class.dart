import 'package:pokedex_flutter/domain/Moves_Response_class.dart';
import 'package:pokedex_flutter/domain/pokemon/Abilities_Response_class.dart';
import 'package:pokedex_flutter/domain/pokemon/Ability_Response_class.dart';
import 'package:pokedex_flutter/domain/pokemon/GameIndices_Response_class.dart';
import 'package:pokedex_flutter/domain/pokemon/Sprites_Response_class.dart';
import 'package:pokedex_flutter/domain/pokemon/Stats_Response_class.dart';
import 'package:pokedex_flutter/domain/pokemon/TypesResponse_class.dart';

import 'package:json_annotation/json_annotation.dart';

// part 'pokemon_response_class.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PokemonResponse {
  List<Abilities> abilities;
  int baseExperience;
  // List<Forms> forms;
  List<GameIndices> gameIndices;
  int height;
  List<Null> heldItems;
  int id;
  bool isDefault;
  String locationAreaEncounters;
  List<Moves> moves;
  String name;
  int order;
  Ability species;
  Sprites sprites;
  List<Stats> stats;
  List<Types> types;
  int weight;

  PokemonResponse(
      {this.abilities,
      this.baseExperience,
      // this.forms,
      this.gameIndices,
      this.height,
      this.heldItems,
      this.id,
      this.isDefault,
      this.locationAreaEncounters,
      this.moves,
      this.name,
      this.order,
      this.species,
      this.sprites,
      this.stats,
      this.types,
      this.weight});
}
