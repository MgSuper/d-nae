import 'dart:convert';

List<Coffee> coffeeFromJson(String str) =>
    List<Coffee>.from(json.decode(str).map((x) => Coffee.fromJson(x)));

String coffeeToJson(List<Coffee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Coffee {
  final String id;
  final String name;
  final String title;
  final String category;
  final List<String> imageUrl;
  final String oldPrice;
  final List<dynamic> sizes;
  final String price;
  final String description;

  Coffee({
    required this.id,
    required this.name,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.sizes,
    required this.price,
    required this.description,
  });

  factory Coffee.fromJson(Map<String, dynamic> json) => Coffee(
        id: json["_id"],
        name: json["name"],
        title: json["title"],
        category: json["category"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        oldPrice: json["oldPrice"],
        sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
        price: json["price"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "title": title,
        "category": category,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "oldPrice": oldPrice,
        "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
        "price": price,
        "description": description,
      };
}

class Sizes {
  final String size;
  final bool isSelected;
  final String id;

  Sizes({
    required this.size,
    required this.isSelected,
    required this.id,
  });

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
        size: json["size"],
        isSelected: json["isSelected"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "isSelected": isSelected,
        "_id": id,
      };
}
