import 'dart:io';

class ServiceMedicinesRequestModel {
  String? name;
  String? category;
  String? price;
  String? quantity;
  File? photo;

  ServiceMedicinesRequestModel({
    this.name,
    this.category,
    this.price,
    this.quantity,
    this.photo,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'quantity': quantity,
      'photo': photo?.path,
    };
  }

  factory ServiceMedicinesRequestModel.fromJson(Map<String, dynamic> json) {
    return ServiceMedicinesRequestModel(
      name: json['name'],
      category: json['category'],
      price: json['price'],
      quantity: json['quantity'],
      photo: json['photo'] != null ? File(json['photo']) : null,
    );
  }
}
