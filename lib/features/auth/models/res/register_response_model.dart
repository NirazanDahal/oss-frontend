class RegisterResponseModel {
  final bool success;
  final Data data;

  RegisterResponseModel({required this.success, required this.data});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'] ?? false,
      data: json['data'],
    );
  }
}

class Data {
  final String id;
  final String name;
  final String email;

  Data({required this.id, required this.name, required this.email});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] ?? 'N/A',
      name: json['name'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
    );
  }
}
