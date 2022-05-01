import 'package:http/http.dart' as http; //TODO: adicionar permissao ao android

Future<bool> deleteFavorite(Map<String, String> favorite) async {
  String id = favorite["id"] ?? "-1";

  http.Response response = await http.delete(Uri.parse("http://localhost:3005/favorite/${id}"));

  if (response.statusCode == 200) {
    return true;
  }

  return false;
}
