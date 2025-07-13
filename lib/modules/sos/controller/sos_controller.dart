import 'package:flutter/material.dart';

class SosController {

  final sosController = GlobalKey<FormState>();

  TextEditingController typeId = TextEditingController();

  bool loginFormIsNotEmpty() {
    return typeId.text.trim().isNotEmpty;
  }
}