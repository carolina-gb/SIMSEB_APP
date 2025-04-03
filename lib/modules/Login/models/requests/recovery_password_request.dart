import 'dart:convert';

RecoveryPasswordRequest recoveryPasswordRequestFromJson(String str) => RecoveryPasswordRequest.fromJson(json.decode(str));

String recoveryPasswordRequestToJson(RecoveryPasswordRequest data) => json.encode(data.toJson());

class RecoveryPasswordRequest {
    String? email;

    RecoveryPasswordRequest({
        this.email,
    });

    factory RecoveryPasswordRequest.fromJson(Map<String, dynamic> json) => RecoveryPasswordRequest(
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
    };
}
