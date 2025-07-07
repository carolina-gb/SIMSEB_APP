// To parse this JSON data, do
//
//     final credentialsRequest = credentialsRequestFromJson(jsonString);

import 'dart:convert';

CredentialsRequest credentialsRequestFromJson(String str) => CredentialsRequest.fromJson(json.decode(str));

String credentialsRequestToJson(CredentialsRequest data) => json.encode(data.toJson());

class CredentialsRequest {
    String? input;
    String? password;

    CredentialsRequest({
        this.input,
        this.password,
    });

    factory CredentialsRequest.fromJson(Map<String, dynamic> json) => CredentialsRequest(
        input: json["input"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "input": input,
        "password": password,
    };
}
