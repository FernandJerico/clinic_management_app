import 'package:clinic_management_app/core/extensions/int_ext.dart';

class ProductModel {
  final String image;
  final String name;
  final String category;
  final int price;
  final int stock;

  ProductModel({
    required this.image,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
  });

  String get priceFormat => price.currencyFormatRp;
}
