import 'dart:convert';
import 'package:pokedex_flutter/domain/pokeapi.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_flutter/networking/app_settings.dart';

class PokemonNetworking {
  static Future<PokeApi> searchFirstGen() async {
    var header = {"Content-Type": "application/json"};

    var response = await http.get(AppSettings().pokeApi, headers: header);

    switch (response.statusCode) {
      case 200:
        return PokeApi.fromJson(json.decode(response.body));
      default:
        print('error');
        return null;
    }
  }
}
