// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EntriesModel {
  int? id;
  String? message;
  EntriesModel({
    this.id,
    this.message,
  });

  EntriesModel copyWith({
    int? id,
    String? message,
  }) {
    return EntriesModel(
      id: id ?? this.id,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
    };
  }

  factory EntriesModel.fromMap(Map<String, dynamic> map) {
    return EntriesModel(
      id: map['id'] != null ? map['id'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EntriesModel.fromJson(String source) => EntriesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EntriesModel(id: $id, message: $message)';

  @override
  bool operator ==(covariant EntriesModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.message == message;
  }

  @override
  int get hashCode => id.hashCode ^ message.hashCode;
}
