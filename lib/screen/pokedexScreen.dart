import 'package:flutter/material.dart';
import 'package:pokedex_flutter/const/constColors.dart';
import 'package:pokedex_flutter/domain/pokeapi.dart';
import 'package:pokedex_flutter/networking/serchPokemon_networking.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex_flutter/screen/pokemonDetail.dart';

class PokedexScreen extends StatefulWidget {
  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  TextEditingController pokemonIdController = TextEditingController();

  Future<PokeApi> firstGen;

  @override
  initState() {
    super.initState();
    getFirstGen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: FutureBuilder<PokeApi>(
        future: firstGen,
        builder: (BuildContext context, AsyncSnapshot<PokeApi> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: snapshot.data.pokemon.length,
                itemBuilder: (BuildContext ctx, index) {
                  var pokemon = snapshot.data.pokemon[index];
                  return pokemonTile(pokemon);
                },
              ),
            );
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Buscando Pokemons'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }

  Widget pokemonTile(Pokemon pokemon) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PokemonDetail(pokemon),
          ),
        );
      },
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pokemon.name.toUpperCase(),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "#${pokemon.num.toUpperCase()}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getTypes(pokemon),
                getPokemonImage(pokemon),
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
            color: ConstColors.getColorType(type: pokemon.type[0]),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget getTypes(Pokemon pokemon) {
    List<Widget> types = [];
    pokemon.type.forEach((type) {
      types.add(Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              padding: EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  type.trim(),
                  style: TextStyle(color: Colors.white),
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
    return Column(
        children: types, crossAxisAlignment: CrossAxisAlignment.start);
  }

  Widget getPokemonImage(Pokemon pokemon) {
    return CachedNetworkImage(
      height: 70,
      width: 70,
      imageUrl: pokemon.img,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  getFirstGen() {
    var pokemonResponse = PokemonNetworking.searchFirstGen();
    setState(() {
      firstGen = pokemonResponse;
    });
  }
}
