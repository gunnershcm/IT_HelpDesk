class UserProfileResponseModel {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? password;
  String? email;
  String? address;
  String? avatarUrl;
  int? role;
  String? phoneNumber;
  String? dateOfBirth;
  int? gender;
  bool? isActive;

  UserProfileResponseModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.password,
      this.email,
      this.address,
      this.avatarUrl,
      this.role,
      this.phoneNumber,
      this.dateOfBirth,
      this.gender,
      this.isActive});

  factory UserProfileResponseModel.fromMap(Map<String, dynamic> json) =>
      UserProfileResponseModel(
        id: json["id"] ?? 0,
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        address: json["address"] ?? "",
        avatarUrl: json["avatarUrl"] ?? "",
        role: json["role"],
        phoneNumber: json["phoneNumber"] ?? "",
        dateOfBirth: json["dateOfBirth"] ?? "",
        gender: json["gender"],
        isActive: json["isActive"] ?? true,
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        'avatarUrl': avatarUrl,
        'address': address,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
      };
}
