// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:dich_vu_it/models/response/entries.model.dart';

class LogModel {
  String? timestamp;
  String? username;
  String? action;
  EntriesModel? entries;

  LogModel({this.timestamp, this.username, this.action, this.entries});

  LogModel copyWith({
    String? timestamp,
    String? username,
    String? action,
    EntriesModel? entries,
  }) {
    return LogModel(
      timestamp: timestamp ?? this.timestamp,
      username: username ?? this.username,
      action: action ?? this.action,
      entries: entries ?? this.entries,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timestamp': timestamp,
      'username': username,
      'action': action,
      'entries': entries?.toMap(),
    };
  }

  factory LogModel.fromMap(Map<String, dynamic> map) {
    return LogModel(
      timestamp: map['timestamp'] != null ? map['timestamp'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      action: map['action'] != null ? map['action'] as String : null,
      entries: map['entries'] != null
          ? EntriesModel.fromMap(map['entries'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogModel.fromJson(String source) =>
      LogModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LogModel(timestamp: $timestamp, username: $username, action: $action, entries: $entries)';
  }

  @override
  bool operator ==(covariant LogModel other) {
    if (identical(this, other)) return true;

    return other.timestamp == timestamp &&
        other.username == username &&
        other.action == action &&
        other.entries == entries ;
  }

  @override
  int get hashCode {
    return 
        timestamp.hashCode ^
        username.hashCode ^
        action.hashCode ^
        entries.hashCode;
  }
}
