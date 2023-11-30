class UserLoginResponseModel {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? address;
  String? avatarUrl;
  int? role;
  String? phoneNumber;
  String? dateOfBirth;
  int? gender;
  String? accessToken;

  UserLoginResponseModel({
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.address,
    this.avatarUrl,
    this.role,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.accessToken,
  });

  factory UserLoginResponseModel.fromMap(Map<String, dynamic> json) => UserLoginResponseModel(
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        address: json["address"] ?? "",
        avatarUrl: json["avatarUrl"] ?? "",
        role: json["role"],
        phoneNumber: json["phoneNumber"] ?? "",
        dateOfBirth: json["dateOfBirth"] ?? "",
        gender: json["gender"],
        accessToken: json["accessToken"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "full_name": firstName,
        "lastName": lastName,
        "username": username,
        "accessToken": accessToken,
      };
}
