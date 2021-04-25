import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex_flutter/const/constColors.dart';
import 'package:pokedex_flutter/domain/pokeapi.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonDetail extends StatefulWidget {
  final Pokemon pokemon;
  final List<Pokemon> nextEvolution;
  final List<Pokemon> prevEvolution;
  final List<Pokemon> allPokemons;
  PokemonDetail(
      this.pokemon, this.nextEvolution, this.prevEvolution, this.allPokemons);

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
          createEvolutions()
        ],
      ),
    );
  }

  Widget createEvolutions() {
    List<Widget> nextEvolutions = [];
    List<Widget> prevEvolutions = [];
    widget.prevEvolution.forEach((element) {
      prevEvolutions.add(circlePokemonEvolution(element));
    });
    widget.nextEvolution.forEach((element) {
      nextEvolutions.add(circlePokemonEvolution(element));
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(height: 30),
            Text(
              "Evoluções",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Row(
                  children: prevEvolutions,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 53,
                          child: CircleAvatar(
                            radius: 51,
                            backgroundColor: ConstColors.getColorType(
                              type: widget.pokemon.type[0],
                            ),
                            child: getPokemonImage(widget.pokemon),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: nextEvolutions,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  circlePokemonEvolution(Pokemon pokemon) {
    return GestureDetector(
      onTap: () {
        List<Pokemon> nextEvolution = [];
        List<Pokemon> prevEvolution = [];

        if (pokemon.nextEvolution != null) {
          pokemon.nextEvolution.forEach((pokes) {
            nextEvolution.add(widget.allPokemons
                .firstWhere((element) => pokes.name == element.name));
          });
        }

        if (pokemon.prevEvolution != null) {
          pokemon.prevEvolution.forEach((pokes) {
            prevEvolution.add(widget.allPokemons
                .firstWhere((element) => pokes.name == element.name));
          });
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PokemonDetail(
                pokemon, nextEvolution, prevEvolution, widget.allPokemons),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            child: getPokemonImage(pokemon),
          ),
        ),
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
