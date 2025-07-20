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
  final double latitude;
  final double longitude;

  EmergencyRequest({
    this.typeId,
    required this.latitude,
    required this.longitude,
  });

  factory EmergencyRequest.fromJson(Map<String, dynamic> json) =>
      EmergencyRequest(
        typeId: json['typeId'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  Map<String, dynamic> toJson() =>
      {'typeId': typeId, 'latitude': latitude, 'longitude': longitude};
}
