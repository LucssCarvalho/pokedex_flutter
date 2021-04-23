import 'package:flutter/material.dart';

class ConstColors {
  static Color getColorType({String type}) {
    switch (type) {
      case 'Normal':
        return Colors.brown[400];
        break;
      case 'Fire':
        return Colors.red[400];
        break;
      case 'Water':
        return Colors.blue[300];
        break;
      case 'Grass':
        return Colors.green[400];
        break;
      case 'Electric':
        return Colors.amber[300];
        break;
      case 'Ice':
        return Colors.cyanAccent[400];
        break;
      case 'Fighting':
        return Colors.orange;
        break;
      case 'Poison':
        return Colors.purple[300];
        break;
      case 'Ground':
        return Colors.orange[300];
        break;
      case 'Flying':
        return Colors.indigo[200];
        break;
      case 'Psychic':
        return Colors.pink[400];
        break;
      case 'Bug':
        return Colors.lightGreen[500];
        break;
      case 'Rock':
        return Colors.grey;
        break;
      case 'Ghost':
        return Colors.indigo[400];
        break;
      case 'Dark':
        return Colors.brown;
        break;
      case 'Dragon':
        return Colors.indigo[800];
        break;
      case 'Steel':
        return Colors.blueGrey;
        break;
      case 'Fairy':
        return Colors.pinkAccent[100];
        break;
      default:
        return Colors.grey;
        break;
    }
  }
}
