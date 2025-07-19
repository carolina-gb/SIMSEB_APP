import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/profile/controller/profile_form_controller.dart';
import 'package:fluttertest/modules/profile/models/profile_data_model.dart';
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
  ProfileDataModel profileData = ProfileDataModel();
  
  _trygetUser(BuildContext context) async {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    if (controller.profileFormIsNotEmpty()) {
      GeneralResponse profileResponse = await userService.getProfile(context);
      if (!profileResponse.error) {
        profileData = profileResponse.data;
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
    _trygetUser(context); // no necesitas asignar aquí
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.gray1,
                      borderRadius: BorderRadius.circular(size.width),
                    ),
                    child: ClipRRect(
                      child: Image.network(
                        "https://cdn-icons-png.flaticon.com/512/5231/5231019.png",
                        width: size.height * 0.06,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Container(
                  padding: EdgeInsets.only(
                      right: size.width * 0.05,
                      left: size.width * 0.18,
                      top: size.height * 0.02,
                      bottom: size.height * 0.02),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      TextWidget(
                        title: profileData.name!,
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.normal,
                      ),
                      TextWidget(
                        title: "Miembro desde: ",
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.normal,
                      ),
                      TextWidget(
                        title: "Julio 2025",
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const TitleWidget(
            title: "Información Personal",
            fontWeight: FontWeight.bold,
          ),
          Form(
            key: controller.profileFormController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.02),
                  child: const TextWidget(title: "Nombres Completos"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.01),
                  child: TextFormFieldWidget(
                    hintText: 'Nombres completos',
                    fontSize: null,
                    fontWeightHintText: FontWeight.w500,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    controller: controller.nameController,
                    fillColor: AppTheme.gray2,
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
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.02),
                  child: TextWidget(title: "Dirección"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.01),
                  child: TextFormFieldWidget(
                    hintText: 'Dirección',
                    fontSize: null,
                    fontWeightHintText: FontWeight.w500,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    controller: controller.directionController,
                    fillColor: AppTheme.gray2,
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
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.02),
                  child: TextWidget(title: "Correo"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.01),
                  child: TextFormFieldWidget(
                    hintText: 'Correo',
                    fontSize: null,
                    fontWeightHintText: FontWeight.w500,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    controller: controller.correoController,
                    fillColor: AppTheme.gray2,
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
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.02),
                  child: TextWidget(title: "Contraseña"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.01),
                  child: TextFormFieldWidget(
                    hintText: 'Contraseña',
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
                ),
                // SizedBox(height: size.height * 0.05),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: size.width * 0.07),
                    child: FilledButtonWidget(
                        color: AppTheme.primaryMedium,
                        width: size.width * 0.3,
                        text: 'Guardar',
                        onPressed: () {
                          // _tryLogin(fp);
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
