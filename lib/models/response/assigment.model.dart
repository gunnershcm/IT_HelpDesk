// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AssigmentModel {
  int? id;
  String? technicianFullName;
  String? technicianEmail;
  String? technicianPhoneNumber;
  String? teamName;
  AssigmentModel({
    this.id,
    this.technicianFullName,
    this.technicianEmail,
    this.technicianPhoneNumber,
    this.teamName,
  });

  AssigmentModel copyWith({
    int? id,
    String? technicianFullName,
    String? technicianEmail,
    String? technicianPhoneNumber,
    String? teamName,
  }) {
    return AssigmentModel(
      id: id ?? this.id,
      technicianFullName: technicianFullName ?? this.technicianFullName,
      technicianEmail: technicianEmail ?? this.technicianEmail,
      technicianPhoneNumber: technicianPhoneNumber ?? this.technicianPhoneNumber,
      teamName: teamName ?? this.teamName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'technicianFullName': technicianFullName,
      'technicianEmail': technicianEmail,
      'technicianPhoneNumber': technicianPhoneNumber,
      'teamName': teamName,
    };
  }

  factory AssigmentModel.fromMap(Map<String, dynamic> map) {
    return AssigmentModel(
      id: map['id'] != null ? map['id'] as int : null,
      technicianFullName: map['technicianFullName'] != null ? map['technicianFullName'] as String : null,
      technicianEmail: map['technicianEmail'] != null ? map['technicianEmail'] as String : null,
      technicianPhoneNumber: map['technicianPhoneNumber'] != null ? map['technicianPhoneNumber'] as String : null,
      teamName: map['teamName'] != null ? map['teamName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssigmentModel.fromJson(String source) => AssigmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssigmentModel(id: $id, technicianFullName: $technicianFullName, technicianEmail: $technicianEmail, technicianPhoneNumber: $technicianPhoneNumber, teamName: $teamName)';
  }

  @override
  bool operator ==(covariant AssigmentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.technicianFullName == technicianFullName &&
      other.technicianEmail == technicianEmail &&
      other.technicianPhoneNumber == technicianPhoneNumber &&
      other.teamName == teamName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      technicianFullName.hashCode ^
      technicianEmail.hashCode ^
      technicianPhoneNumber.hashCode ^
      teamName.hashCode;
  }
}
