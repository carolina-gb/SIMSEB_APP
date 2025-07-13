// To parse this JSON data, do
//
//     final evidenceRequest = evidenceRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

EvidenceRequest evidenceRequestFromJson(String str) =>
    EvidenceRequest.fromJson(json.decode(str));

String evidenceRequestToJson(EvidenceRequest data) =>
    json.encode(data.toJson());

class EvidenceRequest {
  File evidenceFile;
  String description;
  int typeId;

  EvidenceRequest({
    required this.evidenceFile,
    required this.description,
    required this.typeId,
  });

  factory EvidenceRequest.fromJson(Map<String, dynamic> json) =>
      EvidenceRequest(
        evidenceFile: json['EvidenceFile'],
        description: json['Description'],
        typeId: json['TypeId'],
      );

  Map<String, dynamic> toJson() => {
        'EvidenceFile': evidenceFile,
        'Description': description,
        'TypeId': typeId,
      };
}
