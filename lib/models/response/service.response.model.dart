class ServiceResponseModel {
  int? id;
  String? description;

  ServiceResponseModel({
    this.id,
    this.description,
  });

  factory ServiceResponseModel.fromMap(Map<String, dynamic> json) =>
      ServiceResponseModel(
        id: json["id"] ?? 0,
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
      };
}
