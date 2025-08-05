import 'package:flutter/material.dart';

class ProfileFormController {

  final profileFormController = GlobalKey<FormState>();
  bool showPassWord = false;
  bool showNewPassWord = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController identificationController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();


  bool profileFormIsNotEmpty() {
    return nameController.text.trim().isNotEmpty &&
        identificationController.text.trim().isNotEmpty &&
        correoController.text.trim().isNotEmpty;
  }
}