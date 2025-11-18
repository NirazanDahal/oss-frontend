import 'package:equatable/equatable.dart';

class ProfileResponse extends Equatable {
  final bool success;
  final UserProfile? user;
  final String? error;

  const ProfileResponse({
    required this.success,
    this.user,
    this.error,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      success: json['success'] as bool,
      user: json['user'] != null
          ? UserProfile.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      error: json['error'] as String?,
    );
  }

  @override
  List<Object?> get props => [success, user, error];
}

class UserProfile extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, name, email, role, createdAt, updatedAt];
}