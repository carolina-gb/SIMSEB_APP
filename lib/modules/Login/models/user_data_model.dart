import 'dart:convert';

DataUserModel dataUserModelFromJson(String str) => DataUserModel.fromJson(json.decode(str));

String dataUserModelToJson(DataUserModel data) => json.encode(data.toJson());

class DataUserModel {
    final String? usuario;
    final String? clave;

    DataUserModel({
        this.usuario,
        this.clave,
    });

    factory DataUserModel.fromJson(Map<String, dynamic> json) => DataUserModel(
        usuario: json["usuario"],
        clave: json["clave"],
    );

    Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "clave": clave,
    };
}
