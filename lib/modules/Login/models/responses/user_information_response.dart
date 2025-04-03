import 'dart:convert';

UserInformationResponse userInformationResponseFromJson(String str) => UserInformationResponse.fromJson(json.decode(str));

String userInformationResponseToJson(UserInformationResponse data) => json.encode(data.toJson());

class UserInformationResponse {
    final String? userId;
    final String? username;
    final String? name;
    final String? lastName;
    final String? email;
    final dynamic phoneNumber;
    final dynamic socialReason;
    final dynamic ruc;
    final bool? changePassword;


    UserInformationResponse({
        this.userId,
        this.username,
        this.name,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.socialReason,
        this.ruc,
        this.changePassword,
    });

    factory UserInformationResponse.fromJson(Map<String, dynamic> json) => UserInformationResponse(
        userId: json["user_id"],
        username: json["username"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        socialReason: json["social_reason"],
        ruc: json["ruc"],
        changePassword: json["change_password"]

    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "name": name,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "social_reason": socialReason,
        "ruc": ruc,
        "change_password": changePassword

    };
}
