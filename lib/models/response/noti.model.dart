// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotiModel {
  int? id;
  String? title;
  String? body;
  bool? isRead;
  String? createdAt;
  NotiModel({
    this.id,
    this.title,
    this.body,
    this.isRead,
    this.createdAt,
  });

  NotiModel copyWith({
    int? id,
    String? title,
    String? body,
    bool? isRead,
    String? createdAt,
  }) {
    return NotiModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'isRead': isRead,
      'createdAt': createdAt,
    };
  }

  factory NotiModel.fromMap(Map<String, dynamic> map) {
    return NotiModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      isRead: map['isRead'] != null ? map['isRead'] as bool : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotiModel.fromJson(String source) => NotiModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotiModel(id: $id, title: $title, body: $body, isRead: $isRead, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant NotiModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.body == body &&
      other.isRead == isRead &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      body.hashCode ^
      isRead.hashCode ^
      createdAt.hashCode;
  }
}
