import 'dart:convert';

class ArticleCategoryResponseModel {
  final bool? success;
  final String? message;
  final List<ArticleCategory>? data;

  ArticleCategoryResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory ArticleCategoryResponseModel.fromJson(String str) =>
      ArticleCategoryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticleCategoryResponseModel.fromMap(Map<String, dynamic> json) =>
      ArticleCategoryResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ArticleCategory>.from(
                json["data"]!.map((x) => ArticleCategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class ArticleCategory {
  final int? id;
  final String? name;
  final String? description;
  final dynamic createdAt;
  final dynamic updatedAt;

  ArticleCategory({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory ArticleCategory.fromJson(String str) =>
      ArticleCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticleCategory.fromMap(Map<String, dynamic> json) => ArticleCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
