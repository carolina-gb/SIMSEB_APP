import 'dart:convert';

ProfileDataModel profileDataModelFromJson(String str) => ProfileDataModel.fromJson(json.decode(str));

String profileDataModelToJson(ProfileDataModel data) => json.encode(data.toJson());

class ProfileDataModel {
    String? name;
    String? direccion;
    String? correo;
    String? contrasenia;

    ProfileDataModel({
        this.name,
        this.direccion,
        this.correo,
        this.contrasenia
    });

    factory ProfileDataModel.fromJson(Map<String, dynamic> json) => ProfileDataModel(
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