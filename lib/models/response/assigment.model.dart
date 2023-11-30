// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AssigmentModel {
  int? id;
  String? technicianFullName;
  String? technicianEmail;
  String? technicianPhone;
  String? teamName;
  AssigmentModel({
    this.id,
    this.technicianFullName,
    this.technicianEmail,
    this.technicianPhone,
    this.teamName,
  });

  AssigmentModel copyWith({
    int? id,
    String? technicianFullName,
    String? technicianEmail,
    String? technicianPhone,
    String? teamName,
  }) {
    return AssigmentModel(
      id: id ?? this.id,
      technicianFullName: technicianFullName ?? this.technicianFullName,
      technicianEmail: technicianEmail ?? this.technicianEmail,
      technicianPhone: technicianPhone ?? this.technicianPhone,
      teamName: teamName ?? this.teamName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'technicianFullName': technicianFullName,
      'technicianEmail': technicianEmail,
      'technicianPhone': technicianPhone,
      'teamName': teamName,
    };
  }

  factory AssigmentModel.fromMap(Map<String, dynamic> map) {
    return AssigmentModel(
      id: map['id'] != null ? map['id'] as int : null,
      technicianFullName: map['technicianFullName'] != null ? map['technicianFullName'] as String : null,
      technicianEmail: map['technicianEmail'] != null ? map['technicianEmail'] as String : null,
      technicianPhone: map['technicianPhone'] != null ? map['technicianPhone'] as String : null,
      teamName: map['teamName'] != null ? map['teamName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssigmentModel.fromJson(String source) => AssigmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssigmentModel(id: $id, technicianFullName: $technicianFullName, technicianEmail: $technicianEmail, technicianPhone: $technicianPhone, teamName: $teamName)';
  }

  @override
  bool operator ==(covariant AssigmentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.technicianFullName == technicianFullName &&
      other.technicianEmail == technicianEmail &&
      other.technicianPhone == technicianPhone &&
      other.teamName == teamName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      technicianFullName.hashCode ^
      technicianEmail.hashCode ^
      technicianPhone.hashCode ^
      teamName.hashCode;
  }
}
