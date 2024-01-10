// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dich_vu_it/models/response/assigment.model.dart';
import 'package:dich_vu_it/models/response/category.response.model.dart';
import 'package:dich_vu_it/models/response/mode.response.model.dart';

import 'service.response.model.dart';
import 'user.profile.response.model.dart';

class TicketResponseModel {
  int? id;
  int? requesterId;
  String? title;
  String? description;
  String? type;
  String? address;
  int? modeId;
  int? serviceId;
  int? categoryId;
  int? ticketStatus;
  int? priority;
  int? impact;
  String? impactDetail;
  List<String>? attachmentUrls;
  String? scheduledStartTime;
  String? scheduledEndTime;
  String? completedTime;
  String? createdAt;
  UserProfileResponseModel? requester;
  ServiceResponseModel? service;
  CategoryResponseModel? category;
  ModeResponseModel? mode;
  AssigmentModel? assignment;
  TicketResponseModel({
    this.id,
    this.requesterId,
    this.title,
    this.description,
    this.type,
    this.address,
    this.modeId,
    this.serviceId,
    this.categoryId,
    this.ticketStatus,
    this.priority,
    this.impact,
    this.impactDetail,
    this.attachmentUrls,
    this.scheduledStartTime,
    this.scheduledEndTime,
    this.completedTime,
    this.createdAt,
    this.requester,
    this.service,
    this.category,
    this.mode,
    this.assignment,
  });
  

  TicketResponseModel copyWith({
    int? id,
    int? requesterId,
    String? title,
    String? description,
    String? type,
    String? address,
    int? modeId,
    int? serviceId,
    int? categoryId,
    int? ticketStatus,
    int? priority,
    int? impact,
    String? impactDetail,
    List<String>? attachmentUrls,
    String? scheduledStartTime,
    String? scheduledEndTime,
    String? completedTime,
    String? createdAt,
    UserProfileResponseModel? requester,
    ServiceResponseModel? service,
    CategoryResponseModel? category,
    ModeResponseModel? mode,
    AssigmentModel? assignment,
  }) {
    return TicketResponseModel(
      id: id ?? this.id,
      requesterId: requesterId ?? this.requesterId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      address: address ?? this.address,
      modeId: modeId ?? this.modeId,
      serviceId: serviceId ?? this.serviceId,
      categoryId: categoryId ?? this.categoryId,
      ticketStatus: ticketStatus ?? this.ticketStatus,
      priority: priority ?? this.priority,
      impact: impact ?? this.impact,
      impactDetail: impactDetail ?? this.impactDetail,
      attachmentUrls: attachmentUrls ?? this.attachmentUrls,
      scheduledStartTime: scheduledStartTime ?? this.scheduledStartTime,
      scheduledEndTime: scheduledEndTime ?? this.scheduledEndTime,
      completedTime: completedTime ?? this.completedTime,
      createdAt: createdAt ?? this.createdAt,
      requester: requester ?? this.requester,
      service: service ?? this.service,
      category: category ?? this.category,
      mode: mode ?? this.mode,
      assignment: assignment ?? this.assignment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'requesterId': requesterId,
      'title': title,
      'description': description,
      'type': type,
      'address': address,
      'modeId': modeId,
      'serviceId': serviceId,
      'categoryId': categoryId,
      'ticketStatus': ticketStatus,
      'priority': priority,
      'impact': impact,
      'impactDetail': impactDetail,
      'attachmentUrls': attachmentUrls,
      'scheduledStartTime': scheduledStartTime,
      'scheduledEndTime': scheduledEndTime,
      'completedTime': completedTime,
      'createdAt': createdAt,
      'requester': requester?.toMap(),
      'service': service?.toMap(),
      'category': category?.toMap(),
      'mode': mode?.toMap(),
      'assignment': assignment?.toMap(),
    };
  }

  factory TicketResponseModel.fromMap(Map<String, dynamic> map) {
    return TicketResponseModel(
      id: map['id'] != null ? map['id'] as int : null,
      requesterId: map['requesterId'] != null ? map['requesterId'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      modeId: map['modeId'] != null ? map['modeId'] as int : null,
      serviceId: map['serviceId'] != null ? map['serviceId'] as int : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      ticketStatus: map['ticketStatus'] != null ? map['ticketStatus'] as int : null,
      priority: map['priority'] != null ? map['priority'] as int : null,
      impact: map['impact'] != null ? map['impact'] as int : null,
      impactDetail: map['impactDetail'] != null ? map['impactDetail'] as String : null,
      attachmentUrls: map['attachmentUrls'] != null ? List<String>.from(map['attachmentUrls']) : null ,
      scheduledStartTime: map['scheduledStartTime'] != null ? map['scheduledStartTime'] as String : null,
      scheduledEndTime: map['scheduledEndTime'] != null ? map['scheduledEndTime'] as String : null,
      completedTime: map['completedTime'] != null ? map['completedTime'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      requester: map['requester'] != null ? UserProfileResponseModel.fromMap(map['requester'] as Map<String,dynamic>) : null,
      service: map['service'] != null ? ServiceResponseModel.fromMap(map['service'] as Map<String,dynamic>) : null,
      category: map['category'] != null ? CategoryResponseModel.fromMap(map['category'] as Map<String,dynamic>) : null,
      mode: map['mode'] != null ? ModeResponseModel.fromMap(map['mode'] as Map<String,dynamic>) : null,
      assignment: map['assignment'] != null ? AssigmentModel.fromMap(map['assignment'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TicketResponseModel.fromJson(String source) => TicketResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TicketResponseModel(id: $id, requesterId: $requesterId, title: $title, description: $description, type: $type, address: $address, modeId: $modeId, serviceId: $serviceId, categoryId: $categoryId, ticketStatus: $ticketStatus, priority: $priority, impact: $impact, impactDetail: $impactDetail, attachmentUrls: $attachmentUrls, scheduledStartTime: $scheduledStartTime, scheduledEndTime: $scheduledEndTime, completedTime: $completedTime, createdAt: $createdAt, requester: $requester, service: $service, category: $category, mode: $mode, assignment: $assignment)';
  }

  @override
  bool operator ==(covariant TicketResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.requesterId == requesterId &&
      other.title == title &&
      other.description == description &&
      other.type == type &&
      other.address == address &&
      other.modeId == modeId &&
      other.serviceId == serviceId &&
      other.categoryId == categoryId &&
      other.ticketStatus == ticketStatus &&
      other.priority == priority &&
      other.impact == impact &&
      other.impactDetail == impactDetail &&
      listEquals(other.attachmentUrls, attachmentUrls) &&
      other.scheduledStartTime == scheduledStartTime &&
      other.scheduledEndTime == scheduledEndTime &&
      other.completedTime == completedTime &&
      other.createdAt == createdAt &&
      other.requester == requester &&
      other.service == service &&
      other.category == category &&
      other.mode == mode &&
      other.assignment == assignment;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      requesterId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      type.hashCode ^
      address.hashCode ^
      modeId.hashCode ^
      serviceId.hashCode ^
      categoryId.hashCode ^
      ticketStatus.hashCode ^
      priority.hashCode ^
      impact.hashCode ^
      impactDetail.hashCode ^
      attachmentUrls.hashCode ^
      scheduledStartTime.hashCode ^
      scheduledEndTime.hashCode ^
      completedTime.hashCode ^
      createdAt.hashCode ^
      requester.hashCode ^
      service.hashCode ^
      category.hashCode ^
      mode.hashCode ^
      assignment.hashCode;
  }
}
