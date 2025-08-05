import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/profile/controller/profile_form_controller.dart';
import 'package:fluttertest/modules/profile/models/profile_data_model.dart';
import 'package:fluttertest/modules/profile/models/responses/profile_response.dart';
import 'package:fluttertest/modules/profile/services/profile_services.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/models/general_response.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/alert_template.dart';
import 'package:fluttertest/shared/widgets/filled_button.dart';
import 'package:fluttertest/shared/widgets/text.dart';
import 'package:fluttertest/shared/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';

class ProfileFormWidget extends StatefulWidget {
  const ProfileFormWidget({super.key});

  @override
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  ProfileFormController controller = ProfileFormController();
  UserService userService = UserService();
  late FunctionalProvider fp;

  Future<void> _trygetUser() async {
    GeneralResponse profileResponse = await userService.getProfile(context);
    if (!profileResponse.error) {
      // Setear todos los controladores
      controller.nameController.text =
          profileResponse.data.data[0].fullName ?? '';
      controller.identificationController.text =
          profileResponse.data.data[0].identification ?? '';
      controller.correoController.text =
          profileResponse.data.data[0].email ?? '';
    }

    if (!controller.profileFormIsNotEmpty()) {
      final keylogin = GlobalHelper.genKey();
      fp.showAlert(
        key: keylogin,
        content: AlertGeneric(
          content: WarningAlert(
            keyToClose: keylogin,
            title: 'Campos Incompletos',
            message:
                'No puedes dejar campos vacíos. Por favor, llena todos los campos para acceder.',
          ),
        ),
      );
    }
  }

  Future<void> _tryChangePassword() async {
    final password = controller.passwordController.text;
    final confirmPassword = controller.newPasswordController.text;
    if (password.isEmpty || confirmPassword.isEmpty) {
      final keylogin = GlobalHelper.genKey();
      fp.showAlert(
        key: keylogin,
        content: AlertGeneric(
          content: WarningAlert(
            keyToClose: keylogin,
            title: 'Campos Incompletos',
            message:
                'No puedes dejar campos vacíos. Por favor, llena todos los campos para acceder.',
          ),
        ),
      );
    } else if (password == confirmPassword) {
      final keylogin = GlobalHelper.genKey();
      fp.showAlert(
        key: keylogin,
        content: AlertGeneric(
          content: WarningAlert(
            keyToClose: keylogin,
            title: 'Campos repetidos',
            message: 'Por favor, ingresa una contraseña nueva.',
          ),
        ),
      );
    } else {
      GeneralResponse response = await userService.changePassword(
          context,
          controller.passwordController.text,
          controller.newPasswordController.text);
      if (!response.error) {
        final keylogin = GlobalHelper.genKey();
        fp.showAlert(
          key: keylogin,
          content: AlertGeneric(
            content: SuccessInformation(
              keyToClose: keylogin,
              message: response.message,
            ),
          ),
        );
        controller.passwordController.clear();
        controller.newPasswordController.clear();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fp = Provider.of<FunctionalProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => _trygetUser());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Form(
        key: controller.profileFormController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(size: size, title: "Nombres Completos"),
            _buildTextField(controller.nameController, 'Nombres completos',
                TextInputType.name, false),
            _buildLabel(size: size, title: "Identificación"),
            _buildTextField(controller.identificationController,
                'Identificación', TextInputType.number, false),
            _buildLabel(size: size, title: "Correo"),
            _buildTextField(controller.correoController, 'Correo',
                TextInputType.emailAddress, false),
            _buildLabel(
                size: size * 2, title: "Cambiar Contraseña", fontSize: 24),
            _buildLabel(size: size, title: "Contraseña Actual"),
            TextFormFieldWidget(
              hintText: 'Ingrese su contraseña actual',
              fontSize: null,
              fillColor: AppTheme.gray2,
              fontWeightHintText: FontWeight.w500,
              obscureText: controller.showPassWord,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              controller: controller.passwordController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r"\s")),
              ],
              suffixIcon: TextButton(
                  onPressed: () {
                    setState(() {
                      controller.showPassWord = !controller.showPassWord;
                    });
                  },
                  child: controller.showPassWord
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'El campo no puede estar vacio';
                }
                return null;
              },
            ),
            _buildLabel(size: size, title: "Contraseña Nueva"),
            TextFormFieldWidget(
              hintText: 'Ingrese su nueva contraseña',
              fontSize: null,
              fillColor: AppTheme.gray2,
              fontWeightHintText: FontWeight.w500,
              obscureText: controller.showNewPassWord,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              controller: controller.newPasswordController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r"\s")),
              ],
              suffixIcon: TextButton(
                  onPressed: () {
                    setState(() {
                      controller.showNewPassWord = !controller.showNewPassWord;
                    });
                  },
                  child: controller.showNewPassWord
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off)),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'El campo no puede estar vacío';
                }

                final trimmed = value.trim();

                if (trimmed.length < 8) {
                  return 'Debe tener al menos 8 caracteres';
                }

                if (!RegExp(r'[A-Z]').hasMatch(trimmed)) {
                  return 'Debe contener al menos una letra mayúscula';
                }

                if (!RegExp(r'[0-9]').hasMatch(trimmed)) {
                  return 'Debe contener al menos un número';
                }

                if (!RegExp(r'[!@#\$&*~%^(),.?":{}|<>]').hasMatch(trimmed)) {
                  return 'Debe contener al menos un caracter especial';
                }
                return null;
              },
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.width * 0.07),
                child: FilledButtonWidget(
                  color: AppTheme.primaryMedium,
                  width: size.width * 0.3,
                  text: 'Guardar',
                  onPressed: () {
                    if (controller.profileFormController.currentState!
                        .validate()) {
                      _tryChangePassword();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildLabel(
      {required Size size, required String title, double? fontSize = 14}) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: TextWidget(
        title: title,
        fontSize: fontSize,
      ),
    );
  }

  Padding _buildTextField(TextEditingController controller, String hintText,
      TextInputType type, bool isEditable) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormFieldWidget(
        hintText: hintText,
        fontSize: null,
        fontWeightHintText: FontWeight.w500,
        keyboardType: type,
        enabled: isEditable,
        textInputAction: TextInputAction.next,
        controller: controller,
        fillColor: AppTheme.gray2,
        inputFormatters: [
          TextInputFormatter.withFunction((oldValue, newValue) {
            return newValue.copyWith(
              text: newValue.text,
            );
          }),
        ],
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'El campo no puede estar vacío';
          }
          return null;
        },
      ),
    );
  }
}
