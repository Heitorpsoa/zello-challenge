import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:pixstar/widgets/add_favorite/add_favorite_request.dart';
import '../../util/register_types.dart';
import '../../util/input_type.dart';

class AddFavoriteForm extends StatefulWidget {
  AddFavoriteForm({Key? key, required this.selectedType, required this.callbackUpdateState}) : super(key: key);
  Function callbackUpdateState;

  final registerTypeIndexName selectedType;
  @override
  State<AddFavoriteForm> createState() => AddFavoriteFormState();
}

class AddFavoriteFormState extends State<AddFavoriteForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _favorite_json = {};

  void updateInput(value, key) {
    _favorite_json[key] = value ?? "-";
  }

  void saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _favorite_json["pixType"] = widget.selectedType.toShortString();
      addFavorite(_favorite_json).then((value) => widget.callbackUpdateState());
    }
  }

  @override
  Widget build(BuildContext context) {
    var inputs = registerTypes[widget.selectedType.toShortString()]?['inputs'];
    inputs ??= [];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.6,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (Input input in inputs)
                Container(
                  width: width * 0.3,
                  margin: EdgeInsets.symmetric(vertical: height * 0.03),
                  child: TextFormField(
                      decoration: InputDecoration(
                        hintText: input.hintText,
                        labelText: input.labelText,
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                        hintStyle: TextStyle(color: Theme.of(context).hintColor),
                      ),
                      inputFormatters: [
                        TextInputMask(mask: input.mask),
                      ],
                      style: TextStyle(color: Theme.of(context).primaryColorDark),
                      validator: input.validator,
                      onSaved: (value) {
                        updateInput(value, input.jsonKey);
                      }),
                ),
              ElevatedButton(
                onPressed: () {
                  saveForm();
                },
                child: Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
