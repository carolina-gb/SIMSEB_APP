import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertest/modules/profile/models/responses/profile_response.dart';
import 'package:fluttertest/modules/sos/models/response/emergency_response.dart';
import 'package:fluttertest/shared/helpers/token_helper.dart';
import 'package:fluttertest/shared/services/http_interceptor.dart';
import 'package:fluttertest/shared/models/general_response.dart';

class UserService {
  final InterceptorHttp _interceptorHttp = InterceptorHttp();

  /// Envía un POST /Emergency devolviendo un [GeneralResponse]<[EmergencyResponse]>.
  ///
  /// - [request]  → el body `{ "typeId": ... }`.
  /// - [context]  → para mostrar loaders/toasts igual que en `LoginService`.
  Future<GeneralResponse<UsersResponse>> getProfile(BuildContext context) async {
    const String url = '/User/get/by-id';

    final userInfo = await TokenHelper.getUserInfoFromToken();
    final userId = userInfo["userId"];
    Map<String, dynamic> queryParameters = {
      'userId': userId // reemplaza con el valor real
    };
    try {
      // 🚀 Dispara la llamada con tu interceptor.
      final GeneralResponse resp = await _interceptorHttp.request(
        context,
        'GET',
        url,
        null,
        queryParameters: queryParameters,
        showLoading: true,
      );

      UsersResponse? userResponse;

      if (!resp.error) {
        // ⚙️ Ajusta según el formato exacto de tu backend.
        // Si tu API envuelve todo en "data", úsalo; si no, usa resp.data directo.
        final dynamic raw = resp.data is Map && resp.data.containsKey('data')
            ? resp.data
            : resp.data;

        userResponse = usersResponseFromJson(jsonEncode(raw));
      }

      return GeneralResponse(
        message: resp.message,
        error: resp.error,
        data: userResponse,
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
