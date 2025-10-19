// user_model.dart (updated with HTTPS fix)
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

  /// Helper method to convert http to https
  static String? _ensureHttps(String? url) {
    if (url == null || url.isEmpty) return url;
    if (url.startsWith('http://')) {
      return url.replaceFirst('http://', 'https://');
    }
    return url;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? <String, dynamic>{};

    return UserModel(
      name: data['name']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
      image: _ensureHttps(data['image']?.toString()),
      token: data['token']?.toString(),
      address: data['address']?.toString(),
      visa: data['Visa']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'token': token,
      'address': address,
      'Visa': visa,
    };
  }

  /// Create a copy with updated fields
  UserModel copyWith({
    String? name,
    String? email,
    String? image,
    String? token,
    String? address,
    String? visa,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      token: token ?? this.token,
      address: address ?? this.address,
      visa: visa ?? this.visa,
    );
  }
}
