import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pixstar/widgets/favorites_list.dart/get_favorite_list_request.dart';
import 'package:pixstar/widgets/favorites_list.dart/favorite_list_widget.dart';
import 'package:pixstar/widgets/add_favorite/add_favorite_widget.dart';
import 'package:pixstar/widgets/welcome_title/welcome_title.dart';
import 'package:pixstar/util/favorite.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Favorite>> favorites;
  String selectedTab = "list"; // or add

  @override
  void initState() {
    super.initState();
    favorites = fetchFavorites();
  }

  void updateState() {
    setState(() {
      favorites = fetchFavorites();
      selectedTab = "list"; // Sempre volta para lista ao adicionar
    });
  }

  void changeSelectedState(String value) {
    setState(() {
      selectedTab = value;
    });
  }

  Widget changeTabWidget(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    TextStyle selectedStyle = TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor);
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.03),
      child: RichText(
        text: TextSpan(
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: 22,
            ),
            children: [
              TextSpan(
                text: "Favoritos",
                style: selectedTab == "list" ? selectedStyle : TextStyle(),
                recognizer: TapGestureRecognizer()..onTap = () => changeSelectedState('list'),
              ),
              const TextSpan(text: " | "),
              TextSpan(
                text: "Adicionar",
                style: selectedTab == "add" ? selectedStyle : TextStyle(),
                recognizer: TapGestureRecognizer()..onTap = () => changeSelectedState('add'),
              ),
            ]),
      ),
    );
  }

  Widget getSelectedWidget() {
    if (this.selectedTab == "list") {
      return FavoritesList(favorites: favorites, callbackUpdateState: updateState);
    }
    if (selectedTab == "add") {
      return AddFavorite(
        callbackUpdateState: updateState,
      );
    }
    return Text('-');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const WelcomeTitle(),
          changeTabWidget(context),
          getSelectedWidget(),
        ],
      ),
    );
  }
}
