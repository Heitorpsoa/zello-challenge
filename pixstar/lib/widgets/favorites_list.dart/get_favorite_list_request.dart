import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http; //TODO: adicionar permissao ao android

import './../../util/favorite.dart';

Future<List<Favorite>> fetchFavorites() async {
  //TODO: Colocar URL em um .env

  // await Future.delayed(Duration(seconds: 2));
  http.Response response = await http.get(Uri.parse("http://localhost:3005/favorite"));

  if (response.statusCode != 200) {
    log("Erro ao buscar lista de favoritos");
    log(response.body);
    throw ("Erro ao buscar lista de favoritos");
  }

  List<dynamic> jsonFavorites = jsonDecode(response.body);
  List<Favorite> _favorites = [];

  for (var jsonFavorite in jsonFavorites) {
    _favorites.add(Favorite.fromJson(jsonFavorite));
  }
  return _favorites;
}
