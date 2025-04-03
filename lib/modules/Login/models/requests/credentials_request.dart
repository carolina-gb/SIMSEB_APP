// To parse this JSON data, do
//
//     final credentialsRequest = credentialsRequestFromJson(jsonString);

import 'dart:convert';

CredentialsRequest credentialsRequestFromJson(String str) => CredentialsRequest.fromJson(json.decode(str));

String credentialsRequestToJson(CredentialsRequest data) => json.encode(data.toJson());

class CredentialsRequest {
    String? userName;
    String? password;

    CredentialsRequest({
        this.userName,
        this.password,
    });

    factory CredentialsRequest.fromJson(Map<String, dynamic> json) => CredentialsRequest(
        userName: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": userName,
        "password": password,
    };
}
