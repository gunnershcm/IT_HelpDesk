// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class RequestCreateTicketModel {
  int? id;
  String? title;
  String? description;
  int? serviceId;
  List<String>? attachmentUrls;
  RequestCreateTicketModel({
    this.id,
    this.title,
    this.description,
    this.serviceId,
    this.attachmentUrls,
  });
  

  RequestCreateTicketModel copyWith({
    int? id,
    String? title,
    String? description,
    int? serviceId,
    List<String>? attachmentUrls,
  }) {
    return RequestCreateTicketModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      serviceId: serviceId ?? this.serviceId,
      attachmentUrls: attachmentUrls ?? this.attachmentUrls,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'serviceId': serviceId,
      'attachmentUrls': attachmentUrls,
    };
  }

  factory RequestCreateTicketModel.fromMap(Map<String, dynamic> map) {
    return RequestCreateTicketModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      serviceId: map['serviceId'] != null ? map['serviceId'] as int : null,
      attachmentUrls: map['attachmentUrls'] != null ? List<String>.from(map['attachmentUrls']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestCreateTicketModel.fromJson(String source) => RequestCreateTicketModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestCreateTicketModel(id: $id, title: $title, description: $description, serviceId: $serviceId, attachmentUrls: $attachmentUrls)';
  }

  @override
  bool operator ==(covariant RequestCreateTicketModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.serviceId == serviceId &&
      listEquals(other.attachmentUrls, attachmentUrls);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      serviceId.hashCode ^
      attachmentUrls.hashCode;
  }
}
