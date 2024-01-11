// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class RequestTaskModel {
  int? ticketId;
  String? title;
  String? description;
  int? priority;
  String? scheduledStartTime;
  String? scheduledEndTime;
  List<String>? attachmentUrl;
  int? taskStatus;
  RequestTaskModel({
    this.ticketId,
    this.title,
    this.description,
    this.priority,
    this.scheduledStartTime,
    this.scheduledEndTime,
    this.attachmentUrl,
    this.taskStatus,
  });
  

  RequestTaskModel copyWith({
    int? ticketId,
    String? title,
    String? description,
    int? priority,
    String? scheduledStartTime,
    String? scheduledEndTime,
    List<String>? attachmentUrl,
    int? taskStatus,
  }) {
    return RequestTaskModel(
      ticketId: ticketId ?? this.ticketId,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      scheduledStartTime: scheduledStartTime ?? this.scheduledStartTime,
      scheduledEndTime: scheduledEndTime ?? this.scheduledEndTime,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      taskStatus: taskStatus ?? this.taskStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ticketId': ticketId,
      'title': title,
      'description': description,
      'priority': priority,
      'scheduledStartTime': scheduledStartTime,
      'scheduledEndTime': scheduledEndTime,
      'attachmentUrl': attachmentUrl,
      'taskStatus': taskStatus,
    };
  }

  factory RequestTaskModel.fromMap(Map<String, dynamic> map) {
    return RequestTaskModel(
      ticketId: map['ticketId'] != null ? map['ticketId'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      priority: map['priority'] != null ? map['priority'] as int : null,
      scheduledStartTime: map['scheduledStartTime'] != null ? map['scheduledStartTime'] as String : null,
      scheduledEndTime: map['scheduledEndTime'] != null ? map['scheduledEndTime'] as String : null,
      attachmentUrl: map['attachmentUrl'] != null ? List<String>.from((map['attachmentUrl'] as List<String>)) : null,
      taskStatus: map['taskStatus'] != null ? map['taskStatus'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestTaskModel.fromJson(String source) => RequestTaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestTaskModel(ticketId: $ticketId, title: $title, description: $description, priority: $priority, scheduledStartTime: $scheduledStartTime, scheduledEndTime: $scheduledEndTime, attachmentUrl: $attachmentUrl, taskStatus: $taskStatus)';
  }

  @override
  bool operator ==(covariant RequestTaskModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.ticketId == ticketId &&
      other.title == title &&
      other.description == description &&
      other.priority == priority &&
      other.scheduledStartTime == scheduledStartTime &&
      other.scheduledEndTime == scheduledEndTime &&
      listEquals(other.attachmentUrl, attachmentUrl) &&
      other.taskStatus == taskStatus;
  }

  @override
  int get hashCode {
    return ticketId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      priority.hashCode ^
      scheduledStartTime.hashCode ^
      scheduledEndTime.hashCode ^
      attachmentUrl.hashCode ^
      taskStatus.hashCode;
  }
}
