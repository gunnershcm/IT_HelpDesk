class CategoryResponseModel {
  int? id;
  String? name;
  String? description;

  CategoryResponseModel({
    this.id,
    this.name,
    this.description,
  });

  factory CategoryResponseModel.fromMap(Map<String, dynamic> json) => CategoryResponseModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
