import 'package:flutter/material.dart';
import 'package:pixstar/widgets/add_favorite/add_favorite_form_widget.dart';
import '../../util/register_types.dart';

class AddFavorite extends StatefulWidget {
  AddFavorite({Key? key, required this.callbackUpdateState}) : super(key: key);
  Function callbackUpdateState;

  @override
  State<AddFavorite> createState() => _AddFavoriteState();
}

class _AddFavoriteState extends State<AddFavorite> {
  registerTypeIndexName selectedType = registerTypeIndexName.email;

  void handleDropDownChange(registerTypeIndexName? value) {
    if (value == null) return;
    setState(() {
      selectedType = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Select
        DropdownButton<registerTypeIndexName>(
            items: registerTypeIndexName.values.map((value) {
              return DropdownMenuItem(value: value, child: Text(value.translate()));
            }).toList(),
            onChanged: handleDropDownChange,
            hint: Text(selectedType.translate())),
        // Form
        AddFavoriteForm(selectedType: selectedType, callbackUpdateState: widget.callbackUpdateState)
      ],
    );
  }
}
