// To parse this JSON data, do
//
//     final credentialsRequest = credentialsRequestFromJson(jsonString);

import 'dart:convert';

ProfileRequest profileRequestFromJson(String str) => ProfileRequest.fromJson(json.decode(str));

String profileRequestToJson(ProfileRequest data) => json.encode(data.toJson());

class ProfileRequest {
    String? name;
    String? direccion;
    String? correo;
    String? contrasenia;

    ProfileRequest({
        this.name,
        this.direccion,
        this.correo,
        this.contrasenia
    });

    factory ProfileRequest.fromJson(Map<String, dynamic> json) => ProfileRequest(
        name: json["username"],
        direccion: json["direccion"],
        correo: json["correo"],
        contrasenia: json["contrasenia"],
    );

    Map<String, dynamic> toJson() => {
        "username": name,
        "direccion": direccion,
        "correo": correo,
        "contrasenia": contrasenia
    };
}
