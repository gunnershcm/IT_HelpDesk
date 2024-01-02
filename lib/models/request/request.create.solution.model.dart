// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class RequestCreateSolutionModel {
  String? title;
  String? content;
  int? categoryId;
  int? ownerId;
  String? reviewDate;
  String? expiredDate;
  String? keyword;
  String? internalComments;
  bool? isPublic;
  List<String>? attachmentUrl;
  RequestCreateSolutionModel({
    this.title,
    this.content,
    this.categoryId,
    this.ownerId,
    this.reviewDate,
    this.expiredDate,
    this.keyword,
    this.internalComments,
    this.isPublic,
    this.attachmentUrl,
  });


  RequestCreateSolutionModel copyWith({
    String? title,
    String? content,
    int? categoryId,
    int? ownerId,
    String? reviewDate,
    String? expiredDate,
    String? keyword,
    String? internalComments,
    bool? isPublic,
    List<String>? attachmentUrl,
  }) {
    return RequestCreateSolutionModel(
      title: title ?? this.title,
      content: content ?? this.content,
      categoryId: categoryId ?? this.categoryId,
      ownerId: ownerId ?? this.ownerId,
      reviewDate: reviewDate ?? this.reviewDate,
      expiredDate: expiredDate ?? this.expiredDate,
      keyword: keyword ?? this.keyword,
      internalComments: internalComments ?? this.internalComments,
      isPublic: isPublic ?? this.isPublic,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'categoryId': categoryId,
      'ownerId': ownerId,
      'reviewDate': reviewDate,
      'expiredDate': expiredDate,
      'keyword': keyword,
      'internalComments': internalComments,
      'isPublic': isPublic,
      'attachmentUrl': attachmentUrl,
    };
  }

  factory RequestCreateSolutionModel.fromMap(Map<String, dynamic> map) {
    return RequestCreateSolutionModel(
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      ownerId: map['ownerId'] != null ? map['ownerId'] as int : null,
      reviewDate: map['reviewDate'] != null ? map['reviewDate'] as String : null,
      expiredDate: map['expiredDate'] != null ? map['expiredDate'] as String : null,
      keyword: map['keyword'] != null ? map['keyword'] as String : null,
      internalComments: map['internalComments'] != null ? map['internalComments'] as String : null,
      isPublic: map['isPublic'] != null ? map['isPublic'] as bool : null,
      attachmentUrl: map['attachmentUrl'] != null ? List<String>.from((map['attachmentUrl'] as List<String>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestCreateSolutionModel.fromJson(String source) => RequestCreateSolutionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestCreateSolutionModel(title: $title, content: $content, categoryId: $categoryId, ownerId: $ownerId, reviewDate: $reviewDate, expiredDate: $expiredDate, keyword: $keyword, internalComments: $internalComments, isPublic: $isPublic, attachmentUrl: $attachmentUrl)';
  }

  @override
  bool operator ==(covariant RequestCreateSolutionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.content == content &&
      other.categoryId == categoryId &&
      other.ownerId == ownerId &&
      other.reviewDate == reviewDate &&
      other.expiredDate == expiredDate &&
      other.keyword == keyword &&
      other.internalComments == internalComments &&
      other.isPublic == isPublic &&
      listEquals(other.attachmentUrl, attachmentUrl);
  }

  @override
  int get hashCode {
    return title.hashCode ^
      content.hashCode ^
      categoryId.hashCode ^
      ownerId.hashCode ^
      reviewDate.hashCode ^
      expiredDate.hashCode ^
      keyword.hashCode ^
      internalComments.hashCode ^
      isPublic.hashCode ^
      attachmentUrl.hashCode;
  }
}
