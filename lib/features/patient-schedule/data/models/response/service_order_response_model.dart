import 'dart:convert';

class ServiceOrderResponseModel {
  final String? status;
  final String? message;
  final List<ServiceOrder>? data;

  ServiceOrderResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory ServiceOrderResponseModel.fromJson(String str) =>
      ServiceOrderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceOrderResponseModel.fromMap(Map<String, dynamic> json) =>
      ServiceOrderResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ServiceOrder>.from(
                json["data"]!.map((x) => ServiceOrder.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class ServiceOrder {
  final int? id;
  final int? quantity;
  final String? name;
  final int? price;
  final int? total;

  ServiceOrder({
    this.id,
    this.quantity,
    this.name,
    this.price,
    this.total,
  });

  factory ServiceOrder.fromJson(String str) =>
      ServiceOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceOrder.fromMap(Map<String, dynamic> json) => ServiceOrder(
        id: json["id"],
        quantity: json["quantity"],
        name: json["name"],
        price: json["price"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "quantity": quantity,
        "name": name,
        "price": price,
        "total": total,
      };
}
