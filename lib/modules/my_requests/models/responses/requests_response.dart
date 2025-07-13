// To parse this JSON data, do
//
//     final reportsResponse = reportsResponseFromJson(jsonString);

import 'dart:convert';

ReportsResponse reportsResponseFromJson(String str) => ReportsResponse.fromJson(json.decode(str));

String reportsResponseToJson(ReportsResponse data) => json.encode(data.toJson());

class ReportsResponse {
    int? count;
    List<ReportItem>? data;

    ReportsResponse({
        this.count,
        this.data,
    });

    factory ReportsResponse.fromJson(Map<String, dynamic> json) => ReportsResponse(
        count: json["count"],
        data: json["data"] == null ? [] : List<ReportItem>.from(json["data"]!.map((x) => ReportItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ReportItem {
    String? reportId;
    String? caseNumber;
    String? description;
    dynamic rejectReason;
    dynamic rejectBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    EvidenceFile? evidenceFile;
    Stage? type;
    Stage? stage;

    ReportItem({
        this.reportId,
        this.caseNumber,
        this.description,
        this.rejectReason,
        this.rejectBy,
        this.createdAt,
        this.updatedAt,
        this.evidenceFile,
        this.type,
        this.stage,
    });

    factory ReportItem.fromJson(Map<String, dynamic> json) => ReportItem(
        reportId: json["reportId"],
        caseNumber: json["caseNumber"],
        description: json["description"],
        rejectReason: json["rejectReason"],
        rejectBy: json["rejectBy"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        evidenceFile: json["evidenceFile"] == null ? null : EvidenceFile.fromJson(json["evidenceFile"]),
        type: json["type"] == null ? null : Stage.fromJson(json["type"]),
        stage: json["stage"] == null ? null : Stage.fromJson(json["stage"]),
    );

    Map<String, dynamic> toJson() => {
        "reportId": reportId,
        "caseNumber": caseNumber,
        "description": description,
        "rejectReason": rejectReason,
        "rejectBy": rejectBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "evidenceFile": evidenceFile?.toJson(),
        "type": type?.toJson(),
        "stage": stage?.toJson(),
    };
}

class EvidenceFile {
    String? fileId;
    String? path;
    String? type;
    DateTime? uploadedAt;

    EvidenceFile({
        this.fileId,
        this.path,
        this.type,
        this.uploadedAt,
    });

    factory EvidenceFile.fromJson(Map<String, dynamic> json) => EvidenceFile(
        fileId: json["fileId"],
        path: json["path"],
        type: json["type"],
        uploadedAt: json["uploadedAt"] == null ? null : DateTime.parse(json["uploadedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "path": path,
        "type": type,
        "uploadedAt": uploadedAt?.toIso8601String(),
    };
}

class Stage {
    int? reportStageId;
    String? name;
    String? showName;
    DateTime? createdAt;
    int? reportTypeId;

    Stage({
        this.reportStageId,
        this.name,
        this.showName,
        this.createdAt,
        this.reportTypeId,
    });

    factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        reportStageId: json["reportStageId"],
        name: json["name"],
        showName: json["showName"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        reportTypeId: json["reportTypeId"],
    );

    Map<String, dynamic> toJson() => {
        "reportStageId": reportStageId,
        "name": name,
        "showName": showName,
        "createdAt": createdAt?.toIso8601String(),
        "reportTypeId": reportTypeId,
    };
}
