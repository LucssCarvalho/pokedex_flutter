class AppSettings {
  static AppSettings _instance;
  factory AppSettings() {
    _instance ??= AppSettings._internalConstructor();

    return _instance;
  }

  AppSettings._internalConstructor() {
    isProduction = bool.fromEnvironment('dart.vm.product');

    pokeApi = isProduction
        ? 'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json'
        : 'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
  }
  String pokeApi;
  bool isProduction;
}
