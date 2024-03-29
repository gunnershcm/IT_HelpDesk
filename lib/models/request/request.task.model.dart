// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dich_vu_it/models/response/ticket.response.model.dart';

class RequestTaskModel {
  int? ticketId;
  String? title;
  String? description;
  int? priority;
  String? scheduledStartTime;
  String? scheduledEndTime;
  List<String>? attachmentUrls;
  int? taskStatus;
  TicketResponseModel? ticketResponseModel;
  RequestTaskModel({
    this.ticketId,
    this.title,
    this.description,
    this.priority,
    this.scheduledStartTime,
    this.scheduledEndTime,
    this.attachmentUrls,
    this.taskStatus,
    this.ticketResponseModel,
  });
  

  RequestTaskModel copyWith({
    int? ticketId,
    String? title,
    String? description,
    int? priority,
    String? scheduledStartTime,
    String? scheduledEndTime,
    List<String>? attachmentUrls,
    int? taskStatus,
    TicketResponseModel? ticketResponseModel,
  }) {
    return RequestTaskModel(
      ticketId: ticketId ?? this.ticketId,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      scheduledStartTime: scheduledStartTime ?? this.scheduledStartTime,
      scheduledEndTime: scheduledEndTime ?? this.scheduledEndTime,
      attachmentUrls: attachmentUrls ?? this.attachmentUrls,
      taskStatus: taskStatus ?? this.taskStatus,
      ticketResponseModel: ticketResponseModel ?? this.ticketResponseModel,
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
      'attachmentUrls': attachmentUrls,
      'taskStatus': taskStatus,
      'ticketResponseModel': ticketResponseModel?.toMap(),
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
      attachmentUrls: map['attachmentUrls'] != null ? List<String>.from((map['attachmentUrls'] as List<String>)) : null,
      taskStatus: map['taskStatus'] != null ? map['taskStatus'] as int : null,
      ticketResponseModel: map['ticketResponseModel'] != null ? TicketResponseModel.fromMap(map['ticketResponseModel'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestTaskModel.fromJson(String source) => RequestTaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestTaskModel(ticketId: $ticketId, title: $title, description: $description, priority: $priority, scheduledStartTime: $scheduledStartTime, scheduledEndTime: $scheduledEndTime, attachmentUrls: $attachmentUrls, taskStatus: $taskStatus, ticketResponseModel: $ticketResponseModel)';
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
      listEquals(other.attachmentUrls, attachmentUrls) &&
      other.taskStatus == taskStatus &&
      other.ticketResponseModel == ticketResponseModel;
  }

  @override
  int get hashCode {
    return ticketId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      priority.hashCode ^
      scheduledStartTime.hashCode ^
      scheduledEndTime.hashCode ^
      attachmentUrls.hashCode ^
      taskStatus.hashCode ^
      ticketResponseModel.hashCode;
  }
}
