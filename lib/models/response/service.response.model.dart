class ServiceResponseModel {
  int? id;
  String? type;
  //int? amount;
  String? description;

  ServiceResponseModel({
    this.id,
    this.type,
    //this.amount,
    this.description,
  });

  factory ServiceResponseModel.fromMap(Map<String, dynamic> json) => ServiceResponseModel(
        id: json["id"] ?? 0,
        type: json["type"] ?? "",
        //amount: json["amount"] ?? "",
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        //"amount": amount,
        "description": description,
      };
}
