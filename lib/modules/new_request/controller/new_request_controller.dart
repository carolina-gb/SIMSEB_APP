import 'dart:io';
import 'package:flutter/material.dart';

/// Controller para el formulario “Nueva Solicitud / Evidencia”.
class NewRequestController with ChangeNotifier {
  /// Llave del `Form` para validar.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Texto libre que describe la emergencia / evidencia.
  final TextEditingController descriptionCtrl = TextEditingController();

  /// Id del tipo (1, 2, 3…).  ➜  Se lo pones con tu ComboBox.
  final TextEditingController typeIdCtrl = TextEditingController();

  /// Foto o imagen adjunta.
  File? evidenceFile;

  // ────────────────────── Helpers ────────────────────── //

  /// Indica si todos los campos requeridos están completos.
  bool get isComplete {
    return evidenceFile != null &&
        descriptionCtrl.text.trim().isNotEmpty &&
        typeIdCtrl.text.trim().isNotEmpty;
  }

  /// Guarda el archivo y notifica a los listeners (útil para pre-preview).
  void setEvidence(File file) {
    evidenceFile = file;
    notifyListeners();
  }

  /// Resetea el formulario.
  void clear() {
    descriptionCtrl.clear();
    typeIdCtrl.clear();
    evidenceFile = null;
    notifyListeners();
  }

  /// Limpieza cuando se destruya el widget que use este controller.
  void disposeControllers() {
    descriptionCtrl.dispose();
    typeIdCtrl.dispose();
  }
}
