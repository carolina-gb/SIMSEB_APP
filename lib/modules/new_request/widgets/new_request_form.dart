import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/widgets/combo_widget.dart';
import 'package:fluttertest/shared/widgets/file_picker_widget.dart';
import 'package:fluttertest/shared/widgets/filled_button.dart';
import 'package:fluttertest/shared/widgets/text_area.dart';
import 'package:fluttertest/shared/widgets/text_form_field_widget.dart';
import 'package:fluttertest/shared/widgets/title.dart';

class NewRequestFormWidget extends StatefulWidget {
  const NewRequestFormWidget({super.key});

  @override
  State<NewRequestFormWidget> createState() => _NewRequestFormWidgetState();
}

class _NewRequestFormWidgetState extends State<NewRequestFormWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02, horizontal: size.width * 0.05),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: Row(
                children: [
                  Icon(Icons.feed_outlined, size: 35),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  TitleWidget(
                    title: 'Crear tu solicitud',
                    fontSize: size.height * 0.03,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.black,
                  ),
                ],
              ),
            ),
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
              child: TextFormFieldWidget( colorBorder: AppTheme.black,),
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
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       FilledButtonWidget(
            //         text: 'Regresar',
            //         width: size.width * 0.03,
            //         color: AppTheme.primaryMedium,
            //         onPressed: () {
            //           GlobalHelper.navigateToPageRemove(context, '/home');
            //         },
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(left: size.width * 0.1),
            //         child: FilledButtonWidget(
            //           text: 'Enviar  ',
            //           width: size.width * 0.03,
            //           color: AppTheme.primaryMedium,
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
