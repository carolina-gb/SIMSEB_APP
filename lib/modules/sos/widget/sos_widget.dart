import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/sos/controller/sos_controller.dart';
import 'package:fluttertest/modules/sos/models/request/emergency_request.dart';
import 'package:fluttertest/modules/sos/models/response/emergency_response.dart';
import 'package:fluttertest/modules/sos/services/sos_service.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/models/general_response.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/alert_template.dart';
import 'package:fluttertest/shared/widgets/combo_widget.dart';
import 'package:fluttertest/shared/widgets/filled_button.dart';
import 'package:fluttertest/shared/widgets/text.dart';
import 'package:fluttertest/shared/widgets/title.dart';
import 'package:provider/provider.dart';

class SosWidget extends StatefulWidget {
  const SosWidget({super.key});

  @override
  State<SosWidget> createState() => _SosWidgetState();
}

class _SosWidgetState extends State<SosWidget> {
  SosController controller = SosController();
  Future<void> _tryCreateEmergency() async {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    // 1. Verifica que haya un tipo seleccionado (puedes adaptar la lógica).
    if (controller.typeId != null) {
      final emergencySvc = EmergencyService();

      // 2. Arma el request.
      final request =
          EmergencyRequest(typeId: int.parse(controller.typeId.text));

      // 3. Dispara el servicio.
      final GeneralResponse<EmergencyResponse> resp =
          await emergencySvc.createEmergency(context, request);

      // 4. Si salió bien…
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

        // Guarda datos útiles en tu provider ― opcional.
        // fp.setEmergencyId(resp.data!.emergencyId);
        // fp.setEmergencyCreatedAt(resp.data!.createdAt);

        // Navega a la página de detalle (ajusta la ruta a tu gusto).
        // ignore: use_build_context_synchronously
      } else {
        // 5. Falló la llamada: alerta al usuario.
        _showEmergencyError(fp,
            title: 'Ups, ocurrió un problema',
            message: resp.message ??
                'No pudimos crear tu emergencia. Intenta de nuevo.');
      }
    } else {
      // No se seleccionó typeId.
      _showEmergencyError(fp,
          title: 'Tipo de emergencia vacío',
          message: 'Selecciona un tipo antes de continuar.');
    }
  }

  /// Muestra un alert genérico usando tu FunctionalProvider.
  void _showEmergencyError(
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

  final Map<String, int> _emergencyOptions = {
    'Seleccione…': 0, // opcional, para placeholder
    'Robo': 1,
    'Incendio': 2,
    'Pelea': 3,
  };
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.1, bottom: size.height * 0.08),
          child: Image.asset(AppTheme.sosPath),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02,
            horizontal: size.width * 0.17,
          ),
          child: const TitleWidget(
            title: "Comunicandose con las autoridades",
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppTheme.white,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02,
            horizontal: size.width * 0.17,
          ),
          child: const TextWidget(
            title:
                "Mantén la calma. La policía ya está en camino. Por favor, permanece tranquilo(a) y seguro(a) hasta que lleguen.",
            color: AppTheme.white,
            fontWeight: FontWeight.normal,
            fontSize: 18,
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: ComboBoxWidget(
            dropdownBackgroundColor: AppTheme.gray1,
            width: size.height * 0.3,
            items: _emergencyOptions.keys.toList(),
            onChanged: (value) {
              if (value == null || value == 'Seleccione…') {
                controller.typeId.clear(); // vacía si no eligió
                return;
              }
              final id = _emergencyOptions[value]!; // 1, 2 o 3
              controller.typeId.text = id.toString();
            },
            selectedValue: 'Seleccione…',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01,
                ),
                child: FilledButtonWidget(
                  text: "Enviar",
                  color: AppTheme.gray3,
                  width: size.width * 0.02,
                  onPressed: () async {
                    await _tryCreateEmergency();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                ),
                child: FilledButtonWidget(
                  text: "Cancelar",
                  color: AppTheme.gray3,
                  width: size.width * 0.02,
                  onPressed: () {
                    fp.clearAllPages();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
