import 'package:flutter/material.dart';
import 'package:pokedex_flutter/const/constColors.dart';
import 'package:pokedex_flutter/domain/pokeapi.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonDetail extends StatefulWidget {
  final Pokemon pokemon;
  PokemonDetail(this.pokemon);

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: ConstColors.getColorType(
                  type: widget.pokemon.type[0],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            height: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Stack(alignment: Alignment.center, children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(80, 255, 255, 255),
                      radius: 70,
                    ),
                    getPokemonImage(widget.pokemon),
                  ]),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.pokemon.name,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTypes(widget.pokemon),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Text(
                    widget.pokemon.height,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Text(
                    widget.pokemon.weight,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Text(
                    'tamanho',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Text(
                    'peso',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getTypes(Pokemon pokemon) {
    List<Widget> types = [];
    pokemon.type.forEach((type) {
      types.add(Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ConstColors.getColorType(
                  type: type,
                ),
              ),
              padding: EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    type.trim(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ));
    });
    return Row(children: types, crossAxisAlignment: CrossAxisAlignment.center);
  }

  Widget getPokemonImage(Pokemon pokemon) {
    return CachedNetworkImage(
      height: 150,
      fit: BoxFit.contain,
      imageUrl: pokemon.img,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
