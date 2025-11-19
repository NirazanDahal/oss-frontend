class RegisterResponseModel {
  final bool success;
  final User user;

  RegisterResponseModel({required this.success, required this.user});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'] ?? false,
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 'N/A',
      name: json['name'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
    );
  }
}
