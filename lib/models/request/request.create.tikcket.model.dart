// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestCreateTicketModel {
  int? id;
  String? title;
  String? description;
  int? priority;
  int? categoryId;
  String? categoryName;
  String? attachmentUrl;
  RequestCreateTicketModel({
    this.id,
    this.title,
    this.description,
    this.priority,
    this.categoryId,
    this.categoryName,
    this.attachmentUrl,
  });

  RequestCreateTicketModel copyWith({
    String? title,
    String? description,
    int? priority,
    int? categoryId,
    String? attachmentUrl,
  }) {
    return RequestCreateTicketModel(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      categoryId: categoryId ?? this.categoryId,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'priority': priority,
      'categoryId': categoryId,
      'attachmentUrl': attachmentUrl,
    };
  }

  factory RequestCreateTicketModel.fromMap(Map<String, dynamic> map) {
    return RequestCreateTicketModel(
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      priority: map['priority'] != null ? map['priority'] as int : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      attachmentUrl: map['attachmentUrl'] != null ? map['attachmentUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestCreateTicketModel.fromJson(String source) => RequestCreateTicketModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestCreateTicketModel(title: $title, description: $description, priority: $priority, categoryId: $categoryId, attachmentUrl: $attachmentUrl)';
  }

  @override
  bool operator ==(covariant RequestCreateTicketModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description &&
      other.priority == priority &&
      other.categoryId == categoryId &&
      other.attachmentUrl == attachmentUrl;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      description.hashCode ^
      priority.hashCode ^
      categoryId.hashCode ^
      attachmentUrl.hashCode;
  }
}
