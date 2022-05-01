import 'package:flutter/material.dart';
import 'package:pixstar/util/favorite.dart';
import 'package:pixstar/widgets/favorite_profile.dart/edit_favorite_request.dart';
import 'package:pixstar/widgets/favorite_profile.dart/delete_favorite_request.dart';
import 'package:pixstar/widgets/favorite_profile.dart/generate_favorite_form_inputs.dart';

class FavoriteProfileWidget extends StatefulWidget {
  FavoriteProfileWidget({Key? key, required this.favorite, required this.callbackUpdateState}) : super(key: key);
  final Favorite favorite;
  Function callbackUpdateState;

  @override
  State<FavoriteProfileWidget> createState() => _FavoriteProfileWidgetState();
}

class _FavoriteProfileWidgetState extends State<FavoriteProfileWidget> {
  Map<String, String> _favoriteJson = {};

  @override
  void initState() {
    super.initState();
    _favoriteJson = widget.favorite.toJson();
  }

  void updateInput(value, key) {
    _favoriteJson[key] = value;
  }

  void edit() async {
    await editFavorite(_favoriteJson);
    widget.callbackUpdateState();
  }

  void delete() async {
    await deleteFavorite(_favoriteJson);
    widget.callbackUpdateState();
  }

  ElevatedButton editButton(BuildContext context) {
    return ElevatedButton(
      child: Icon(
        Icons.edit,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: edit,
    );
  }

  ElevatedButton deleteButton(BuildContext context) {
    return ElevatedButton(
      child: Icon(
        Icons.delete,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: delete,
    );
  }

  Widget getButtons(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.03),
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          editButton(context),
          deleteButton(context),
        ],
      ),
    );
  }

  Widget creationLabel(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Criado em:",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColor,
            ),
          ),
          TextSpan(
            text: _favoriteJson["createdAt"],
            style: TextStyle(
              color: Theme.of(context).hintColor,
            ),
          ),
          TextSpan(
            text: "Atualizado em:",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColor,
            ),
          ),
          TextSpan(
            text: _favoriteJson["updatedAt"],
            style: TextStyle(
              color: Theme.of(context).hintColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitle(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 0.1 * height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        width: width * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              widget.favorite.getFavoritePixIcon(),
              color: Theme.of(context).backgroundColor,
            ),
            Text(
              widget.favorite.getFavoritePixTitle(),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: getTitle(context),
      children: [creationLabel(context)] + getProfileFormInputs(context, _favoriteJson, updateInput, edit) + [getButtons(context)],
    );
  }
}
