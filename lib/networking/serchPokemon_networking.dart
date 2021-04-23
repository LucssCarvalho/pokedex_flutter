import 'dart:convert';
import 'package:pokedex_flutter/domain/pokeapi.dart';
import 'package:http/http.dart' as http;

class PokemonNetworking {
  static const String urlApi = 'https://pokeapi.co/api/v2';

  static Future<PokeApi> searchFirstGen() async {
    var url =
        'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

    var header = {"Content-Type": "application/json"};

    var response = await http.get(url, headers: header);

    switch (response.statusCode) {
      case 200:
        return PokeApi.fromJson(json.decode(response.body));
      default:
        print('error');
        return null;
    }
  }
}
