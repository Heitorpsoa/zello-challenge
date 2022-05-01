import 'package:flutter/material.dart';
import 'package:pixstar/util/favorite.dart';
import 'package:pixstar/widgets/favorite_profile.dart/favorite_profile_widget.dart';

class FavoritesList extends StatefulWidget {
  FavoritesList({Key? key, required this.favorites, required this.callbackUpdateState}) : super(key: key);

  Future<List<Favorite>> favorites;
  Function callbackUpdateState;

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: FutureBuilder<List<Favorite>>(
          future: widget.favorites,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasData) {
              var favorites = snapshot.data ?? [];
              return Container(
                height: height * 0.8,
                margin: EdgeInsets.symmetric(horizontal: width * 0.3),
                child: ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return FavoriteProfileWidget(favorite: favorites[index], callbackUpdateState: widget.callbackUpdateState);
                    }),
              );
            }
            if (snapshot.hasError) {
              return Text('Erro ao buscar os registros: ${snapshot.error}');
            }

            return Text('Algo aconteceu');
          }),
    );
  }
}
