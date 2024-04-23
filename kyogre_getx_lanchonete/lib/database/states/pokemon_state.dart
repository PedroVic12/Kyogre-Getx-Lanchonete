class PokemonState {
  final bool isLoading;
  final List<dynamic> pokemonList;
  final String error;

  PokemonState({
    required this.isLoading,
    required this.pokemonList,
    required this.error,
  });

  factory PokemonState.initial() => PokemonState(
        isLoading: false,
        pokemonList: [],
        error: '',
      );

  PokemonState copyWith({
    bool? isLoading,
    List<dynamic>? pokemonList,
    String? error,
  }) {
    return PokemonState(
      isLoading: isLoading ?? this.isLoading,
      pokemonList: pokemonList ?? this.pokemonList,
      error: error ?? this.error,
    );
  }
}
