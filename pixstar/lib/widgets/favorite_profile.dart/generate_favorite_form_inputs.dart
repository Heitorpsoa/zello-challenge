import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:pixstar/util/favorite.dart';
import 'package:pixstar/util/input_type.dart';

TextFormField generateInput(key, value, BuildContext context, Function updateInput, bool isFieldFavorite, Function editFavorite) {
  Input inputType = Favorite.getInputType(key);

  return TextFormField(
    decoration: InputDecoration(
      icon: IconButton(
        icon: Icon(
          isFieldFavorite ? Icons.star : Icons.star_border,
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          String _key = Favorite.bankKeys.contains(key) ? "bank" : key;
          updateInput(_key, "pixType");
          editFavorite();
        },
      ),
      hintText: inputType.hintText,
      labelText: inputType.labelText,
      labelStyle: Theme.of(context).textTheme.labelMedium,
      hintStyle: TextStyle(color: Theme.of(context).hintColor),
    ),
    inputFormatters: [
      TextInputMask(mask: inputType.mask),
    ],
    style: TextStyle(
      color: Theme.of(context).primaryColorDark,
    ),
    onChanged: (newInputValue) {
      updateInput(newInputValue, key);
    },
    initialValue: value == "-" ? null : value,
  );
}

List<Widget> getProfileFormInputs(BuildContext context, Map<String, String> _favoriteJson, Function updateInput, Function editFavorite) {
  List<Widget> inputs = [];
  _favoriteJson.forEach((key, value) {
    if (Favorite.canUserEdit(key)) {
      bool isFieldFavorite = Favorite.isKeyFavorite(key, _favoriteJson['pixType']);
      inputs.add(generateInput(key, value, context, updateInput, isFieldFavorite, editFavorite));
    }
  });

  return inputs;
}
