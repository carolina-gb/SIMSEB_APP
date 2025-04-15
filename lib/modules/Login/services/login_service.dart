import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertest/modules/Login/models/requests/credentials_request.dart';
import 'package:fluttertest/modules/Login/models/responses/login_response.dart';
import 'package:fluttertest/modules/Login/models/responses/user_information_response.dart';
import 'package:fluttertest/shared/models/general_response.dart';
import 'package:fluttertest/shared/services/http_interceptor.dart';

class LoginService {
  InterceptorHttp interceptorHttp = InterceptorHttp();

  Future login(BuildContext context, CredentialsRequest request) async {
    const String url = '/auth/access/new';

    late LoginResponse loginResponse;

    try {
      GeneralResponse resp = await interceptorHttp
          .request(context, "POST", url, request, showLoading: true);
      if (!resp.error) {
        if (context.mounted) {
          loginResponse = loginResponseFromJson(jsonEncode(resp.data));

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

  // Future<GeneralResponse<UserInformationResponse>> userInformation(
  //     BuildContext context) async {
  //   String url = '/users/me';

  //   try {
  //     GeneralResponse resp = await interceptorHttp
  //         .request(context, "GET", url, null, showLoading: true);
  //     UserInformationResponse? userInformationResponse;
  //     if (!resp.error) {
  //       userInformationResponse =
  //           userInformationResponseFromJson(jsonEncode(resp.data));
  //     }

  //     return GeneralResponse(
  //         message: resp.message,
  //         error: resp.error,
  //         data: userInformationResponse);
  //   } catch (e) {
  //     // GlobalHelper.logger.e('metodo userInformation $e');
  //     return GeneralResponse(
  //       message: "Error al confirmar el correo",
  //       error: true,
  //     );
  //   }
  // }
}
