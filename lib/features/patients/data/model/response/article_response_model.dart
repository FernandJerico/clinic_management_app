import 'dart:convert';

class ArticleResponseModel {
  final bool? success;
  final String? message;
  final List<Article>? data;

  ArticleResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory ArticleResponseModel.fromJson(String str) =>
      ArticleResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticleResponseModel.fromMap(Map<String, dynamic> json) =>
      ArticleResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Article>.from(json["data"]!.map((x) => Article.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Article {
  final int? id;
  final int? categoryId;
  final String? title;
  final String? content;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;

  Article({
    this.id,
    this.categoryId,
    this.title,
    this.content,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory Article.fromJson(String str) => Article.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Article.fromMap(Map<String, dynamic> json) => Article(
        id: json["id"],
        categoryId: json["category_id"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        category: json["category"] == null
            ? null
            : Category.fromMap(json["category"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "content": content,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category?.toMap(),
      };
}

class Category {
  final int? id;
  final String? name;
  final String? description;
  final dynamic createdAt;
  final dynamic updatedAt;

  Category({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
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
