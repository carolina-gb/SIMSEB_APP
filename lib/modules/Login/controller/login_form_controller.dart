import 'package:flutter/material.dart';

class LoginFormController {

  bool showPassWord = true;

  final formLoginController = GlobalKey<FormState>();

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loginFormIsNotEmpty() {
    return userController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty;
  }


}