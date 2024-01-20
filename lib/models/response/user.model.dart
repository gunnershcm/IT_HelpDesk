// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModelResponse {
  int? id;
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
  UserModelResponse({
    this.id,
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
  

  UserModelResponse copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? address,
    String? avatarUrl,
    int? role,
    String? phoneNumber,
    String? dateOfBirth,
    int? gender,
    String? accessToken,
  }) {
    return UserModelResponse(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      address: address ?? this.address,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'address': address,
      'avatarUrl': avatarUrl,
      'role': role,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'accessToken': accessToken,
    };
  }

  factory UserModelResponse.fromMap(Map<String, dynamic> map) {
    return UserModelResponse(
      id: map['id'] != null ? map['id'] as int : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      avatarUrl: map['avatarUrl'] != null ? map['avatarUrl'] as String : null,
      role: map['role'] != null ? map['role'] as int : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      dateOfBirth: map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      gender: map['gender'] != null ? map['gender'] as int : null,
      accessToken: map['accessToken'] != null ? map['accessToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModelResponse.fromJson(String source) => UserModelResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModelResponse(id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, address: $address, avatarUrl: $avatarUrl, role: $role, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, gender: $gender, accessToken: $accessToken)';
  }

  @override
  bool operator ==(covariant UserModelResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.username == username &&
      other.email == email &&
      other.address == address &&
      other.avatarUrl == avatarUrl &&
      other.role == role &&
      other.phoneNumber == phoneNumber &&
      other.dateOfBirth == dateOfBirth &&
      other.gender == gender &&
      other.accessToken == accessToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      username.hashCode ^
      email.hashCode ^
      address.hashCode ^
      avatarUrl.hashCode ^
      role.hashCode ^
      phoneNumber.hashCode ^
      dateOfBirth.hashCode ^
      gender.hashCode ^
      accessToken.hashCode;
  }
}
