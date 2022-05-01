import 'package:pixstar/util/favorite.dart';

import 'validators.dart';

enum registerTypeIndexName { email, phone, cpfCnpj, bank }

extension ParseToString on registerTypeIndexName {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension ParseToTranslatedString on registerTypeIndexName {
  String translate() {
    switch (toShortString()) {
      case "email":
        return "E-mail";
      case "phone":
        return "Telefone";
      case "cpfCnpj":
        return "CPF/CNPJ";
      case "bank":
        return "Conta de Banco";
      default:
        return "-";
    }
  }
}

var registerTypes = {
  "email": {
    "inputs": [Favorite.getInputType('email')]
  },
  "phone": {
    "inputs": [Favorite.getInputType('phone')]
  },
  "cpfCnpj": {
    "inputs": [Favorite.getInputType('cpfCnpj')]
  },
  "bank": {
    "inputs": [
      Favorite.getInputType('name'),
      Favorite.getInputType('cpfCnpj'),
      Favorite.getInputType('agency'),
      Favorite.getInputType('account'),
      Favorite.getInputType('bankName'),
    ]
  }
};
