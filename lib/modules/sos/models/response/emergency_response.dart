// To parse this JSON data, do
//
//     final emergencyResponse = emergencyResponseFromJson(jsonString);

import 'dart:convert';

EmergencyResponse emergencyResponseFromJson(String str) =>
    EmergencyResponse.fromJson(json.decode(str));

String emergencyResponseToJson(EmergencyResponse data) =>
    json.encode(data.toJson());

class EmergencyResponse {
  int? emergencyId;
  int? typeId;
  String? userId;
  DateTime? createdAt;

  EmergencyResponse({
    this.emergencyId,
    this.typeId,
    this.userId,
    this.createdAt,
  });

  factory EmergencyResponse.fromJson(Map<String, dynamic> json) =>
      EmergencyResponse(
        emergencyId: json['emergencyId'],
        typeId: json['typeId'],
        userId: json['userId'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'emergencyId': emergencyId,
        'typeId': typeId,
        'userId': userId,
        'createdAt': createdAt?.toIso8601String(),
      };
}
