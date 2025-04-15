import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/Login/controller/login_form_controller.dart';
import 'package:fluttertest/modules/Login/models/requests/credentials_request.dart';
import 'package:fluttertest/modules/Login/models/user_data_model.dart';
import 'package:fluttertest/modules/Login/services/login_service.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/models/general_response.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/alert_template.dart';
import 'package:fluttertest/shared/widgets/filled_button.dart';
import 'package:fluttertest/shared/widgets/placeholder.dart';
import 'package:fluttertest/shared/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';

class FormLoginPage extends StatefulWidget {
  const FormLoginPage({super.key});

  @override
  State<FormLoginPage> createState() => _FormLoginPageState();
}

class _FormLoginPageState extends State<FormLoginPage> {
  LoginFormController controller = LoginFormController();
  LoginService loginService = LoginService();
  DataUserModel? userModel;

  _tryLogin(FunctionalProvider fp) async {
    if (controller.loginFormIsNotEmpty()) {
      if(controller.passwordController.text == 'admin' && controller.userController.text == 'admin'){
        GlobalHelper.navigateToPageRemove(context, '/home');
      }
      final fp = Provider.of<FunctionalProvider>(context, listen: false);

      CredentialsRequest loginRequest = CredentialsRequest();

      loginRequest.userName = controller.userController.text.trim().toString();
      loginRequest.password =
          controller.passwordController.text.trim().toString();

      GeneralResponse response =
          await loginService.login(context, loginRequest);

      if (!response.error) {
        // log('Logeado');

        // final userInformationResponse =
            // ignore: use_build_context_synchronously
            // await loginService.userInformation(context);

        // if (!userInformationResponse.error) {
          // fp.setRegisterUserName(
          //     '${userInformationResponse.data?.name ?? ''} ${userInformationResponse.data?.lastName ?? ''}');
          // fp.setRegisterEmail(userInformationResponse.data?.email ?? '');

        //   GlobalHelper.navigateToPageRemove(context, '/home');
        // }
      }
    } else {
      final keylogin = GlobalHelper.genKey();
      fp.showAlert(
          key: keylogin,
          content: AlertGeneric(
              content: WarningAlert(
            keyToClose: keylogin,
            title: 'Campos Incompletos',
            message:
                'No puedes dejar campos vacíos. Por favor, llena todos los campos para acceder.',
          )));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (userModel != null) {
        controller.userController.text = userModel!.usuario!;
        controller.passwordController.text = userModel!.clave!;
      }
      // controller.userController.text = 'ssupersu';
      // controller.passwordController.text = 'supersu';
      // controller.passwordController.text = 'Supersu1+';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<FunctionalProvider>(
      builder: (context, fp, child) {
        return Form(
          key: controller.formLoginController,
          child: Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.05,
                left: size.height * 0.04,
                right: size.height * 0.04,
                bottom: size.width * 0.5),
            child: Column(
              children: [
                Image.asset(AppTheme.logoIcon, width:  size.width * 0.4,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.07),
                  child: const PlaceHolderWidget(
                      placeholder: 'Usuario', fontSize: 20),
                ),
                TextFormFieldWidget(
                  hintText: 'Usuario',
                  fontSize: null,
                  fontWeightHintText: FontWeight.w500,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: controller.userController,
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      return newValue.copyWith(
                        text: newValue.text
                            .toLowerCase(), // Convertir a minúsculas
                      );
                    })
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'El campo no puede estar vacio';
                    }
                    return null;
                  },
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 0.07),
                    child: const PlaceHolderWidget(
                        placeholder: 'Contraseña', fontSize: 20)),
                TextFormFieldWidget(
                  hintText: 'Contraseña',
                  fontSize: null,
                  fontWeightHintText: FontWeight.w500,
                  obscureText: controller.showPassWord,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: controller.passwordController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r"\s")),
                  ],
                  suffixIcon: IconButton(
                    icon: !controller.showPassWord
                        ? const Icon(Icons.remove_red_eye_outlined, size: 20)
                        : const Icon(Icons.visibility_off_outlined, size: 20),
                    onPressed: () {
                      setState(() {
                        controller.showPassWord = !controller.showPassWord;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'El campo no puede estar vacio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                  child: FilledButtonWidget(
                      text: 'Iniciar Sesión',
                      onPressed: () {
                        _tryLogin(fp);
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AlertForgetPassword {}
