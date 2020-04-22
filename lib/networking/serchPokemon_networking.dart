// import 'dart:convert';
// import 'package:parceleja_mobile/services/user.dart';
// import 'package:parceleja_mobile/domain/simulation/simulation_response.dart';
// import 'package:parceleja_mobile/helpers/dialogs.dart';
// import 'package:flutter/material.dart';
// import 'package:parceleja_mobile/networking/base_pja_networking.dart';

// class PokemonNetworking {
//   Future<PokemonResponse> searchPokemon(String id) async {
//   var response = await super.get(resource: '${user.cnpj}/calculate/$value');
//     if (response == null) return null;

//     if (response == null) return null;

//     switch (response.statusCode) {
//       case 200:
//         return SimulationResponse.fromJson(json.decode(response.body));
//       default:
//         dialogSimulationError(super.context);
//         return null;
//     }
//   }
// }
