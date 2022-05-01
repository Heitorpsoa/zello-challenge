import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http; //TODO: adicionar permissao ao android

Future<bool> addFavorite(Map<String, String> favoriteJson) async {
  //TODO: Colocar URL em um .env

  // Simular o created at do backend jaq estamos usando apenas um mocker
  String created_at = DateTime.now().toString();
  favoriteJson['createdAt'] = created_at;

  http.Response response = await http.post(Uri.parse("http://localhost:3005/favorite"), body: favoriteJson);

  if (response.statusCode != 200) {
    log("Erro ao criar favorito");
    log(response.body);
    return false;
  }

  return true;
}
