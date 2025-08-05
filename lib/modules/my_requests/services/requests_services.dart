import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertest/modules/my_requests/models/responses/requests_response.dart';
import 'package:fluttertest/shared/services/http_interceptor.dart';
import 'package:fluttertest/shared/models/general_response.dart';

class RequestsService {
  final InterceptorHttp _interceptorHttp = InterceptorHttp();
  Future<GeneralResponse<ReportsResponse>> getAll(BuildContext context) async {
    const String url = '/Report/all';

    try {
      // 🚀 Dispara la llamada con tu interceptor.
      final GeneralResponse resp = await _interceptorHttp.request(
        context,
        'GET',
        url,
        null,
        queryParameters: {
          'skip': "0", // 👈 aquí el parámetro
        },
        showLoading: true,
      );

      ReportsResponse? requestsResponse;

      if (!resp.error) {
        // ⚙️ Ajusta según el formato exacto de tu backend.
        // Si tu API envuelve todo en "data", úsalo; si no, usa resp.data directo.
        final dynamic raw = resp.data is Map && resp.data.containsKey('data')
            ? resp.data
            : resp.data;

        requestsResponse = reportsResponseFromJson(jsonEncode(raw));
      }

      return GeneralResponse(
        message: resp.message,
        error: resp.error,
        data: requestsResponse,
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
