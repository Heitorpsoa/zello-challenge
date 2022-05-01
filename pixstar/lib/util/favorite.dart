import "package:flutter/material.dart";
import 'package:pixstar/util/input_type.dart';
import 'validators.dart';

class Favorite {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String phone;
  final String cpfCnpj;
  final String agency;
  final String account;
  final String bankName;
  final String email;
  final String pixType;

  Favorite(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.name,
      required this.phone,
      required this.cpfCnpj,
      required this.agency,
      required this.account,
      required this.bankName,
      required this.email,
      required this.pixType});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
        id: json['id'] ?? "-",
        createdAt: json['createdAt'] ?? "-",
        updatedAt: json['updatedAt'] ?? "-",
        name: json['name'] ?? "-",
        phone: json['phone'] ?? "-",
        cpfCnpj: json['cpfCnpj'] ?? "-",
        agency: json['agency'] ?? "-",
        account: json['account'] ?? "-",
        bankName: json['bankName'] ?? "-",
        email: json['email'] ?? "-",
        pixType: json['pixType'] ?? "-");
  }

  Map<String, String> toJson() {
    Map<String, String> json = {};
    json['id'] = id.toString();
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['name'] = name;
    json['phone'] = phone;
    json['cpfCnpj'] = cpfCnpj;
    json['agency'] = agency;
    json['account'] = account;
    json['bankName'] = bankName;
    json['email'] = email;
    json['pixType'] = pixType;
    return json;
  }

  static bool canUserEdit(String field) {
    const nonEditableFields = ["createdAt", "updatedAt", "id", "pixType"];
    return !nonEditableFields.contains(field);
  }

  static const bankKeys = ["agency", "account", "bankName", "name"];

  static bool isKeyFavorite(String key, String? pixType) {
    if (pixType == "bank") {
      return bankKeys.contains(key);
    }
    return key == pixType;
  }

  String getTranslatedPixType() {
    switch (pixType) {
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

  String getFavoritePixTitle() {
    switch (pixType) {
      case "email":
        return email;
      case "phone":
        return phone;
      case "cpfCnpj":
        return cpfCnpj;
      case "bank":
        return "$name (conta bancária)";
      default:
        return "-";
    }
  }

  IconData getFavoritePixIcon() {
    switch (pixType) {
      case "email":
        return Icons.email;
      case "phone":
        return Icons.phone;
      case "cpfCnpj":
        return Icons.account_box;
      case "bank":
        return Icons.monetization_on_rounded;
      default:
        return Icons.exposure_minus_1;
    }
  }

  static Input getInputType(String key) {
    switch (key) {
      case "email":
        return Input(hintText: "jozello@hotmail.com", labelText: "E-mail", validator: emailValidator, jsonKey: "email", mask: "X*");
      case "phone":
        return Input(
            hintText: "+55 (31) 99565 0804 ", labelText: "Telefone", validator: phoneValidator, jsonKey: "phone", mask: "\\+55 (99) 99999-9999");
      case "cpfCnpj":
        return Input(
            hintText: "12.345.678/1010-20",
            labelText: "CPF/CNPJ",
            validator: cpfCpnjValidator,
            jsonKey: "cpfCnpj",
            mask: ["999.999.999-99", "99.999.999/9999-99"]);
      case "name":
        return Input(hintText: "Joseísas bom de banco", labelText: "Nome", validator: nameValidator, jsonKey: "name", mask: "X*");
      case "agency":
        return Input(hintText: "1234", labelText: "Agência", validator: agencyValidator, jsonKey: "agency", mask: "9999");
      case "account":
        return Input(
          hintText: "123456789",
          labelText: "Número da conta",
          validator: accountValidator,
          jsonKey: "account",
          mask: "999999999",
        );
      case "bankName":
        return Input(hintText: "Supimpa banco", labelText: "Nome do Banco", validator: bankNameValidator, jsonKey: "bankName", mask: "X*");
      default:
        throw Exception("Chave $key não possuí input associado");
    }
  }
}
