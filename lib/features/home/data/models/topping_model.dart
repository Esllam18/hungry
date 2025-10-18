class ToppingModel {
  final int id;
  final String name;
  final double price;
  final String? image;

  ToppingModel({
    required this.id,
    required this.name,
    required this.price,
    this.image,
  });

  factory ToppingModel.fromJson(Map<String, dynamic> json) {
    return ToppingModel(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      price: _parsePrice(json['price']),
      image: json['image']?.toString(),
    );
  }

  static double _parsePrice(dynamic price) {
    if (price == null) return 0.0;
    if (price is double) return price;
    if (price is int) return price.toDouble();
    if (price is String) return double.tryParse(price) ?? 0.0;
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'price': price, 'image': image};
  }
}

class SideOptionModel {
  final int id;
  final String name;
  final double price;
  final String? image;

  SideOptionModel({
    required this.id,
    required this.name,
    required this.price,
    this.image,
  });

  factory SideOptionModel.fromJson(Map<String, dynamic> json) {
    return SideOptionModel(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      price: _parsePrice(json['price']),
      image: json['image']?.toString(),
    );
  }

  static double _parsePrice(dynamic price) {
    if (price == null) return 0.0;
    if (price is double) return price;
    if (price is int) return price.toDouble();
    if (price is String) return double.tryParse(price) ?? 0.0;
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'price': price, 'image': image};
  }
}
