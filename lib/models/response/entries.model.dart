class EntriesModel {
  int? id;
  String? message;

  EntriesModel({
    this.id,
    this.message,
  });

  factory EntriesModel.fromMap(Map<String, dynamic> json) => EntriesModel(
        id: json["id"] ?? 0,
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "message": message,
      };
}
