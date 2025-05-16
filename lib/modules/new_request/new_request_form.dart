import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/widgets/combo_widget.dart';
import 'package:fluttertest/shared/widgets/file_picker_widget.dart';
import 'package:fluttertest/shared/widgets/filled_button.dart';
import 'package:fluttertest/shared/widgets/text_area.dart';
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
    return Stack(children: [
      Container(
        // color: AppTheme.naturalsMedium,
        height: size.height * 0.095,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            color: AppTheme.positive),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TitleWidget(
                title: 'Nuevo Reclamo',
                fontSize: size.height * 0.04,
                fontWeight: FontWeight.w500,
                color: AppTheme.black,
              ),
            ),
            TitleWidget(
              title: 'Seleccione el tipo de denuncia a realizar',
              fontSize: size.width * 0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
              child: ComboBoxWidget(
                items: const ['hola', 'Desaseo', 'Pelea'],
                onChanged: (value) {
                  print('hola');
                },
                selectedValue: 'hola',
                hintText: 'Seleccione un tipo de Denuncia',
              ),
            ),
            TitleWidget(
              title: 'Ingrese el detalle de su denuncia',
              fontSize: size.width * 0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: const TextAreaWidget(
                hintText: 'Ingrese el detalle de su denuncia',
              ),
            ),
            TitleWidget(
              title: 'Seleccione una imagen como evidencia',
              fontSize: size.width * 0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: ImagePickerWithPermissions(
                onImageSelected: (File? image) {
                  if (image != null) {
                    // Aquí puedes subir la imagen a tu backend
                    print('Imagen seleccionada: ${image.path}');
                  }
                },
                size: 150, // Tamaño opcional
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButtonWidget(
                    text: 'Regresar',
                    width: size.width * 0.03,
                    color: AppTheme.error,
                    onPressed: () {
                      GlobalHelper.navigateToPageRemove(context, '/home');
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.1),
                    child: FilledButtonWidget(
                      text: 'Enviar  ',
                      width: size.width * 0.03,
                      color: AppTheme.positiveMedium,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    ]);
  }
}
