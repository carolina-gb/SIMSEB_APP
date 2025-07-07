import 'dart:convert';

UserInformationResponse userInformationResponseFromJson(String str) =>
    UserInformationResponse.fromJson(json.decode(str));

String userInformationResponseToJson(UserInformationResponse data) =>
    json.encode(data.toJson());

class UserInformationResponse {
  final String userId;
  final String username;
  final String fullName;
  final String identification;
  final String email;
  final String details;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final UserType type;

  UserInformationResponse({
    required this.userId,
    required this.username,
    required this.fullName,
    required this.identification,
    required this.email,
    required this.details,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.type,
  });

  factory UserInformationResponse.fromJson(Map<String, dynamic> json) =>
      UserInformationResponse(
        userId: json["userId"],
        username: json["username"],
        fullName: json["fullName"],
        identification: json["identification"],
        email: json["email"],
        details: json["details"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"] != null
            ? DateTime.tryParse(json["deletedAt"])
            : null,
        type: UserType.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "fullName": fullName,
        "identification": identification,
        "email": email,
        "details": details,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "deletedAt": deletedAt?.toIso8601String(),
        "type": type.toJson(),
      };
}

class UserType {
  final int userTypeId;
  final String name;
  final String showName;
  final DateTime createdAt;

  UserType({
    required this.userTypeId,
    required this.name,
    required this.showName,
    required this.createdAt,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        userTypeId: json["userTypeId"] ?? 0,
        name: json["name"] ?? "",
        showName: json["showName"] ?? "",
        createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "userTypeId": userTypeId,
        "name": name,
        "showName": showName,
        "createdAt": createdAt.toIso8601String(),
      };
}
