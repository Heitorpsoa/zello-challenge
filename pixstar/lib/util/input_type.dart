typedef ValidatorFunction = String? Function(String? value);

class Input {
  final ValidatorFunction validator;
  final String hintText;
  final String labelText;
  final String jsonKey;
  final dynamic mask;

  Input({required this.validator, required this.hintText, required this.labelText, required this.jsonKey, required this.mask});
}
