// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dich_vu_it/models/response/tiket.response.model.dart';

class TaskModel {
  int? id;
  int? ticketId;
  TicketResponseModel? ticket;
  String? title;
  String? description;
  String? note;
  int? priority;
  String? scheduledStartTime;
  String? scheduledEndTime;
  String? actualStartTime;
  String? actualEndTime;
  int? progress;
  String? attachmentUrl;
  int? taskStatus;
  TaskModel({
    this.id,
    this.ticketId,
    this.ticket,
    this.title,
    this.description,
    this.note,
    this.priority,
    this.scheduledStartTime,
    this.scheduledEndTime,
    this.actualStartTime,
    this.actualEndTime,
    this.progress,
    this.attachmentUrl,
    this.taskStatus,
  });

  TaskModel copyWith({
    int? id,
    int? ticketId,
    TicketResponseModel? ticket,
    String? title,
    String? description,
    String? note,
    int? priority,
    String? scheduledStartTime,
    String? scheduledEndTime,
    String? actualStartTime,
    String? actualEndTime,
    int? progress,
    String? attachmentUrl,
    int? taskStatus,
  }) {
    return TaskModel(
      id: id ?? this.id,
      ticketId: ticketId ?? this.ticketId,
      ticket: ticket ?? this.ticket,
      title: title ?? this.title,
      description: description ?? this.description,
      note: note ?? this.note,
      priority: priority ?? this.priority,
      scheduledStartTime: scheduledStartTime ?? this.scheduledStartTime,
      scheduledEndTime: scheduledEndTime ?? this.scheduledEndTime,
      actualStartTime: actualStartTime ?? this.actualStartTime,
      actualEndTime: actualEndTime ?? this.actualEndTime,
      progress: progress ?? this.progress,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      taskStatus: taskStatus ?? this.taskStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'note': note,
      'description': description,
      'priority': priority,
      'scheduledStartTime': scheduledStartTime,
      'scheduledEndTime': scheduledEndTime,
      'progress': progress,
      'attachmentUrl': attachmentUrl,
      'taskStatus': taskStatus,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] != null ? map['id'] as int : null,
      ticketId: map['ticketId'] != null ? map['ticketId'] as int : null,
      ticket: map['ticket'] != null ? TicketResponseModel.fromMap(map['ticket'] as Map<String, dynamic>) : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      priority: map['priority'] != null ? map['priority'] as int : null,
      scheduledStartTime: map['scheduledStartTime'] != null ? map['scheduledStartTime'] as String : null,
      scheduledEndTime: map['scheduledEndTime'] != null ? map['scheduledEndTime'] as String : null,
      actualStartTime: map['actualStartTime'] != null ? map['actualStartTime'] as String : null,
      actualEndTime: map['actualEndTime'] != null ? map['actualEndTime'] as String : null,
      progress: map['progress'] != null ? map['progress'] as int : null,
      attachmentUrl: map['attachmentUrl'] != null ? map['attachmentUrl'] as String : null,
      taskStatus: map['taskStatus'] != null ? map['taskStatus'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(id: $id, ticketId: $ticketId, ticket: $ticket, title: $title, description: $description, note: $note, priority: $priority, scheduledStartTime: $scheduledStartTime, scheduledEndTime: $scheduledEndTime, actualStartTime: $actualStartTime, actualEndTime: $actualEndTime, progress: $progress, attachmentUrl: $attachmentUrl, taskStatus: $taskStatus)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.ticketId == ticketId && other.ticket == ticket && other.title == title && other.description == description && other.note == note && other.priority == priority && other.scheduledStartTime == scheduledStartTime && other.scheduledEndTime == scheduledEndTime && other.actualStartTime == actualStartTime && other.actualEndTime == actualEndTime && other.progress == progress && other.attachmentUrl == attachmentUrl && other.taskStatus == taskStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^ ticketId.hashCode ^ ticket.hashCode ^ title.hashCode ^ description.hashCode ^ note.hashCode ^ priority.hashCode ^ scheduledStartTime.hashCode ^ scheduledEndTime.hashCode ^ actualStartTime.hashCode ^ actualEndTime.hashCode ^ progress.hashCode ^ attachmentUrl.hashCode ^ taskStatus.hashCode;
  }
}
