import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/domain/pokemon/Pokemon_Response_class.dart';
import 'package:http/http.dart' as http;

class PokemonNetworking {
  static const String urlApi = 'https://pokeapi.co/api/v2/pokemon/';

  static Future<PokemonResponse> searchPokemon(String id) async {
    var url = '$urlApi/$id';

    var header = {"Content-Type": "application/json"};

    var response = await http.get(url, headers: header);

    switch (response.statusCode) {
      case 200:
        return PokemonResponse.fromJson(json.decode(response.body));
      default:
        print('error');
        return null;
    }
  }
}
