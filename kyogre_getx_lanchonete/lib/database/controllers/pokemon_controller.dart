import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kyogre_getx_lanchonete/database/states/pokemon_state.dart';
import 'package:dio/dio.dart';

class PokemonController extends ChangeNotifier {
  var state = PokemonState.initial();

  var dio = Dio();

  getPokemons() async {
    state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon');
      final List<dynamic> pokemonList = jsonDecode(response.data)['name'];
      state = state.copyWith(pokemonList: pokemonList);
    } catch (e) {
      state = state.copyWith(error: 'Erro ao buscar pokemons');
    } finally {
      state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }
}
