// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dich_vu_it/models/response/user.login.response.model.dart';
import 'package:dich_vu_it/models/response/user.model.dart';

class FeedbackModel {
  int? id;
  int? userId;
  int? solutionId;
  bool? isPublic;
  String? comment;
  String? createdAt;
  String? modifiedAt;
  UserModelResponse? user;
  FeedbackModel({
    this.id,
    this.userId,
    this.solutionId,
    this.isPublic,
    this.comment,
    this.createdAt,
    this.modifiedAt,
    this.user,
  });
  

  FeedbackModel copyWith({
    int? id,
    int? userId,
    int? solutionId,
    bool? isPublic,
    String? comment,
    String? createdAt,
    String? modifiedAt,
    UserModelResponse? user,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      solutionId: solutionId ?? this.solutionId,
      isPublic: isPublic ?? this.isPublic,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'solutionId': solutionId,
      'isPublic': isPublic,
      'comment': comment,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'user': user?.toMap(),
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      solutionId: map['solutionId'] != null ? map['solutionId'] as int : null,
      isPublic: map['isPublic'] != null ? map['isPublic'] as bool : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      modifiedAt: map['modifiedAt'] != null ? map['modifiedAt'] as String : null,
      user: map['user'] != null ? UserModelResponse.fromMap(map['user'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackModel.fromJson(String source) => FeedbackModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedbackModel(id: $id, userId: $userId, solutionId: $solutionId, isPublic: $isPublic, comment: $comment, createdAt: $createdAt, modifiedAt: $modifiedAt, user: $user)';
  }

  @override
  bool operator ==(covariant FeedbackModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userId == userId &&
      other.solutionId == solutionId &&
      other.isPublic == isPublic &&
      other.comment == comment &&
      other.createdAt == createdAt &&
      other.modifiedAt == modifiedAt &&
      other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      solutionId.hashCode ^
      isPublic.hashCode ^
      comment.hashCode ^
      createdAt.hashCode ^
      modifiedAt.hashCode ^
      user.hashCode;
  }
}
