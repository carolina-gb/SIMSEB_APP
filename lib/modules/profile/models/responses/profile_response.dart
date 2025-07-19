// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

import 'dart:convert';

UsersResponse usersResponseFromJson(String str) =>
    UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) =>
    json.encode(data.toJson());

class UsersResponse {
  int? count;
  List<UserItem>? data;

  UsersResponse({
    this.count,
    this.data,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        count: json["count"],
        data: json["data"] == null
            ? []
            : List<UserItem>.from(
                json["data"]!.map((x) => UserItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UserItem {
  String? userId;
  String? username;
  String? fullName;
  String? identification;
  String? email;
  UserStatus? userStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? details;
  UserType? type;

  UserItem({
    this.userId,
    this.username,
    this.fullName,
    this.identification,
    this.email,
    this.userStatus,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.details,
    this.type,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(
        userId: json["userId"],
        username: json["username"],
        fullName: json["fullName"],
        identification: json["identification"],
        email: json["email"],
        userStatus: json["userStatus"] == null
            ? null
            : UserStatus.fromJson(json["userStatus"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"] == null
            ? null
            : DateTime.parse(json["deletedAt"]),
        details: json["details"],
        type: json["type"] == null ? null : UserType.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "fullName": fullName,
        "identification": identification,
        "email": email,
        "userStatus": userStatus?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt?.toIso8601String(),
        "details": details,
        "type": type?.toJson(),
      };
}

class UserStatus {
  int? userStatusId;
  String? name;
  String? showName;
  DateTime? createdAt;

  UserStatus({
    this.userStatusId,
    this.name,
    this.showName,
    this.createdAt,
  });

  factory UserStatus.fromJson(Map<String, dynamic> json) => UserStatus(
        userStatusId: json["userStatusId"],
        name: json["name"],
        showName: json["showName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userStatusId": userStatusId,
        "name": name,
        "showName": showName,
        "createdAt": createdAt?.toIso8601String(),
      };
}

class UserType {
  int? userTypeId;
  String? name;
  String? showName;
  DateTime? createdAt;

  UserType({
    this.userTypeId,
    this.name,
    this.showName,
    this.createdAt,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        userTypeId: json["userTypeId"],
        name: json["name"],
        showName: json["showName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "userTypeId": userTypeId,
        "name": name,
        "showName": showName,
        "createdAt": createdAt?.toIso8601String(),
      };
}
