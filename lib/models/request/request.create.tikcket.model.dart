// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestCreateTicketModel {
  int? id;
  String? title;
  String? description;
  int? serviceId;
  String? type;
  String? street;
  int? priority;
  int? ward;
  int? district;
  int? city;
  String? attachmentUrl;
  RequestCreateTicketModel({
    this.id,
    this.title,
    this.description,
    this.serviceId,
    this.type,
    this.street,
    this.priority,
    this.ward,
    this.district,
    this.city,
    this.attachmentUrl,
  });


  RequestCreateTicketModel copyWith({
    int? id,
    String? title,
    String? description,
    int? serviceId,
    String? type,
    String? street,
    int? priority,
    int? ward,
    int? district,
    int? city,
    String? attachmentUrl,
  }) {
    return RequestCreateTicketModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      serviceId: serviceId ?? this.serviceId,
      type: type ?? this.type,
      street: street ?? this.street,
      priority: priority ?? this.priority,
      ward: ward ?? this.ward,
      district: district ?? this.district,
      city: city ?? this.city,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'serviceId': serviceId,
      'type': type,
      'street': street,
      'priority': priority,
      'ward': ward,
      'district': district,
      'city': city,
      'attachmentUrl': attachmentUrl,
    };
  }

  factory RequestCreateTicketModel.fromMap(Map<String, dynamic> map) {
    return RequestCreateTicketModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      serviceId: map['serviceId'] != null ? map['serviceId'] as int : null,
      type: map['type'] != null ? map['type'] as String : null,
      street: map['street'] != null ? map['street'] as String : null,
      priority: map['priority'] != null ? map['priority'] as int : null,
      ward: map['ward'] != null ? map['ward'] as int : null,
      district: map['district'] != null ? map['district'] as int : null,
      city: map['city'] != null ? map['city'] as int : null,
      attachmentUrl: map['attachmentUrl'] != null ? map['attachmentUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestCreateTicketModel.fromJson(String source) => RequestCreateTicketModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestCreateTicketModel(id: $id, title: $title, description: $description, serviceId: $serviceId, type: $type, street: $street, priority: $priority, ward: $ward, district: $district, city: $city, attachmentUrl: $attachmentUrl)';
  }

  @override
  bool operator ==(covariant RequestCreateTicketModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.serviceId == serviceId &&
      other.type == type &&
      other.street == street &&
      other.priority == priority &&
      other.ward == ward &&
      other.district == district &&
      other.city == city &&
      other.attachmentUrl == attachmentUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      serviceId.hashCode ^
      type.hashCode ^
      street.hashCode ^
      priority.hashCode ^
      ward.hashCode ^
      district.hashCode ^
      city.hashCode ^
      attachmentUrl.hashCode;
  }
}
