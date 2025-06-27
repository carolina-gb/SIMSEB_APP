import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/alert_template.dart';
import 'package:fluttertest/shared/widgets/combo_widget.dart';
import 'package:fluttertest/shared/widgets/file_picker_widget.dart';
import 'package:fluttertest/shared/widgets/filled_button.dart';
import 'package:fluttertest/shared/widgets/text_area.dart';
import 'package:fluttertest/shared/widgets/text_form_field_widget.dart';
import 'package:fluttertest/shared/widgets/title.dart';
import 'package:provider/provider.dart';

class NewRequestFormWidget extends StatefulWidget {
  const NewRequestFormWidget({super.key, required this.globalKey});
  final GlobalKey globalKey;
  @override
  State<NewRequestFormWidget> createState() => _NewRequestFormWidgetState();
}

class _NewRequestFormWidgetState extends State<NewRequestFormWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(
            title: 'Seleccione el tipo de denuncia a realizar:',
            fontSize: size.width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: ComboBoxWidget(
              items: const [
                'Seleccione',
                'Desaseo',
                'Pelea',
              ],
              onChanged: (value) {
                print('hola');
              },
              selectedValue: 'Seleccione',
              hintText: 'Seleccione un tipo de Denuncia',
            ),
          ),
          TitleWidget(
            title: 'Escribe aqui tu denuncia',
            fontSize: size.width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: const TextAreaWidget(
              hintText: 'Escribe aqui tu denuncia',
            ),
          ),
          TitleWidget(
            title: 'Fecha del incidente',
            fontSize: size.width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: TextFormFieldWidget(
              colorBorder: AppTheme.black,
            ),
          ),
          TitleWidget(
            title: 'Agregar foto como evidencia',
            fontSize: size.width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: Center(
              child: ImagePickerWithPermissions(
                onImageSelected: (File? image) {
                  if (image != null) {
                    // Aquí puedes subir la imagen a tu backend
                    print('Imagen seleccionada: ${image.path}');
                  }
                },
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: FilledButtonWidget(
                text: 'Enviar Solicitud',
                width: size.width * 0.05,
                color: AppTheme.primaryMedium,
                onPressed: () {
                  final keylogin = GlobalHelper.genKey();
                  fp.showAlert(
                      key: keylogin,
                      content: AlertGeneric(
                        content: SuccessInformation(
                            keyToClose: keylogin,
                            message: 'Se ha enviado la solicitud'),
                      ));
                }),
          ),
          SizedBox(
            height: size.height * 0.1,
          )
        ],
      ),
    );
  }
}
