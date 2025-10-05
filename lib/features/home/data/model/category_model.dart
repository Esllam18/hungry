class Category {
  final String id;
  final String name;
  final String imageUrl;
  final DateTime? createdAt;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.createdAt,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'].toString(),
      name: map['name'] as String,
      imageUrl: map['image_url'] as String,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : null,
    );
  }
}
