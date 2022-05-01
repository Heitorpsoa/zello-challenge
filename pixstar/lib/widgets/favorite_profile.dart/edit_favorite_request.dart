import 'package:http/http.dart' as http; //TODO: adicionar permissao ao android

Future<bool> editFavorite(Map<String, String> favorite) async {
  String updatedAt = DateTime.now().toString();
  favorite["updatedAt"] = updatedAt;

  http.Response response = await http.put(Uri.parse("http://localhost:3005/favorite/${favorite["id"]}"), body: favorite);

  if (response.statusCode == 200) {
    return true;
  }

  return false;
}
