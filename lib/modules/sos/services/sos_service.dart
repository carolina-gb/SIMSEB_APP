import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertest/modules/sos/models/request/emergency_request.dart';
import 'package:fluttertest/modules/sos/models/response/emergency_response.dart';

import 'package:fluttertest/shared/services/http_interceptor.dart';
import 'package:fluttertest/shared/models/general_response.dart';

class EmergencyService {
  final InterceptorHttp _interceptorHttp = InterceptorHttp();

  /// Envía un POST /Emergency devolviendo un [GeneralResponse]<[EmergencyResponse]>.
  ///
  /// - [request]  → el body `{ "typeId": ... }`.
  /// - [context]  → para mostrar loaders/toasts igual que en `LoginService`.
  Future<GeneralResponse<EmergencyResponse>> createEmergency(
      BuildContext context, EmergencyRequest request) async {
    const String url = '/Emergency';

    try {
      // 🚀 Dispara la llamada con tu interceptor.
      final GeneralResponse resp = await _interceptorHttp.request(
        context,
        'POST',
        url,
        request,
        showLoading: true,
      );

      EmergencyResponse? emergencyResponse;

      if (!resp.error) {
        // ⚙️ Ajusta según el formato exacto de tu backend.
        // Si tu API envuelve todo en "data", úsalo; si no, usa resp.data directo.
        final dynamic raw = resp.data is Map && resp.data.containsKey('data')
            ? resp.data['data']
            : resp.data;

        emergencyResponse = emergencyResponseFromJson(jsonEncode(raw));
      }

      return GeneralResponse(
        message: resp.message,
        error: resp.error,
        data: emergencyResponse,
      );
    } catch (e, stacktrace) {
      // Log simple; puedes cambiar a GlobalHelper.logger.e si lo prefieres.
      debugPrint('❌ Error al crear emergencia: $e');
      debugPrint('📍 Stacktrace: $stacktrace');

      return GeneralResponse(
        message: 'Error al crear la emergencia',
        error: true,
      );
    }
  }
}
