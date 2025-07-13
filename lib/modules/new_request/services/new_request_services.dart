import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertest/modules/new_request/models/request/new_request.dart';
import 'package:fluttertest/modules/new_request/models/response/new_request.response.dart';
import 'package:http/http.dart' as http; // 👈 paquete http
import 'package:fluttertest/shared/services/http_interceptor.dart';
import 'package:fluttertest/shared/models/general_response.dart';

class NewRequestService {
  final InterceptorHttp _interceptorHttp = InterceptorHttp();

  /// Envía un POST /Emergency devolviendo un [GeneralResponse]<[ReportResponse]>.
  ///
  /// - [request]  → el body `{ "typeId": ... }`.
  /// - [context]  → para mostrar loaders/toasts igual que en `LoginService`.
  Future<GeneralResponse<ReportResponse>> createNewReport(
    BuildContext context,
    EvidenceRequest req,
  ) async {
    try {
      final filePart = await http.MultipartFile.fromPath(
        'EvidenceFile', // ← nombre exacto
        req.evidenceFile.path,
      );

      final fields = {
        'Description': req.description,
        'TypeId': req.typeId.toString(),
      };

      final resp = await _interceptorHttp.request(
        context,
        'POST',
        '/Report',
        null, // body = null porque es multipart
        requestType: 'FORM', // ⚠️ clave
        multipartFiles: [filePart],
        multipartFields: fields,
        showLoading: true,
      );

      ReportResponse? newReportResponse;

      if (!resp.error) {
        // ⚙️ Ajusta según el formato exacto de tu backend.
        // Si tu API envuelve todo en "data", úsalo; si no, usa resp.data directo.
        final dynamic raw = resp.data is Map && resp.data.containsKey('data')
            ? resp.data['data']
            : resp.data;

        newReportResponse = reportResponseFromJson(jsonEncode(raw));
      }

      return GeneralResponse(
        message: resp.message,
        error: resp.error,
        data: newReportResponse,
      );
    } catch (e, stacktrace) {
      // Log simple; puedes cambiar a GlobalHelper.logger.e si lo prefieres.
      debugPrint('❌ Error al crear emergencia: $e');
      debugPrint('📍 Stacktrace: $stacktrace');

      return GeneralResponse(
        message: 'Error al crear la Denuncia',
        error: true,
      );
    }
  }
}
