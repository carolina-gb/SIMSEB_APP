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
import 'package:fluttertest/shared/widgets/title.dart';
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
      controller.nameController.text = profileResponse.data.data[0].fullName ?? '';
      // controller.directionController.text = profileResponse.data.data[0].direccion ?? '';
      controller.correoController.text = profileResponse.data.data[0].email ?? '';
      controller.passwordController.text = profileResponse.data.data[0].password ?? ''; // solo si es necesario
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
            _buildLabel(size, "Nombres Completos"),
            _buildTextField(
              controller.nameController,
              'Nombres completos',
              TextInputType.name,
            ),
            _buildLabel(size, "Dirección"),
            _buildTextField(
              controller.directionController,
              'Dirección',
              TextInputType.streetAddress,
            ),
            _buildLabel(size, "Correo"),
            _buildTextField(
              controller.correoController,
              'Correo',
              TextInputType.emailAddress,
            ),
            _buildLabel(size, "Contraseña"),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.01),
              child: TextFormFieldWidget(
                hintText: 'Contraseña',
                fontSize: null,
                fillColor: AppTheme.gray2,
                fontWeightHintText: FontWeight.w500,
                obscureText: controller.showPassWord,
                keyboardType: TextInputType.visiblePassword,
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
                  child: Icon(
                    controller.showPassWord
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'El campo no puede estar vacío';
                  return null;
                },
              ),
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
                    if (controller.profileFormController.currentState!.validate()) {
                      // Aquí puedes guardar
                      print('Todo validado loco!');
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

  Padding _buildLabel(Size size, String title) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: TextWidget(title: title),
    );
  }

  Padding _buildTextField(
    TextEditingController controller,
    String hintText,
    TextInputType type,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormFieldWidget(
        hintText: hintText,
        fontSize: null,
        fontWeightHintText: FontWeight.w500,
        keyboardType: type,
        textInputAction: TextInputAction.next,
        controller: controller,
        fillColor: AppTheme.gray2,
        inputFormatters: [
          TextInputFormatter.withFunction((oldValue, newValue) {
            return newValue.copyWith(
              text: newValue.text.toLowerCase(),
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
