import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertest/modules/profile/models/responses/profile_response.dart';
import 'package:fluttertest/modules/sos/models/response/emergency_response.dart';
import 'package:fluttertest/shared/helpers/token_helper.dart';
import 'package:fluttertest/shared/services/http_interceptor.dart';
import 'package:fluttertest/shared/models/general_response.dart';

class UserService {
  final InterceptorHttp _interceptorHttp = InterceptorHttp();
  Future<GeneralResponse<UsersResponse>> getProfile(
      BuildContext context) async {
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

  Future<GeneralResponse<UsersResponse>> changePassword(
      BuildContext context, String oldPassword, String newPassword) async {
    const String url = '/UserManagement/change-password';

    Map<String, dynamic> body = {
      'currentPassword': oldPassword,
      'newPassword': newPassword
    };

    try {
      final GeneralResponse resp = await _interceptorHttp.request(
        context,
        'POST',
        url,
        body,
        showLoading: true,
      );

      if (!resp.error) {
        return GeneralResponse(
        message: resp.message,
        error: resp.error,
        data: null,
      );
      }

      return GeneralResponse(
        message: resp.message,
        error: resp.error,
        data: null,
      );
    } catch (e, stacktrace) {
      // Log simple; puedes cambiar a GlobalHelper.logger.e si lo prefieres.
      debugPrint('❌ Error al cambiar la contraseña: $e');
      debugPrint('📍 Stacktrace: $stacktrace');

      return GeneralResponse(
        message: 'Error al cambiar la contraseña',
        error: true,
      );
    }
  }
}
