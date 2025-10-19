// user_model.dart (updated address to nullable)
class UserModel {
  final String name;
  final String email;
  final String? image;
  final String? token;
  final String? address;
  final String? visa;

  UserModel({
    required this.name,
    required this.email,
    this.image,
    this.token,
    this.address,
    this.visa,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? <String, dynamic>{};

    return UserModel(
      name:
          data['name']?.toString() ??
          '', // Fallback to empty string if null; customize as needed (e.g., throw Exception).
      email: data['email']?.toString() ?? '',
      image: data['image']?.toString(),
      token: data['token']?.toString(),
      address: data['address']?.toString(),
      visa: data['Visa']
          ?.toString(), // Note: API uses 'Visa' (capital V); adjust if lowercase.
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'token': token,
      'address': address,
      'Visa': visa, // Match API casing for serialization.
    };
  }
}
