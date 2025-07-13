import 'dart:convert';

ReportResponse reportResponseFromJson(String str) =>
    ReportResponse.fromJson(json.decode(str));

String reportResponseToJson(ReportResponse data) =>
    json.encode(data.toJson());

class ReportResponse {
  String? reportId;

  String? caseNumber;

  String? description;

  String? createdBy;

  String? typeName;

  String? stageName;

  String? evidenceFileName;

  DateTime? createdAt;

  ReportResponse({
    this.reportId,
    this.caseNumber,
    this.description,
    this.createdBy,
    this.typeName,
    this.stageName,
    this.evidenceFileName,
    this.createdAt,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) => ReportResponse(
        reportId: json['reportId'],
        caseNumber: json['caseNumber'],
        description: json['description'],
        createdBy: json['createdBy'],
        typeName: json['typeName'],
        stageName: json['stageName'],
        evidenceFileName: json['evidenceFileName'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'reportId': reportId,
        'caseNumber': caseNumber,
        'description': description,
        'createdBy': createdBy,
        'typeName': typeName,
        'stageName': stageName,
        'evidenceFileName': evidenceFileName,
        'createdAt': createdAt?.toIso8601String(),
      };
}
