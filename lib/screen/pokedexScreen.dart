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
  TextEditingController controller = TextEditingController();

  PokeApi firstGen;
  List<Pokemon> _searchResult = [];

  @override
  initState() {
    super.initState();
    this.getFirstGen().then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => null,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[900],
          title: Container(
            child: new Card(
              child: new ListTile(
                leading: new Icon(Icons.search),
                title: new TextField(
                  controller: controller,
                  decoration: new InputDecoration(
                      hintText: 'Buscar pokemon', border: InputBorder.none),
                  onChanged: onSearchTextChanged,
                ),
                trailing: new IconButton(
                  icon: new Icon(Icons.cancel),
                  onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Container(
                child: firstGen == null
                    ? Center(
                        child: Column(
                          children: [CircularProgressIndicator()],
                        ),
                      )
                    : Expanded(
                        child: _searchResult.length != 0 ||
                                controller.text.isNotEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemCount: _searchResult.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  var pokemon = _searchResult[index];
                                  return pokemonTile(pokemon);
                                },
                              )
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemCount: firstGen.pokemon.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  var pokemon = firstGen.pokemon[index];
                                  return pokemonTile(pokemon);
                                },
                              ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    firstGen.pokemon.forEach((pokemon) {
      if (pokemon.name.toUpperCase().contains(text.toUpperCase()))
        _searchResult.add(pokemon);
    });

    setState(() {});
  }

  Widget pokemonTile(Pokemon pokemon) {
    return GestureDetector(
      onTap: () {
        List<Pokemon> nextEvolution = [];
        List<Pokemon> prevEvolution = [];

        if (pokemon.nextEvolution != null) {
          pokemon.nextEvolution.forEach((pokes) {
            nextEvolution.add(firstGen.pokemon
                .firstWhere((element) => pokes.name == element.name));
          });
        }

        if (pokemon.prevEvolution != null) {
          pokemon.prevEvolution.forEach((pokes) {
            prevEvolution.add(firstGen.pokemon
                .firstWhere((element) => pokes.name == element.name));
          });
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PokemonDetail(
                pokemon, nextEvolution, prevEvolution, firstGen.pokemon),
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

  getFirstGen() async {
    var pokemonResponse = await PokemonNetworking.searchFirstGen();
    setState(() {
      firstGen = pokemonResponse;
    });
  }
}
