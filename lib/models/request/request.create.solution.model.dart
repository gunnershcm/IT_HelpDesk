// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class RequestCreateSolutionModel {
  String? title;
  String? content;
  int? categoryId;
  int? ownerId;
  String? expiredDate;
  String? keyword;
  List<String>? attachmentUrls;
  RequestCreateSolutionModel({
    this.title,
    this.content,
    this.categoryId,
    this.ownerId,
    this.expiredDate,
    this.keyword,
    this.attachmentUrls,
  });
  

  RequestCreateSolutionModel copyWith({
    String? title,
    String? content,
    int? categoryId,
    int? ownerId,
    String? expiredDate,
    String? keyword,
    List<String>? attachmentUrls,
  }) {
    return RequestCreateSolutionModel(
      title: title ?? this.title,
      content: content ?? this.content,
      categoryId: categoryId ?? this.categoryId,
      ownerId: ownerId ?? this.ownerId,
      expiredDate: expiredDate ?? this.expiredDate,
      keyword: keyword ?? this.keyword,
      attachmentUrls: attachmentUrls ?? this.attachmentUrls,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'categoryId': categoryId,
      'ownerId': ownerId,
      'expiredDate': expiredDate,
      'keyword': keyword,
      'attachmentUrls': attachmentUrls,
    };
  }

  factory RequestCreateSolutionModel.fromMap(Map<String, dynamic> map) {
    return RequestCreateSolutionModel(
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      ownerId: map['ownerId'] != null ? map['ownerId'] as int : null,
      expiredDate: map['expiredDate'] != null ? map['expiredDate'] as String : null,
      keyword: map['keyword'] != null ? map['keyword'] as String : null,
      attachmentUrls: map['attachmentUrls'] != null ? List<String>.from(map['attachmentUrls']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestCreateSolutionModel.fromJson(String source) => RequestCreateSolutionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestCreateSolutionModel(title: $title, content: $content, categoryId: $categoryId, ownerId: $ownerId, expiredDate: $expiredDate, keyword: $keyword, attachmentUrls: $attachmentUrls)';
  }

  @override
  bool operator ==(covariant RequestCreateSolutionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.content == content &&
      other.categoryId == categoryId &&
      other.ownerId == ownerId &&
      other.expiredDate == expiredDate &&
      other.keyword == keyword &&
      listEquals(other.attachmentUrls, attachmentUrls);
  }

  @override
  int get hashCode {
    return title.hashCode ^
      content.hashCode ^
      categoryId.hashCode ^
      ownerId.hashCode ^
      expiredDate.hashCode ^
      keyword.hashCode ^
      attachmentUrls.hashCode;
  }
}
