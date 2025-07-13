// To parse this JSON data, do
//
//     final emergencyRequest = emergencyRequestFromJson(jsonString);

import 'dart:convert';

EmergencyRequest emergencyRequestFromJson(String str) =>
    EmergencyRequest.fromJson(json.decode(str));

String emergencyRequestToJson(EmergencyRequest data) =>
    json.encode(data.toJson());

class EmergencyRequest {
  int? typeId;

  EmergencyRequest({
    this.typeId,
  });

  factory EmergencyRequest.fromJson(Map<String, dynamic> json) =>
      EmergencyRequest(
        typeId: json['typeId'],
      );

  Map<String, dynamic> toJson() => {
        'typeId': typeId,
      };
}
