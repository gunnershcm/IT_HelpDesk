// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dich_vu_it/models/response/category.response.model.dart';

import 'user.profile.response.model.dart';

class TicketSolutionModel {
  int? id;
  String? title;
  String? content;
  int? categoryId;
  int? ownerId;
  int? createdById;
  String? reviewDate;
  String? expiredDate;
  String? keyword;
  String? internalComments;
  List<String>? attachmentUrls;
  bool? isApproved;
  String? createdAt;
  String? modifiedAt;
  int? countLike;
  int? countDislike;
  int? currentReactionUser;
  UserProfileResponseModel? owner;
  UserProfileResponseModel? createdBy;
  CategoryResponseModel? category;
  TicketSolutionModel({
    this.id,
    this.title,
    this.content,
    this.categoryId,
    this.ownerId,
    this.createdById,
    this.reviewDate,
    this.expiredDate,
    this.keyword,
    this.internalComments,
    this.attachmentUrls,
    this.isApproved,
    this.createdAt,
    this.modifiedAt,
    this.countLike,
    this.countDislike,
    this.currentReactionUser,
    this.owner,
    this.createdBy,
    this.category,
  });
 

  TicketSolutionModel copyWith({
    int? id,
    String? title,
    String? content,
    int? categoryId,
    int? ownerId,
    int? createdById,
    String? reviewDate,
    String? expiredDate,
    String? keyword,
    String? internalComments,
    List<String>? attachmentUrls,
    bool? isApproved,
    String? createdAt,
    String? modifiedAt,
    int? countLike,
    int? countDislike,
    int? currentReactionUser,
    UserProfileResponseModel? owner,
    UserProfileResponseModel? createdBy,
    CategoryResponseModel? category,
  }) {
    return TicketSolutionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      categoryId: categoryId ?? this.categoryId,
      ownerId: ownerId ?? this.ownerId,
      createdById: createdById ?? this.createdById,
      reviewDate: reviewDate ?? this.reviewDate,
      expiredDate: expiredDate ?? this.expiredDate,
      keyword: keyword ?? this.keyword,
      internalComments: internalComments ?? this.internalComments,
      attachmentUrls: attachmentUrls ?? this.attachmentUrls,
      isApproved: isApproved ?? this.isApproved,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      countLike: countLike ?? this.countLike,
      countDislike: countDislike ?? this.countDislike,
      currentReactionUser: currentReactionUser ?? this.currentReactionUser,
      owner: owner ?? this.owner,
      createdBy: createdBy ?? this.createdBy,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'categoryId': categoryId,
      'ownerId': ownerId,
      'createdById': createdById,
      'reviewDate': reviewDate,
      'expiredDate': expiredDate,
      'keyword': keyword,
      'internalComments': internalComments,
      'attachmentUrls': attachmentUrls,
      'isApproved': isApproved,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'countLike': countLike,
      'countDislike': countDislike,
      'currentReactionUser': currentReactionUser,
      'owner': owner?.toMap(),
      'createdBy': createdBy?.toMap(),
      'category': category?.toMap(),
    };
  }

  factory TicketSolutionModel.fromMap(Map<String, dynamic> map) {
    return TicketSolutionModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      ownerId: map['ownerId'] != null ? map['ownerId'] as int : null,
      createdById: map['createdById'] != null ? map['createdById'] as int : null,
      reviewDate: map['reviewDate'] != null ? map['reviewDate'] as String : null,
      expiredDate: map['expiredDate'] != null ? map['expiredDate'] as String : null,
      keyword: map['keyword'] != null ? map['keyword'] as String : null,
      internalComments: map['internalComments'] != null ? map['internalComments'] as String : null,
      attachmentUrls: map['attachmentUrls'] != null ? List<String>.from(map['attachmentUrls']) : null ,
      isApproved: map['isApproved'] != null ? map['isApproved'] as bool : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      modifiedAt: map['modifiedAt'] != null ? map['modifiedAt'] as String : null,
      countLike: map['countLike'] != null ? map['countLike'] as int : null,
      countDislike: map['countDislike'] != null ? map['countDislike'] as int : null,
      currentReactionUser: map['currentReactionUser'] != null ? map['currentReactionUser'] as int : null,
      owner: map['owner'] != null ? UserProfileResponseModel.fromMap(map['owner'] as Map<String,dynamic>) : null,
      createdBy: map['createdBy'] != null ? UserProfileResponseModel.fromMap(map['createdBy'] as Map<String,dynamic>) : null,
      category: map['category'] != null ? CategoryResponseModel.fromMap(map['category'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TicketSolutionModel.fromJson(String source) => TicketSolutionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TicketSolutionModel(id: $id, title: $title, content: $content, categoryId: $categoryId, ownerId: $ownerId, createdById: $createdById, reviewDate: $reviewDate, expiredDate: $expiredDate, keyword: $keyword, internalComments: $internalComments, attachmentUrls: $attachmentUrls, isApproved: $isApproved, createdAt: $createdAt, modifiedAt: $modifiedAt, countLike: $countLike, countDislike: $countDislike, currentReactionUser: $currentReactionUser, owner: $owner, createdBy: $createdBy, category: $category)';
  }

  @override
  bool operator ==(covariant TicketSolutionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.content == content &&
      other.categoryId == categoryId &&
      other.ownerId == ownerId &&
      other.createdById == createdById &&
      other.reviewDate == reviewDate &&
      other.expiredDate == expiredDate &&
      other.keyword == keyword &&
      other.internalComments == internalComments &&
      listEquals(other.attachmentUrls, attachmentUrls) &&
      other.isApproved == isApproved &&
      other.createdAt == createdAt &&
      other.modifiedAt == modifiedAt &&
      other.countLike == countLike &&
      other.countDislike == countDislike &&
      other.currentReactionUser == currentReactionUser &&
      other.owner == owner &&
      other.createdBy == createdBy &&
      other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      categoryId.hashCode ^
      ownerId.hashCode ^
      createdById.hashCode ^
      reviewDate.hashCode ^
      expiredDate.hashCode ^
      keyword.hashCode ^
      internalComments.hashCode ^
      attachmentUrls.hashCode ^
      isApproved.hashCode ^
      createdAt.hashCode ^
      modifiedAt.hashCode ^
      countLike.hashCode ^
      countDislike.hashCode ^
      currentReactionUser.hashCode ^
      owner.hashCode ^
      createdBy.hashCode ^
      category.hashCode;
  }
}
