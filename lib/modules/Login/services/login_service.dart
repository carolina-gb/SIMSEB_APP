import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertest/modules/Login/models/requests/credentials_request.dart';
import 'package:fluttertest/modules/Login/models/responses/login_response.dart';
import 'package:fluttertest/modules/Login/models/responses/user_information_response.dart';
import 'package:fluttertest/shared/helpers/security_storage.dart';
import 'package:fluttertest/shared/helpers/token_helper.dart';
import 'package:fluttertest/shared/models/general_response.dart';
import 'package:fluttertest/shared/services/http_interceptor.dart';

class LoginService {
  InterceptorHttp interceptorHttp = InterceptorHttp();

  Future login(BuildContext context, CredentialsRequest request) async {
    const String url = '/Auth/login';

    late LoginResponse loginResponse;

    try {
      GeneralResponse resp = await interceptorHttp.request(
          context, "POST", url, request,
          showLoading: true, isLogin: true);
      if (!resp.error) {
        if (context.mounted) {
          loginResponse = loginResponseFromJson(jsonEncode(resp.data));
          await SecurityStorage.saveToken(loginResponse.token!);
          return resp;
        }
      } else {
        return resp;
      }
    } catch (e) {
      // GlobalHelper.logger.e('metodo Login $e');
      return GeneralResponse(
        message: "Error al realizar la autenticación",
        error: true,
      );
    }
  }

  Future<GeneralResponse<UserInformationResponse>> userInformation(
      BuildContext context) async {
    String url = '/User/get/by-id';
    String token = await SecurityStorage.getToken();

    final userInfo = await TokenHelper.getUserInfoFromToken();
    final userId = userInfo["userId"];
    Map<String, dynamic> queryParameters = {
      'userId': userId // reemplaza con el valor real
    };
    try {
      GeneralResponse resp = await interceptorHttp.request(
          context, "GET", url, null,
          showLoading: true, queryParameters: queryParameters);

      UserInformationResponse? userInformationResponse;

      if (!resp.error) {
        final List<dynamic> dataList = resp.data["data"];
        final Map<String, dynamic> raw = dataList[0];
        inspect(raw); // 👈 esto es importante
        userInformationResponse =
            userInformationResponseFromJson(jsonEncode(raw));
      }

      return GeneralResponse(
        message: resp.message,
        error: resp.error,
        data: userInformationResponse,
      );
    } catch (e, stacktrace) {
      debugPrint("❌ Error al parsear respuesta: $e");
      debugPrint("📍 Stacktrace: $stacktrace");

      return GeneralResponse(
        message: "Error al confirmar el correo",
        error: true,
      );
    }
  }
}
