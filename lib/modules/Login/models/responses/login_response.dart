import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    final String? sessionToken;
    final String? sessionTokenRefresh;

    LoginResponse({
        this.sessionToken,
        this.sessionTokenRefresh,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        sessionToken: json["session_token"],
        sessionTokenRefresh: json["session_token_refresh"],
    );

    Map<String, dynamic> toJson() => {
        "session_token": sessionToken,
        "session_token_refresh": sessionTokenRefresh,
    };
}
