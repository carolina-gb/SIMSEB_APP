import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/new_request/controller/new_request_controller.dart';
import 'package:fluttertest/modules/new_request/models/request/new_request.dart';
import 'package:fluttertest/modules/new_request/models/response/new_request.response.dart';
import 'package:fluttertest/modules/new_request/services/new_request_services.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/models/general_response.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/alert_template.dart';
import 'package:fluttertest/shared/widgets/combo_widget.dart';
import 'package:fluttertest/shared/widgets/file_picker_widget.dart';
import 'package:fluttertest/shared/widgets/filled_button.dart';
import 'package:fluttertest/shared/widgets/text_area.dart';
import 'package:fluttertest/shared/widgets/title.dart';
import 'package:provider/provider.dart';

class NewRequestFormWidget extends StatefulWidget {
  const NewRequestFormWidget({super.key, required this.globalKey});
  final GlobalKey globalKey;
  @override
  State<NewRequestFormWidget> createState() => _NewRequestFormWidgetState();
}

class _NewRequestFormWidgetState extends State<NewRequestFormWidget> {
  NewRequestController controller = NewRequestController();
  Future<void> _tryCreateReport() async {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    // 1️⃣ Validar formulario y campos obligatorios
    if (!controller.isComplete) {
      _showWarning(
        fp,
        title: 'Campos incompletos',
        message:
            'Completa todos los campos y adjunta la foto antes de continuar.',
      );
      return;
    }

    // 2️⃣ Construir EvidenceRequest
    // final bytes = await controller.evidenceFile!.readAsBytes();
    // final base64Img = base64Encode(bytes);
    final file = controller.evidenceFile!;
    final req = EvidenceRequest(
      evidenceFile: file,
      description: controller.descriptionCtrl.text.trim(),
      typeId: int.parse(controller.typeIdCtrl.text),
    );

    // 3️⃣ Consumir servicio
    final newRequestSvc = NewRequestService();
    final GeneralResponse<ReportResponse> resp =
        await newRequestSvc.createNewReport(
      context,
      req,
    );

    // 4️⃣ Manejo de la respuesta
    if (!resp.error && resp.data != null) {
      final key = GlobalHelper.genKey();
      fp.showAlert(
        key: key,
        content: AlertGeneric(
          content: SuccessInformation(
            keyToClose: key,
            message: resp.message,
            onPressed: () {
              fp.clearAllAlert();
              fp.clearAllPages();
            },
          ),
        ),
      );
    } else {
      _showWarning(
        fp,
        title: 'Error al enviar',
        message: resp.message ??
            'No se pudo crear la solicitud. Inténtalo nuevamente.',
      );
    }
  }

  /// Alerta reutilizable con tu FunctionalProvider
  void _showWarning(
    FunctionalProvider fp, {
    required String title,
    required String message,
  }) {
    final key = GlobalHelper.genKey();
    fp.showAlert(
      key: key,
      content: AlertGeneric(
        content: WarningAlert(
          keyToClose: key,
          title: title,
          message: message,
        ),
      ),
    );
  }

  final Map<String, int> _reportsOptions = {
    'Seleccione…': 0, // opcional, para placeholder
    'Ruido': 1,
    'Suciedad': 2,
  };

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
              items: _reportsOptions.keys.toList(),
              onChanged: (value) {
                if (value == null || value == 'Seleccione…') {
                  controller.typeIdCtrl.clear(); // vacía si no eligió
                  return;
                }
                final id = _reportsOptions[value]!; // 1, 2 o 3
                controller.typeIdCtrl.text = id.toString();
              },
              selectedValue: 'Seleccione…',
              hintText: 'Seleccione un tipo de Denuncia',
            ),
          ),
          TitleWidget(
            title: 'Escribe aqui tu denuncia',
            fontSize: size.width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: TextAreaWidget(
              hintText: 'Escribe aqui tu denuncia',
              onChanged: (value) {
                controller.descriptionCtrl.text = value;
              },
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
                    controller.evidenceFile = image;
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
                onPressed: () async {
                  await _tryCreateReport();
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
