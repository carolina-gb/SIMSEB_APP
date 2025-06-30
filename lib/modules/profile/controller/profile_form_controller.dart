import 'package:flutter/material.dart';

class ProfileFormController {

  final profileFormController = GlobalKey<FormState>();
  bool showPassWord = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController directionController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  bool profileFormIsNotEmpty() {
    return nameController.text.trim().isNotEmpty &&
        directionController.text.trim().isNotEmpty &&
        correoController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty;
  }
}