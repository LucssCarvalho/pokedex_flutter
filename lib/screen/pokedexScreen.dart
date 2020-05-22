import 'package:flutter/material.dart';
import 'package:pokedex_flutter/dialogs/CustomDialog.dart';
import 'package:pokedex_flutter/domain/pokemon/Pokemon_Response_class.dart';
import 'package:pokedex_flutter/networking/serchPokemon_networking.dart';

class PokedexScreen extends StatefulWidget {
  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  TextEditingController pokemonIdController = TextEditingController();

  PokemonResponse pokemonResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              color: Colors.redAccent,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[100],
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0),
                                        ),
                                      ),
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(top: 40.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                                color: Colors.grey[100]),
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 5,
                                                        width: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(30),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        'BUSCAR POKEMON',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent,
                                                            fontSize: 25),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    controller:
                                                        pokemonIdController,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'nome ou número do pokemon',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      prefixIcon: Icon(
                                                        Icons.search,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    validator: (text) {
                                                      if (text.isEmpty)
                                                        return "digite o nome do pokemon";
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      RaisedButton(
                                                        color: Colors.white,
                                                        onPressed: () {
                                                          search(
                                                              pokemonIdController
                                                                  .text,
                                                              context);
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 150,
                                                          child: Text(
                                                            "BUSCAR",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        shape: StadiumBorder(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: CircleAvatar(
                                  radius: 27,
                                  backgroundColor: Colors.blue[900],
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.red[700],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.green,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 90.0, right: 20, left: 20, bottom: 50),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: pokemonResponse == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Em busca de um pokemon ??',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    decoration: TextDecoration.none),
                              )
                            ],
                          )
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${pokemonResponse.name} - ${pokemonResponse.id}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      'Normal',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      'Shiny',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Image.network(
                                      '${pokemonResponse.sprites.frontDefault}',
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                    Image.network(
                                      '${pokemonResponse.sprites.frontShiny}',
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Habilidades',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildAbilitiesRow(pokemonResponse),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void search(String id, context) async {
    pokemonResponse = await PokemonNetworking.searchPokemon(id);
    Navigator.pop(context);
    if (pokemonResponse == null) {
      return showDialog(
        builder: (BuildContext context) => CustomDialog(
          title: "Pokemon não encontrado",
          description:
              "Não foi possivel encontrar nenhum pokemon com esse nome.",
          buttonText: "back",
        ),
        context: context,
      );
    }
    setState(() {});
  }
}

Widget buildAbilitiesRow(PokemonResponse pokemonResponse) {
  return GridView.builder(
    itemCount: pokemonResponse.moves.length,
    itemBuilder: (BuildContext context, index) {
      return Padding(
        padding: EdgeInsets.all(2),
        child: Chip(
          backgroundColor: Colors.red,
          label: Text(
            pokemonResponse.moves[index].move.name,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    },
    gridDelegate:
        SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100),
  );
}
