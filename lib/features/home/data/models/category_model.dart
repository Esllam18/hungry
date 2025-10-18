class CategoryModel {
  final int id;
  final String name;
  final String? image;
  final String? description;

  CategoryModel({
    required this.id,
    required this.name,
    this.image,
    this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString(),
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'description': description};
  }
}
