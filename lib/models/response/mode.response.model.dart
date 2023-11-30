class ModeResponseModel {
  int? id;
  String? name;
  String? description;

  ModeResponseModel({
    this.id,
    this.name,
    this.description,
  });

  factory ModeResponseModel.fromMap(Map<String, dynamic> json) => ModeResponseModel(
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
