class ProfileResponseModel {
  final bool success;
  final UserProfile userProfile;

  ProfileResponseModel({required this.success, required this.userProfile});

  factory ProfileResponseModel.formJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      success: json['success'],
      userProfile: UserProfile.formJson(json['user']),
    );
  }
}

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.formJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'] ?? 'N/A',
      name: json['name'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      role: json['role'] ?? 'N/A',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
